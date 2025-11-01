import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import '../services/audio_player_service.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({super.key});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  final AudioPlayerService _audioService = AudioPlayerService();

  @override
  Widget build(BuildContext context) {
    final track = _audioService.currentTrack;
    if (track == null) {
      Navigator.of(context).pop();
      return const SizedBox.shrink();
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF2F5FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.keyboard_arrow_down),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // TODO: Show track options menu (M4-M6)
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const Spacer(),

              // Artwork
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: track.artworkUrl.isNotEmpty
                    ? Image.network(
                        track.artworkUrl,
                        width: 300,
                        height: 300,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return _buildPlaceholderArtwork();
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return _buildPlaceholderArtwork();
                        },
                      )
                    : _buildPlaceholderArtwork(),
              ),
              const SizedBox(height: 40),

              // Track info
              Text(
                track.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Text(
                track.artistName,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),

              // Progress bar and time
              StreamBuilder<Duration?>(
                stream: _audioService.durationStream,
                builder: (context, durationSnapshot) {
                  return StreamBuilder<Duration>(
                    stream: _audioService.positionStream,
                    builder: (context, positionSnapshot) {
                      final duration = durationSnapshot.data ?? Duration.zero;
                      final position = positionSnapshot.data ?? Duration.zero;

                      return Column(
                        children: [
                          Slider(
                            value: position.inMilliseconds.toDouble(),
                            max: duration.inMilliseconds.toDouble().clamp(
                                1.0, double.infinity),
                            onChanged: (value) {
                              _audioService.seek(
                                Duration(milliseconds: value.toInt()),
                              );
                            },
                            activeColor: const Color(0xFF5C9DFF),
                            inactiveColor: Colors.grey[300],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _formatDuration(position),
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                                Text(
                                  _formatDuration(duration),
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 24),

              // Playback controls
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Previous button
                  IconButton(
                    icon: const Icon(Icons.skip_previous),
                    iconSize: 48,
                    onPressed: _audioService.hasPrevious
                        ? () => _audioService.previous()
                        : null,
                    color: _audioService.hasPrevious
                        ? const Color(0xFF5C9DFF)
                        : Colors.grey,
                  ),
                  const SizedBox(width: 16),

                  // Play/pause button
                  StreamBuilder<PlayerState>(
                    stream: _audioService.playerStateStream,
                    builder: (context, snapshot) {
                      final playerState = snapshot.data;
                      final processingState =
                          playerState?.processingState ?? ProcessingState.idle;
                      final playing = playerState?.playing ?? false;

                      // Show loading indicator while buffering
                      if (processingState == ProcessingState.loading ||
                          processingState == ProcessingState.buffering) {
                        return Container(
                          width: 72,
                          height: 72,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFF5C9DFF),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                              strokeWidth: 3,
                            ),
                          ),
                        );
                      }

                      return Container(
                        width: 72,
                        height: 72,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF5C9DFF),
                        ),
                        child: IconButton(
                          icon: Icon(
                            playing ? Icons.pause : Icons.play_arrow,
                          ),
                          iconSize: 40,
                          onPressed: () => _audioService.togglePlayPause(),
                          color: Colors.white,
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 16),

                  // Next button
                  IconButton(
                    icon: const Icon(Icons.skip_next),
                    iconSize: 48,
                    onPressed: _audioService.hasNext
                        ? () => _audioService.next()
                        : null,
                    color: _audioService.hasNext
                        ? const Color(0xFF5C9DFF)
                        : Colors.grey,
                  ),
                ],
              ),

              const Spacer(),

              // Error handling
              StreamBuilder<PlayerState>(
                stream: _audioService.playerStateStream,
                builder: (context, snapshot) {
                  final playerState = snapshot.data;
                  final processingState = playerState?.processingState;

                  if (processingState == ProcessingState.idle) {
                    return const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Failed to load track. Check your internet connection.',
                        style: TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholderArtwork() {
    return Container(
      width: 300,
      height: 300,
      decoration: BoxDecoration(
        color: const Color(0xFF5C9DFF).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Center(
        child: Icon(
          Icons.music_note,
          size: 100,
          color: Color(0xFF5C9DFF),
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }
}
