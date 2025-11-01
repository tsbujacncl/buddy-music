import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/playlist_model.dart';

class PlaylistService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Create new playlist
  Future<String> createPlaylist({
    required String name,
  }) async {
    try {
      final user = _auth.currentUser;
      if (user == null) throw Exception('User not authenticated');

      final playlistRef = _firestore.collection('playlists').doc();

      await playlistRef.set({
        'name': name,
        'userId': user.uid,
        'trackIds': [],
        'isPublic': false, // All playlists private for MVP
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      return playlistRef.id;
    } catch (e) {
      throw Exception('Failed to create playlist: $e');
    }
  }

  // Get user's playlists
  Future<List<PlaylistModel>> getUserPlaylists() async {
    try {
      final user = _auth.currentUser;
      if (user == null) throw Exception('User not authenticated');

      final querySnapshot = await _firestore
          .collection('playlists')
          .where('userId', isEqualTo: user.uid)
          .orderBy('updatedAt', descending: true)
          .get();

      return querySnapshot.docs
          .map((doc) => PlaylistModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      throw Exception('Failed to load playlists: $e');
    }
  }

  // Get playlist by ID
  Future<PlaylistModel?> getPlaylistById(String playlistId) async {
    try {
      final doc = await _firestore.collection('playlists').doc(playlistId).get();

      if (!doc.exists) return null;
      return PlaylistModel.fromFirestore(doc);
    } catch (e) {
      throw Exception('Failed to load playlist: $e');
    }
  }

  // Add track to playlist
  Future<void> addTrackToPlaylist({
    required String playlistId,
    required String trackId,
  }) async {
    try {
      final user = _auth.currentUser;
      if (user == null) throw Exception('User not authenticated');

      // Get playlist to verify ownership
      final playlist = await getPlaylistById(playlistId);
      if (playlist == null) throw Exception('Playlist not found');
      if (playlist.userId != user.uid) {
        throw Exception('Not authorized to modify this playlist');
      }

      // Check if track already exists
      if (playlist.trackIds.contains(trackId)) {
        throw Exception('Track already in playlist');
      }

      // Add track
      await _firestore.collection('playlists').doc(playlistId).update({
        'trackIds': FieldValue.arrayUnion([trackId]),
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to add track: $e');
    }
  }

  // Remove track from playlist
  Future<void> removeTrackFromPlaylist({
    required String playlistId,
    required String trackId,
  }) async {
    try {
      final user = _auth.currentUser;
      if (user == null) throw Exception('User not authenticated');

      // Get playlist to verify ownership
      final playlist = await getPlaylistById(playlistId);
      if (playlist == null) throw Exception('Playlist not found');
      if (playlist.userId != user.uid) {
        throw Exception('Not authorized to modify this playlist');
      }

      // Remove track
      await _firestore.collection('playlists').doc(playlistId).update({
        'trackIds': FieldValue.arrayRemove([trackId]),
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to remove track: $e');
    }
  }

  // Update playlist name
  Future<void> updatePlaylistName({
    required String playlistId,
    required String name,
  }) async {
    try {
      final user = _auth.currentUser;
      if (user == null) throw Exception('User not authenticated');

      // Get playlist to verify ownership
      final playlist = await getPlaylistById(playlistId);
      if (playlist == null) throw Exception('Playlist not found');
      if (playlist.userId != user.uid) {
        throw Exception('Not authorized to modify this playlist');
      }

      await _firestore.collection('playlists').doc(playlistId).update({
        'name': name,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to update playlist: $e');
    }
  }

  // Delete playlist
  Future<void> deletePlaylist(String playlistId) async {
    try {
      final user = _auth.currentUser;
      if (user == null) throw Exception('User not authenticated');

      // Get playlist to verify ownership
      final playlist = await getPlaylistById(playlistId);
      if (playlist == null) throw Exception('Playlist not found');
      if (playlist.userId != user.uid) {
        throw Exception('Not authorized to delete this playlist');
      }

      await _firestore.collection('playlists').doc(playlistId).delete();
    } catch (e) {
      throw Exception('Failed to delete playlist: $e');
    }
  }

  // Reorder tracks in playlist
  Future<void> reorderTracks({
    required String playlistId,
    required List<String> newTrackIds,
  }) async {
    try {
      final user = _auth.currentUser;
      if (user == null) throw Exception('User not authenticated');

      // Get playlist to verify ownership
      final playlist = await getPlaylistById(playlistId);
      if (playlist == null) throw Exception('Playlist not found');
      if (playlist.userId != user.uid) {
        throw Exception('Not authorized to modify this playlist');
      }

      await _firestore.collection('playlists').doc(playlistId).update({
        'trackIds': newTrackIds,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to reorder tracks: $e');
    }
  }
}
