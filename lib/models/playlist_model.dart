import 'package:cloud_firestore/cloud_firestore.dart';

class PlaylistModel {
  final String playlistId;
  final String name;
  final String userId;
  final List<String> trackIds;
  final bool isPublic;
  final DateTime createdAt;
  final DateTime updatedAt;

  PlaylistModel({
    required this.playlistId,
    required this.name,
    required this.userId,
    required this.trackIds,
    required this.isPublic,
    required this.createdAt,
    required this.updatedAt,
  });

  // Create from Firestore document
  factory PlaylistModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return PlaylistModel(
      playlistId: doc.id,
      name: data['name'] ?? '',
      userId: data['userId'] ?? '',
      trackIds: List<String>.from(data['trackIds'] ?? []),
      isPublic: data['isPublic'] ?? false,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (data['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  // Convert to Firestore document
  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'userId': userId,
      'trackIds': trackIds,
      'isPublic': isPublic,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  // Helper to get track count
  int get trackCount => trackIds.length;

  // Copy with method for updates
  PlaylistModel copyWith({
    String? name,
    List<String>? trackIds,
    bool? isPublic,
    DateTime? updatedAt,
  }) {
    return PlaylistModel(
      playlistId: playlistId,
      name: name ?? this.name,
      userId: userId,
      trackIds: trackIds ?? this.trackIds,
      isPublic: isPublic ?? this.isPublic,
      createdAt: createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }
}
