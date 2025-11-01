import 'package:flutter/material.dart';
import '../models/track_model.dart';
import '../services/upload_service.dart';
import '../services/audio_player_service.dart';
import '../widgets/track_card.dart';
import 'upload_screen.dart';

class MyUploadsScreen extends StatefulWidget {
  const MyUploadsScreen({super.key});

  @override
  State<MyUploadsScreen> createState() => _MyUploadsScreenState();
}

class _MyUploadsScreenState extends State<MyUploadsScreen> {
  final UploadService _uploadService = UploadService();
  final AudioPlayerService _audioService = AudioPlayerService();

  List<TrackModel> _tracks = [];
  int _totalStreams = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTracks();
  }

  Future<void> _loadTracks() async {
    setState(() => _isLoading = true);

    try {
      final results = await Future.wait([
        _uploadService.getArtistTracks(),
        _uploadService.getArtistTotalStreams(),
      ]);

      setState(() {
        _tracks = results[0] as List<TrackModel>;
        _totalStreams = results[1] as int;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load tracks: $e')),
        );
      }
    }
  }

  Future<void> _deleteTrack(TrackModel track) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Track'),
        content: Text('Are you sure you want to delete "${track.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    try {
      await _uploadService.deleteTrack(track.trackId);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Track deleted successfully'),
            backgroundColor: Colors.green,
          ),
        );
        _loadTracks();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to delete track: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _showTrackOptions(TrackModel track) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.play_arrow),
              title: const Text('Play'),
              onTap: () {
                Navigator.of(context).pop();
                _audioService.playTrack(track);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: const Text('Delete', style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.of(context).pop();
                _deleteTrack(track);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Uploads'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadTracks,
              child: _tracks.isEmpty
                  ? _buildEmptyState()
                  : CustomScrollView(
                      slivers: [
                        // Stats card
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(24.0),
                                child: Column(
                                  children: [
                                    const Text(
                                      'Total Streams',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      _formatNumber(_totalStreams),
                                      style: const TextStyle(
                                        fontSize: 36,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF5C9DFF),
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${_tracks.length} ${_tracks.length == 1 ? "track" : "tracks"}',
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),

                        // Tracks grid
                        SliverPadding(
                          padding: const EdgeInsets.all(16.0),
                          sliver: SliverGrid(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.75,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                            ),
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                return TrackCard(
                                  track: _tracks[index],
                                  onTap: () => _showTrackOptions(_tracks[index]),
                                );
                              },
                              childCount: _tracks.length,
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const UploadScreen(),
            ),
          );
          _loadTracks();
        },
        icon: const Icon(Icons.add),
        label: const Text('Upload'),
        backgroundColor: const Color(0xFF5C9DFF),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.upload,
              size: 80,
              color: Color(0xFF5C9DFF),
            ),
            const SizedBox(height: 16),
            const Text(
              'No tracks uploaded yet',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Tap the upload button to share your music',
              style: TextStyle(color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  String _formatNumber(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }
    return number.toString();
  }
}
