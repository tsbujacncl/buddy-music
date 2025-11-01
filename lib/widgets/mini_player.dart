import 'package:flutter/material.dart';
import '../services/audio_player_service.dart';
import '../screens/player_screen.dart';

class MiniPlayer extends StatelessWidget {
  final AudioPlayerService audioService = AudioPlayerService();

  MiniPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    final track = audioService.currentTrack;
    if (track == null) return const SizedBox.shrink();

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const PlayerScreen(),
          ),
        );
      },
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Column(
          children: [
            // Progress indicator
            StreamBuilder<Duration?>(
              stream: audioService.durationStream,
              builder: (context, durationSnapshot) {
                return StreamBuilder<Duration>(
                  stream: audioService.positionStream,
                  builder: (context, positionSnapshot) {
                    final duration = durationSnapshot.data ?? Duration.zero;
                    final position = positionSnapshot.data ?? Duration.zero;
                    final progress = duration.inMilliseconds > 0
                        ? position.inMilliseconds / duration.inMilliseconds
                        : 0.0;

                    return LinearProgressIndicator(
                      value: progress,
                      backgroundColor: Colors.grey[300],
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Color(0xFF5C9DFF),
                      ),
                      minHeight: 2,
                    );
                  },
                );
              },
            ),

            // Player controls
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    // Artwork
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: track.artworkUrl.isNotEmpty
                          ? Image.network(
                              track.artworkUrl,
                              width: 48,
                              height: 48,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return _buildPlaceholderArtwork();
                              },
                            )
                          : _buildPlaceholderArtwork(),
                    ),
                    const SizedBox(width: 12),

                    // Track info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            track.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            track.artistName,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),

                    // Previous button
                    IconButton(
                      icon: const Icon(Icons.skip_previous),
                      onPressed: audioService.hasPrevious
                          ? () => audioService.previous()
                          : null,
                      color: const Color(0xFF5C9DFF),
                    ),

                    // Play/pause button
                    StreamBuilder<bool>(
                      stream: audioService.playingStream,
                      builder: (context, snapshot) {
                        final isPlaying = snapshot.data ?? false;
                        return IconButton(
                          icon: Icon(
                            isPlaying ? Icons.pause : Icons.play_arrow,
                          ),
                          onPressed: () => audioService.togglePlayPause(),
                          iconSize: 32,
                          color: const Color(0xFF5C9DFF),
                        );
                      },
                    ),

                    // Next button
                    IconButton(
                      icon: const Icon(Icons.skip_next),
                      onPressed: audioService.hasNext
                          ? () => audioService.next()
                          : null,
                      color: const Color(0xFF5C9DFF),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholderArtwork() {
    return Container(
      width: 48,
      height: 48,
      color: const Color(0xFF5C9DFF).withValues(alpha: 0.1),
      child: const Icon(
        Icons.music_note,
        color: Color(0xFF5C9DFF),
        size: 24,
      ),
    );
  }
}
