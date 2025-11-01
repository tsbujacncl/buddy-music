import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/artist_model.dart';

class ArtistService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get artist by ID
  Future<ArtistModel?> getArtistById(String artistId) async {
    try {
      final doc = await _firestore.collection('artists').doc(artistId).get();
      if (doc.exists) {
        return ArtistModel.fromFirestore(doc);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to load artist: $e');
    }
  }

  // Get all artists
  Future<List<ArtistModel>> getAllArtists({int limit = 20}) async {
    try {
      final querySnapshot = await _firestore
          .collection('artists')
          .orderBy('totalStreams', descending: true)
          .limit(limit)
          .get();

      return querySnapshot.docs
          .map((doc) => ArtistModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      throw Exception('Failed to load artists: $e');
    }
  }

  // Get trending artists (by total streams)
  Future<List<ArtistModel>> getTrendingArtists({int limit = 10}) async {
    try {
      final querySnapshot = await _firestore
          .collection('artists')
          .orderBy('totalStreams', descending: true)
          .limit(limit)
          .get();

      return querySnapshot.docs
          .map((doc) => ArtistModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      throw Exception('Failed to load trending artists: $e');
    }
  }

  // Search artists by name
  Future<List<ArtistModel>> searchArtists(String query) async {
    try {
      // Note: This is basic search. For production, use Algolia
      final querySnapshot = await _firestore
          .collection('artists')
          .orderBy('totalStreams', descending: true)
          .limit(50)
          .get();

      // Filter results client-side (not ideal for large datasets)
      return querySnapshot.docs
          .map((doc) => ArtistModel.fromFirestore(doc))
          .where((artist) {
            // Search in user's display name (stored in users collection)
            // For now, we'll just return all and implement proper search in v1.1
            return true;
          })
          .toList();
    } catch (e) {
      throw Exception('Failed to search artists: $e');
    }
  }

  // Increment follower count
  Future<void> incrementFollowerCount(String artistId) async {
    try {
      await _firestore.collection('artists').doc(artistId).update({
        'followerCount': FieldValue.increment(1),
      });
    } catch (e) {
      throw Exception('Failed to update follower count: $e');
    }
  }

  // Decrement follower count
  Future<void> decrementFollowerCount(String artistId) async {
    try {
      await _firestore.collection('artists').doc(artistId).update({
        'followerCount': FieldValue.increment(-1),
      });
    } catch (e) {
      throw Exception('Failed to update follower count: $e');
    }
  }
}
