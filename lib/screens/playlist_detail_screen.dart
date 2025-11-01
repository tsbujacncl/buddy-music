import 'package:flutter/material.dart';
import '../models/playlist_model.dart';
import '../models/track_model.dart';
import '../services/playlist_service.dart';
import '../services/track_service.dart';
import '../services/audio_player_service.dart';

class PlaylistDetailScreen extends StatefulWidget {
  final String playlistId;

  const PlaylistDetailScreen({
    super.key,
    required this.playlistId,
  });

  @override
  State<PlaylistDetailScreen> createState() => _PlaylistDetailScreenState();
}

class _PlaylistDetailScreenState extends State<PlaylistDetailScreen> {
  final PlaylistService _playlistService = PlaylistService();
  final TrackService _trackService = TrackService();
  final AudioPlayerService _audioService = AudioPlayerService();

  PlaylistModel? _playlist;
  List<TrackModel> _tracks = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPlaylist();
  }

  Future<void> _loadPlaylist() async {
    setState(() => _isLoading = true);

    try {
      final playlist = await _playlistService.getPlaylistById(widget.playlistId);
      if (playlist == null) {
        throw Exception('Playlist not found');
      }

      // Load all tracks
      final List<TrackModel> tracks = [];
      for (final trackId in playlist.trackIds) {
        try {
          final track = await _trackService.getTrackById(trackId);
          if (track != null) {
            tracks.add(track);
          }
        } catch (e) {
          // Track might have been deleted, skip it
        }
      }

      setState(() {
        _playlist = playlist;
        _tracks = tracks;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load playlist: $e')),
        );
        Navigator.of(context).pop();
      }
    }
  }

  Future<void> _removeTrack(TrackModel track) async {
    try {
      await _playlistService.removeTrackFromPlaylist(
        playlistId: widget.playlistId,
        trackId: track.trackId,
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Track removed from playlist'),
            backgroundColor: Colors.green,
          ),
        );
        _loadPlaylist();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to remove track: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _playAll() {
    if (_tracks.isEmpty) return;
    _audioService.playPlaylist(_tracks, 0);
    _trackService.incrementStreamCount(_tracks[0].trackId);
  }

  void _shufflePlay() {
    if (_tracks.isEmpty) return;
    final shuffled = List<TrackModel>.from(_tracks)..shuffle();
    _audioService.playPlaylist(shuffled, 0);
    _trackService.incrementStreamCount(shuffled[0].trackId);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_playlist == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: Text('Playlist not found')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_playlist!.name),
      ),
      body: Column(
        children: [
          // Playlist header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xFF5C9DFF).withValues(alpha: 0.1),
                  Colors.transparent,
                ],
              ),
            ),
            child: Column(
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: const Color(0xFF5C9DFF).withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.playlist_play,
                    size: 64,
                    color: Color(0xFF5C9DFF),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  _playlist!.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  '${_tracks.length} ${_tracks.length == 1 ? "track" : "tracks"}',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 16),
                // Play buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: _tracks.isEmpty ? null : _playAll,
                      icon: const Icon(Icons.play_arrow),
                      label: const Text('Play All'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF5C9DFF),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    OutlinedButton.icon(
                      onPressed: _tracks.isEmpty ? null : _shufflePlay,
                      icon: const Icon(Icons.shuffle),
                      label: const Text('Shuffle'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF5C9DFF),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Tracks list
          Expanded(
            child: _tracks.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    itemCount: _tracks.length,
                    itemBuilder: (context, index) {
                      return _buildTrackTile(_tracks[index], index);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrackTile(TrackModel track, int index) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: track.artworkUrl.isNotEmpty
            ? Image.network(
                track.artworkUrl,
                width: 56,
                height: 56,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return _buildPlaceholderArtwork();
                },
              )
            : _buildPlaceholderArtwork(),
      ),
      title: Text(
        track.title,
        style: const TextStyle(fontWeight: FontWeight.w500),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        track.artistName,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: IconButton(
        icon: const Icon(Icons.more_vert),
        onPressed: () => _showTrackOptions(track),
      ),
      onTap: () {
        _audioService.playPlaylist(_tracks, index);
        _trackService.incrementStreamCount(track.trackId);
      },
    );
  }

  Widget _buildPlaceholderArtwork() {
    return Container(
      width: 56,
      height: 56,
      color: const Color(0xFF5C9DFF).withValues(alpha: 0.1),
      child: const Icon(
        Icons.music_note,
        size: 28,
        color: Color(0xFF5C9DFF),
      ),
    );
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
                final index = _tracks.indexOf(track);
                _audioService.playPlaylist(_tracks, index);
                _trackService.incrementStreamCount(track.trackId);
              },
            ),
            ListTile(
              leading: const Icon(Icons.remove_circle, color: Colors.red),
              title: const Text(
                'Remove from playlist',
                style: TextStyle(color: Colors.red),
              ),
              onTap: () {
                Navigator.of(context).pop();
                _removeTrack(track);
              },
            ),
          ],
        ),
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
            Icon(
              Icons.music_note,
              size: 80,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            const Text(
              'No tracks in this playlist',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Add tracks from the track menu',
              style: TextStyle(color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
