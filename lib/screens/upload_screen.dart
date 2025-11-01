import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import '../services/upload_service.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final UploadService _uploadService = UploadService();
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();

  File? _audioFile;
  File? _artworkFile;
  String? _selectedGenre;
  bool _isUploading = false;
  double _uploadProgress = 0.0;
  String _uploadStatus = '';

  final List<String> _genres = [
    'Electronic',
    'Indie',
    'Hip-Hop',
    'Lo-Fi',
    'Rock',
    'Pop',
    'Jazz',
    'Classical',
    'R&B',
    'Country',
  ];

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  Future<void> _pickAudioFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['mp3', 'wav', 'flac', 'm4a'],
      );

      if (result != null && result.files.single.path != null) {
        setState(() {
          _audioFile = File(result.files.single.path!);
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to pick audio file: $e')),
        );
      }
    }
  }

  Future<void> _pickArtworkImage() async {
    try {
      final picker = ImagePicker();
      final image = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1000,
        maxHeight: 1000,
        imageQuality: 85,
      );

      if (image != null) {
        setState(() {
          _artworkFile = File(image.path);
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to pick image: $e')),
        );
      }
    }
  }

  Future<void> _uploadTrack() async {
    if (!_formKey.currentState!.validate()) return;

    if (_audioFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an audio file')),
      );
      return;
    }

    if (_artworkFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select artwork')),
      );
      return;
    }

    if (_selectedGenre == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a genre')),
      );
      return;
    }

    setState(() {
      _isUploading = true;
      _uploadProgress = 0.0;
      _uploadStatus = 'Preparing upload...';
    });

    try {
      final trackId = DateTime.now().millisecondsSinceEpoch.toString();

      // Upload artwork
      setState(() => _uploadStatus = 'Uploading artwork...');
      final artworkUrl = await _uploadService.uploadArtworkFile(
        _artworkFile!,
        trackId,
        onProgress: (progress) {
          setState(() => _uploadProgress = progress * 0.3);
        },
      );

      // Upload audio
      setState(() => _uploadStatus = 'Uploading audio...');
      final audioUrl = await _uploadService.uploadAudioFile(
        _audioFile!,
        trackId,
        onProgress: (progress) {
          setState(() => _uploadProgress = 0.3 + (progress * 0.6));
        },
      );

      // Create track document
      setState(() => _uploadStatus = 'Creating track...');
      // TODO: Get actual audio duration (for MVP, use placeholder)
      final duration = 180; // 3 minutes placeholder

      await _uploadService.createTrack(
        title: _titleController.text.trim(),
        genre: _selectedGenre!,
        audioUrl: audioUrl,
        artworkUrl: artworkUrl,
        duration: duration,
      );

      setState(() {
        _uploadProgress = 1.0;
        _uploadStatus = 'Upload complete!';
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Track uploaded successfully!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.of(context).pop();
      }
    } catch (e) {
      setState(() {
        _isUploading = false;
        _uploadProgress = 0.0;
        _uploadStatus = '';
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Upload failed: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Track'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Artwork picker
              GestureDetector(
                onTap: _isUploading ? null : _pickArtworkImage,
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: _artworkFile != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(
                            _artworkFile!,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.image,
                              size: 64,
                              color: Colors.grey[400],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Tap to select artwork',
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ],
                        ),
                ),
              ),
              const SizedBox(height: 24),

              // Title field
              TextFormField(
                controller: _titleController,
                enabled: !_isUploading,
                decoration: const InputDecoration(
                  labelText: 'Track Title',
                  prefixIcon: Icon(Icons.music_note),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a track title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Genre dropdown
              DropdownButtonFormField<String>(
                initialValue: _selectedGenre,
                decoration: const InputDecoration(
                  labelText: 'Genre',
                  prefixIcon: Icon(Icons.category),
                ),
                items: _genres.map((genre) {
                  return DropdownMenuItem(
                    value: genre,
                    child: Text(genre),
                  );
                }).toList(),
                onChanged: _isUploading
                    ? null
                    : (value) {
                        setState(() => _selectedGenre = value);
                      },
                validator: (value) {
                  if (value == null) {
                    return 'Please select a genre';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // Audio file picker button
              OutlinedButton.icon(
                onPressed: _isUploading ? null : _pickAudioFile,
                icon: const Icon(Icons.audiotrack),
                label: Text(
                  _audioFile != null
                      ? 'Audio: ${_audioFile!.path.split('/').last}'
                      : 'Select Audio File',
                ),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                ),
              ),
              const SizedBox(height: 32),

              // Upload progress
              if (_isUploading) ...[
                LinearProgressIndicator(
                  value: _uploadProgress,
                  backgroundColor: Colors.grey[300],
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    Color(0xFF5C9DFF),
                  ),
                  minHeight: 8,
                ),
                const SizedBox(height: 8),
                Text(
                  _uploadStatus,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[600]),
                ),
                const SizedBox(height: 16),
              ],

              // Upload button
              ElevatedButton(
                onPressed: _isUploading ? null : _uploadTrack,
                child: _isUploading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const Text('Upload Track'),
              ),

              const SizedBox(height: 16),

              // Guidelines
              Card(
                color: Colors.blue[50],
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.info_outline, color: Color(0xFF5C9DFF)),
                          SizedBox(width: 8),
                          Text(
                            'Upload Guidelines',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '• Audio: MP3, WAV, FLAC, or M4A (max 50MB)\n'
                        '• Artwork: JPG or PNG (recommended 1000x1000px)\n'
                        '• All tracks are free for MVP\n'
                        '• Track will be visible immediately after upload',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
