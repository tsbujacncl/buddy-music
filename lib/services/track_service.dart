import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/track_model.dart';

class TrackService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get all tracks with pagination
  Future<List<TrackModel>> getTracks({
    int limit = 20,
    DocumentSnapshot? lastDocument,
  }) async {
    try {
      Query query = _firestore
          .collection('tracks')
          .where('status', isEqualTo: 'active')
          .orderBy('createdAt', descending: true)
          .limit(limit);

      if (lastDocument != null) {
        query = query.startAfterDocument(lastDocument);
      }

      final querySnapshot = await query.get();
      return querySnapshot.docs
          .map((doc) => TrackModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      throw Exception('Failed to load tracks: $e');
    }
  }

  // Get new releases (most recent tracks)
  Future<List<TrackModel>> getNewReleases({int limit = 10}) async {
    try {
      final querySnapshot = await _firestore
          .collection('tracks')
          .where('status', isEqualTo: 'active')
          .orderBy('createdAt', descending: true)
          .limit(limit)
          .get();

      return querySnapshot.docs
          .map((doc) => TrackModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      throw Exception('Failed to load new releases: $e');
    }
  }

  // Get trending tracks (most played this week)
  Future<List<TrackModel>> getTrendingTracks({int limit = 10}) async {
    try {
      // For MVP, we'll just get tracks sorted by stream count
      // In future, we can add time-based filtering
      final querySnapshot = await _firestore
          .collection('tracks')
          .where('status', isEqualTo: 'active')
          .orderBy('streamCount', descending: true)
          .limit(limit)
          .get();

      return querySnapshot.docs
          .map((doc) => TrackModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      throw Exception('Failed to load trending tracks: $e');
    }
  }

  // Get tracks by genre
  Future<List<TrackModel>> getTracksByGenre({
    required String genre,
    int limit = 20,
    DocumentSnapshot? lastDocument,
  }) async {
    try {
      Query query = _firestore
          .collection('tracks')
          .where('status', isEqualTo: 'active')
          .where('genre', isEqualTo: genre)
          .orderBy('createdAt', descending: true)
          .limit(limit);

      if (lastDocument != null) {
        query = query.startAfterDocument(lastDocument);
      }

      final querySnapshot = await query.get();
      return querySnapshot.docs
          .map((doc) => TrackModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      throw Exception('Failed to load tracks by genre: $e');
    }
  }

  // Get tracks by artist
  Future<List<TrackModel>> getTracksByArtist(String artistId) async {
    try {
      final querySnapshot = await _firestore
          .collection('tracks')
          .where('artistId', isEqualTo: artistId)
          .where('status', isEqualTo: 'active')
          .orderBy('createdAt', descending: true)
          .get();

      return querySnapshot.docs
          .map((doc) => TrackModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      throw Exception('Failed to load artist tracks: $e');
    }
  }

  // Get a single track by ID
  Future<TrackModel?> getTrackById(String trackId) async {
    try {
      final doc = await _firestore.collection('tracks').doc(trackId).get();
      if (doc.exists) {
        return TrackModel.fromFirestore(doc);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to load track: $e');
    }
  }

  // Stream tracks (real-time updates)
  Stream<List<TrackModel>> streamTracks({int limit = 20}) {
    return _firestore
        .collection('tracks')
        .where('status', isEqualTo: 'active')
        .orderBy('createdAt', descending: true)
        .limit(limit)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => TrackModel.fromFirestore(doc))
            .toList());
  }

  // Increment stream count
  Future<void> incrementStreamCount(String trackId) async {
    try {
      await _firestore.collection('tracks').doc(trackId).update({
        'streamCount': FieldValue.increment(1),
      });
    } catch (e) {
      throw Exception('Failed to update stream count: $e');
    }
  }

  // Search tracks by title or artist name
  Future<List<TrackModel>> searchTracks(String query) async {
    try {
      // Note: This is a basic search. For production, use Algolia or similar
      final titleResults = await _firestore
          .collection('tracks')
          .where('status', isEqualTo: 'active')
          .orderBy('title')
          .startAt([query])
          .endAt(['$query\uf8ff'])
          .limit(20)
          .get();

      final artistResults = await _firestore
          .collection('tracks')
          .where('status', isEqualTo: 'active')
          .orderBy('artistName')
          .startAt([query])
          .endAt(['$query\uf8ff'])
          .limit(20)
          .get();

      // Combine and deduplicate results
      final allDocs = [...titleResults.docs, ...artistResults.docs];
      final uniqueDocs = <String, DocumentSnapshot>{};
      for (var doc in allDocs) {
        uniqueDocs[doc.id] = doc;
      }

      return uniqueDocs.values
          .map((doc) => TrackModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      throw Exception('Failed to search tracks: $e');
    }
  }
}
