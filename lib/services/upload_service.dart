import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/track_model.dart';

class UploadService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Upload audio file to Firebase Storage
  Future<String> uploadAudioFile(
    File file,
    String trackId, {
    Function(double)? onProgress,
  }) async {
    try {
      final user = _auth.currentUser;
      if (user == null) throw Exception('User not authenticated');

      final ref = _storage.ref().child('audio/${user.uid}/$trackId.mp3');
      final uploadTask = ref.putFile(file);

      // Listen to upload progress
      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        final progress = snapshot.bytesTransferred / snapshot.totalBytes;
        onProgress?.call(progress);
      });

      await uploadTask;
      final downloadUrl = await ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      throw Exception('Failed to upload audio: $e');
    }
  }

  // Upload artwork image to Firebase Storage
  Future<String> uploadArtworkFile(
    File file,
    String trackId, {
    Function(double)? onProgress,
  }) async {
    try {
      final user = _auth.currentUser;
      if (user == null) throw Exception('User not authenticated');

      final ref = _storage.ref().child('artwork/${user.uid}/$trackId.jpg');
      final uploadTask = ref.putFile(file);

      // Listen to upload progress
      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        final progress = snapshot.bytesTransferred / snapshot.totalBytes;
        onProgress?.call(progress);
      });

      await uploadTask;
      final downloadUrl = await ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      throw Exception('Failed to upload artwork: $e');
    }
  }

  // Create track document in Firestore
  Future<String> createTrack({
    required String title,
    required String genre,
    required String audioUrl,
    required String artworkUrl,
    required int duration,
  }) async {
    try {
      final user = _auth.currentUser;
      if (user == null) throw Exception('User not authenticated');

      // Get user data for artist name
      final userDoc = await _firestore.collection('users').doc(user.uid).get();
      final artistName = userDoc.data()?['displayName'] ?? 'Unknown Artist';

      // Create track document
      final trackRef = _firestore.collection('tracks').doc();
      await trackRef.set({
        'title': title,
        'artistId': user.uid,
        'artistName': artistName,
        'genre': genre,
        'isFree': true, // All tracks are free for MVP
        'price': null,
        'audioUrl': audioUrl,
        'artworkUrl': artworkUrl,
        'duration': duration,
        'streamCount': 0,
        'status': 'active',
        'createdAt': FieldValue.serverTimestamp(),
      });

      return trackRef.id;
    } catch (e) {
      throw Exception('Failed to create track: $e');
    }
  }

  // Update track
  Future<void> updateTrack({
    required String trackId,
    String? title,
    String? genre,
    String? artworkUrl,
  }) async {
    try {
      final updates = <String, dynamic>{};
      if (title != null) updates['title'] = title;
      if (genre != null) updates['genre'] = genre;
      if (artworkUrl != null) updates['artworkUrl'] = artworkUrl;

      if (updates.isNotEmpty) {
        await _firestore.collection('tracks').doc(trackId).update(updates);
      }
    } catch (e) {
      throw Exception('Failed to update track: $e');
    }
  }

  // Delete track
  Future<void> deleteTrack(String trackId) async {
    try {
      final user = _auth.currentUser;
      if (user == null) throw Exception('User not authenticated');

      // Get track to verify ownership and get file URLs
      final trackDoc = await _firestore.collection('tracks').doc(trackId).get();
      if (!trackDoc.exists) {
        throw Exception('Track not found');
      }

      final track = TrackModel.fromFirestore(trackDoc);
      if (track.artistId != user.uid) {
        throw Exception('Not authorized to delete this track');
      }

      // Delete files from storage
      try {
        final audioRef = _storage.refFromURL(track.audioUrl);
        await audioRef.delete();
      } catch (e) {
        // File might not exist, continue
      }

      try {
        final artworkRef = _storage.refFromURL(track.artworkUrl);
        await artworkRef.delete();
      } catch (e) {
        // File might not exist, continue
      }

      // Delete Firestore document
      await _firestore.collection('tracks').doc(trackId).delete();
    } catch (e) {
      throw Exception('Failed to delete track: $e');
    }
  }

  // Get artist's tracks
  Future<List<TrackModel>> getArtistTracks() async {
    try {
      final user = _auth.currentUser;
      if (user == null) throw Exception('User not authenticated');

      final querySnapshot = await _firestore
          .collection('tracks')
          .where('artistId', isEqualTo: user.uid)
          .orderBy('createdAt', descending: true)
          .get();

      return querySnapshot.docs
          .map((doc) => TrackModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      throw Exception('Failed to load tracks: $e');
    }
  }

  // Get total streams for artist
  Future<int> getArtistTotalStreams() async {
    try {
      final tracks = await getArtistTracks();
      return tracks.fold<int>(0, (total, track) => total + track.streamCount);
    } catch (e) {
      return 0;
    }
  }
}
