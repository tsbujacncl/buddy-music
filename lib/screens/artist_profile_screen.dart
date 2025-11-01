import 'package:flutter/material.dart';
import '../models/artist_model.dart';
import '../models/track_model.dart';
import '../models/user_model.dart';
import '../services/artist_service.dart';
import '../services/track_service.dart';
import '../services/audio_player_service.dart';
import '../widgets/track_card.dart';
import '../widgets/add_to_playlist_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ArtistProfileScreen extends StatefulWidget {
  final String artistId;

  const ArtistProfileScreen({
    super.key,
    required this.artistId,
  });

  @override
  State<ArtistProfileScreen> createState() => _ArtistProfileScreenState();
}

class _ArtistProfileScreenState extends State<ArtistProfileScreen> {
  final ArtistService _artistService = ArtistService();
  final TrackService _trackService = TrackService();
  final AudioPlayerService _audioService = AudioPlayerService();

  ArtistModel? _artist;
  UserModel? _user;
  List<TrackModel> _tracks = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadArtistData();
  }

  Future<void> _loadArtistData() async {
    setState(() => _isLoading = true);

    try {
      final results = await Future.wait([
        _artistService.getArtistById(widget.artistId),
        _trackService.getTracksByArtist(widget.artistId),
        _loadUserData(),
      ]);

      setState(() {
        _artist = results[0] as ArtistModel?;
        _tracks = results[1] as List<TrackModel>;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load artist: $e')),
        );
      }
    }
  }

  Future<UserModel?> _loadUserData() async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.artistId)
          .get();

      if (doc.exists) {
        _user = UserModel.fromFirestore(doc);
        return _user;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  void _showTrackOptions(TrackModel track) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.play_arrow),
              title: const Text('Play'),
              onTap: () {
                Navigator.of(context).pop();
                final index = _tracks.indexOf(track);
                if (index >= 0) {
                  _audioService.playPlaylist(_tracks, index);
                  _trackService.incrementStreamCount(track.trackId);
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.playlist_add),
              title: const Text('Add to Playlist'),
              onTap: () {
                Navigator.of(context).pop();
                AddToPlaylistDialog.show(context: context, track: track);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_artist == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(
          child: Text('Artist not found'),
        ),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App bar with banner
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: _artist!.bannerUrl.isNotEmpty
                  ? Image.network(
                      _artist!.bannerUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return _buildPlaceholderBanner();
                      },
                    )
                  : _buildPlaceholderBanner(),
            ),
          ),

          // Artist info
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // Profile photo
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: const Color(0xFF5C9DFF),
                        backgroundImage: _artist!.profilePhotoUrl.isNotEmpty
                            ? NetworkImage(_artist!.profilePhotoUrl)
                            : null,
                        child: _artist!.profilePhotoUrl.isEmpty
                            ? Text(
                                (_user?.displayName ?? 'A')[0].toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              )
                            : null,
                      ),
                      const SizedBox(width: 16),

                      // Artist name and stats
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _user?.displayName ?? 'Artist',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(
                                  Icons.play_circle_outline,
                                  size: 16,
                                  color: Colors.grey[600],
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '${_formatNumber(_artist!.totalStreams)} streams',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Icon(
                                  Icons.people_outline,
                                  size: 16,
                                  color: Colors.grey[600],
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '${_formatNumber(_artist!.followerCount)} followers',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // Bio
                  if (_artist!.bio.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    Text(
                      _artist!.bio,
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 14,
                      ),
                    ),
                  ],

                  // Social links
                  if (_hasSocialLinks()) ...[
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        if (_artist!.socialLinks['instagram']?.isNotEmpty ?? false)
                          _buildSocialButton(Icons.camera_alt, 'Instagram'),
                        if (_artist!.socialLinks['twitter']?.isNotEmpty ?? false)
                          _buildSocialButton(Icons.flutter_dash, 'Twitter'),
                        if (_artist!.socialLinks['website']?.isNotEmpty ?? false)
                          _buildSocialButton(Icons.language, 'Website'),
                      ],
                    ),
                  ],

                  const SizedBox(height: 24),
                  const Text(
                    'Tracks',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Tracks grid
          if (_tracks.isEmpty)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Center(
                  child: Column(
                    children: [
                      Icon(
                        Icons.music_note,
                        size: 64,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No tracks yet',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.all(16.0),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return TrackCard(
                      track: _tracks[index],
                      onTap: () {
                        _audioService.playPlaylist(_tracks, index);
                        _trackService.incrementStreamCount(
                          _tracks[index].trackId,
                        );
                      },
                      onMoreTap: () => _showTrackOptions(_tracks[index]),
                    );
                  },
                  childCount: _tracks.length,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPlaceholderBanner() {
    return Container(
      color: const Color(0xFF5C9DFF).withValues(alpha: 0.2),
      child: const Center(
        child: Icon(
          Icons.music_note,
          size: 80,
          color: Color(0xFF5C9DFF),
        ),
      ),
    );
  }

  Widget _buildSocialButton(IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: OutlinedButton.icon(
        onPressed: () {
          // TODO: Open social link (M9)
        },
        icon: Icon(icon, size: 18),
        label: Text(label),
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFF5C9DFF),
        ),
      ),
    );
  }

  bool _hasSocialLinks() {
    return (_artist!.socialLinks['instagram']?.isNotEmpty ?? false) ||
        (_artist!.socialLinks['twitter']?.isNotEmpty ?? false) ||
        (_artist!.socialLinks['website']?.isNotEmpty ?? false);
  }

  String _formatNumber(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }
    return number.toString();
  }
}
