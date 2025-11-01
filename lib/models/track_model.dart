import 'package:cloud_firestore/cloud_firestore.dart';

class TrackModel {
  final String trackId;
  final String title;
  final String artistId;
  final String artistName;
  final String genre;
  final bool isFree;
  final double? price;
  final String audioUrl;
  final String artworkUrl;
  final int duration;
  final int streamCount;
  final String status;
  final DateTime createdAt;

  TrackModel({
    required this.trackId,
    required this.title,
    required this.artistId,
    required this.artistName,
    required this.genre,
    required this.isFree,
    this.price,
    required this.audioUrl,
    required this.artworkUrl,
    required this.duration,
    required this.streamCount,
    required this.status,
    required this.createdAt,
  });

  // Create TrackModel from Firestore document
  factory TrackModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return TrackModel(
      trackId: doc.id,
      title: data['title'] ?? '',
      artistId: data['artistId'] ?? '',
      artistName: data['artistName'] ?? 'Unknown Artist',
      genre: data['genre'] ?? 'Unknown',
      isFree: data['isFree'] ?? true,
      price: data['price']?.toDouble(),
      audioUrl: data['audioUrl'] ?? '',
      artworkUrl: data['artworkUrl'] ?? '',
      duration: data['duration'] ?? 0,
      streamCount: data['streamCount'] ?? 0,
      status: data['status'] ?? 'active',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  // Convert TrackModel to Firestore document
  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'artistId': artistId,
      'artistName': artistName,
      'genre': genre,
      'isFree': isFree,
      'price': price,
      'audioUrl': audioUrl,
      'artworkUrl': artworkUrl,
      'duration': duration,
      'streamCount': streamCount,
      'status': status,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  // Create a copy with updated fields
  TrackModel copyWith({
    String? trackId,
    String? title,
    String? artistId,
    String? artistName,
    String? genre,
    bool? isFree,
    double? price,
    String? audioUrl,
    String? artworkUrl,
    int? duration,
    int? streamCount,
    String? status,
    DateTime? createdAt,
  }) {
    return TrackModel(
      trackId: trackId ?? this.trackId,
      title: title ?? this.title,
      artistId: artistId ?? this.artistId,
      artistName: artistName ?? this.artistName,
      genre: genre ?? this.genre,
      isFree: isFree ?? this.isFree,
      price: price ?? this.price,
      audioUrl: audioUrl ?? this.audioUrl,
      artworkUrl: artworkUrl ?? this.artworkUrl,
      duration: duration ?? this.duration,
      streamCount: streamCount ?? this.streamCount,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  // Format duration from seconds to mm:ss
  String get formattedDuration {
    final minutes = duration ~/ 60;
    final seconds = duration % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  // Format stream count with K/M suffix
  String get formattedStreamCount {
    if (streamCount >= 1000000) {
      return '${(streamCount / 1000000).toStringAsFixed(1)}M';
    } else if (streamCount >= 1000) {
      return '${(streamCount / 1000).toStringAsFixed(1)}K';
    }
    return streamCount.toString();
  }
}
