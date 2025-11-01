import 'package:flutter/material.dart';
import '../models/playlist_model.dart';
import '../models/track_model.dart';
import '../services/playlist_service.dart';

class AddToPlaylistDialog {
  static Future<void> show({
    required BuildContext context,
    required TrackModel track,
  }) async {
    final playlistService = PlaylistService();

    // Load user's playlists
    final playlists = await playlistService.getUserPlaylists();

    if (!context.mounted) return;

    if (playlists.isEmpty) {
      // No playlists, offer to create one
      final create = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('No Playlists'),
          content: const Text(
            'You don\'t have any playlists yet. Would you like to create one?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Create Playlist'),
            ),
          ],
        ),
      );

      if (create == true && context.mounted) {
        await _createAndAddToPlaylist(context, track, playlistService);
      }
      return;
    }

    // Show playlist selection
    await showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Add to Playlist',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Divider(height: 1),
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: playlists.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    // Create new playlist option
                    return ListTile(
                      leading: const Icon(
                        Icons.add,
                        color: Color(0xFF5C9DFF),
                      ),
                      title: const Text(
                        'Create new playlist',
                        style: TextStyle(
                          color: Color(0xFF5C9DFF),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onTap: () async {
                        Navigator.of(context).pop();
                        await _createAndAddToPlaylist(
                          context,
                          track,
                          playlistService,
                        );
                      },
                    );
                  }

                  final playlist = playlists[index - 1];
                  final alreadyInPlaylist =
                      playlist.trackIds.contains(track.trackId);

                  return ListTile(
                    leading: Icon(
                      alreadyInPlaylist ? Icons.check : Icons.playlist_play,
                      color:
                          alreadyInPlaylist ? Colors.green : Color(0xFF5C9DFF),
                    ),
                    title: Text(playlist.name),
                    subtitle: Text(
                      '${playlist.trackCount} ${playlist.trackCount == 1 ? "track" : "tracks"}',
                    ),
                    trailing: alreadyInPlaylist
                        ? const Icon(Icons.check, color: Colors.green)
                        : null,
                    enabled: !alreadyInPlaylist,
                    onTap: alreadyInPlaylist
                        ? null
                        : () async {
                            Navigator.of(context).pop();
                            await _addToPlaylist(
                              context,
                              track,
                              playlist,
                              playlistService,
                            );
                          },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Future<void> _createAndAddToPlaylist(
    BuildContext context,
    TrackModel track,
    PlaylistService playlistService,
  ) async {
    final nameController = TextEditingController();

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create Playlist'),
        content: TextField(
          controller: nameController,
          autofocus: true,
          decoration: const InputDecoration(
            labelText: 'Playlist Name',
            hintText: 'My Awesome Playlist',
          ),
          textCapitalization: TextCapitalization.words,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Create'),
          ),
        ],
      ),
    );

    if (result == true && nameController.text.trim().isNotEmpty) {
      try {
        final playlistId = await playlistService.createPlaylist(
          name: nameController.text.trim(),
        );

        // Add track to the new playlist
        await playlistService.addTrackToPlaylist(
          playlistId: playlistId,
          trackId: track.trackId,
        );

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Created "${nameController.text.trim()}" and added track',
              ),
              backgroundColor: Colors.green,
            ),
          );
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }

    nameController.dispose();
  }

  static Future<void> _addToPlaylist(
    BuildContext context,
    TrackModel track,
    PlaylistModel playlist,
    PlaylistService playlistService,
  ) async {
    try {
      await playlistService.addTrackToPlaylist(
        playlistId: playlist.playlistId,
        trackId: track.trackId,
      );

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Added to "${playlist.name}"'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to add track: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
