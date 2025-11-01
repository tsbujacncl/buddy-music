import 'package:cloud_firestore/cloud_firestore.dart';

class ArtistModel {
  final String uid;
  final String bio;
  final String bannerUrl;
  final String profilePhotoUrl;
  final Map<String, String> socialLinks;
  final int totalStreams;
  final int followerCount;
  final DateTime createdAt;
  final DateTime updatedAt;

  ArtistModel({
    required this.uid,
    required this.bio,
    required this.bannerUrl,
    required this.profilePhotoUrl,
    required this.socialLinks,
    required this.totalStreams,
    required this.followerCount,
    required this.createdAt,
    required this.updatedAt,
  });

  // Create ArtistModel from Firestore document
  factory ArtistModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ArtistModel(
      uid: doc.id,
      bio: data['bio'] ?? '',
      bannerUrl: data['bannerUrl'] ?? '',
      profilePhotoUrl: data['profilePhotoUrl'] ?? '',
      socialLinks: Map<String, String>.from(data['socialLinks'] ?? {
        'instagram': '',
        'twitter': '',
        'website': '',
      }),
      totalStreams: data['totalStreams'] ?? 0,
      followerCount: data['followerCount'] ?? 0,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (data['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  // Convert ArtistModel to Firestore document
  Map<String, dynamic> toFirestore() {
    return {
      'bio': bio,
      'bannerUrl': bannerUrl,
      'profilePhotoUrl': profilePhotoUrl,
      'socialLinks': socialLinks,
      'totalStreams': totalStreams,
      'followerCount': followerCount,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  // Create a copy with updated fields
  ArtistModel copyWith({
    String? uid,
    String? bio,
    String? bannerUrl,
    String? profilePhotoUrl,
    Map<String, String>? socialLinks,
    int? totalStreams,
    int? followerCount,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ArtistModel(
      uid: uid ?? this.uid,
      bio: bio ?? this.bio,
      bannerUrl: bannerUrl ?? this.bannerUrl,
      profilePhotoUrl: profilePhotoUrl ?? this.profilePhotoUrl,
      socialLinks: socialLinks ?? this.socialLinks,
      totalStreams: totalStreams ?? this.totalStreams,
      followerCount: followerCount ?? this.followerCount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
