import 'package:flutter/material.dart';
import '../models/track_model.dart';
import '../services/track_service.dart';
import '../widgets/track_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TrackService _trackService = TrackService();

  List<TrackModel> _allTracks = [];
  List<TrackModel> _newReleases = [];
  List<TrackModel> _trendingTracks = [];

  bool _isLoading = true;
  bool _isLoadingMore = false;
  String? _selectedGenre;

  final ScrollController _scrollController = ScrollController();

  // Available genres
  final List<String> _genres = [
    'All',
    'Electronic',
    'Indie',
    'Hip-Hop',
    'Lo-Fi',
    'Rock',
    'Pop',
    'Jazz',
    'Classical',
  ];

  @override
  void initState() {
    super.initState();
    _loadInitialData();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.8) {
      if (!_isLoadingMore) {
        _loadMoreTracks();
      }
    }
  }

  Future<void> _loadInitialData() async {
    setState(() => _isLoading = true);

    try {
      final results = await Future.wait([
        _trackService.getNewReleases(limit: 10),
        _trackService.getTrendingTracks(limit: 10),
        _trackService.getTracks(limit: 20),
      ]);

      setState(() {
        _newReleases = results[0];
        _trendingTracks = results[1];
        _allTracks = results[2];
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load tracks: $e')),
        );
      }
    }
  }

  Future<void> _loadMoreTracks() async {
    if (_allTracks.isEmpty) return;

    setState(() => _isLoadingMore = true);

    try {
      final moreTracks = _selectedGenre == null || _selectedGenre == 'All'
          ? await _trackService.getTracks(limit: 20)
          : await _trackService.getTracksByGenre(
              genre: _selectedGenre!,
              limit: 20,
            );

      setState(() {
        _allTracks.addAll(moreTracks);
        _isLoadingMore = false;
      });
    } catch (e) {
      setState(() => _isLoadingMore = false);
    }
  }

  Future<void> _onRefresh() async {
    await _loadInitialData();
  }

  Future<void> _onGenreSelected(String genre) async {
    setState(() {
      _selectedGenre = genre == 'All' ? null : genre;
      _isLoading = true;
    });

    try {
      final tracks = _selectedGenre == null
          ? await _trackService.getTracks(limit: 20)
          : await _trackService.getTracksByGenre(
              genre: _selectedGenre!,
              limit: 20,
            );

      setState(() {
        _allTracks = tracks;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load tracks: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buddy'),
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: _isLoading && _allTracks.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : CustomScrollView(
                controller: _scrollController,
                slivers: [
                  // Genre filter chips
                  SliverToBoxAdapter(
                    child: _buildGenreFilters(),
                  ),

                  // New Releases section
                  if (_newReleases.isNotEmpty && _selectedGenre == null) ...[
                    SliverToBoxAdapter(
                      child: _buildSectionHeader('New Releases'),
                    ),
                    SliverToBoxAdapter(
                      child: _buildHorizontalTrackList(_newReleases),
                    ),
                  ],

                  // Trending section
                  if (_trendingTracks.isNotEmpty && _selectedGenre == null) ...[
                    SliverToBoxAdapter(
                      child: _buildSectionHeader('Trending This Week'),
                    ),
                    SliverToBoxAdapter(
                      child: _buildHorizontalTrackList(_trendingTracks),
                    ),
                  ],

                  // All tracks section
                  SliverToBoxAdapter(
                    child: _buildSectionHeader(
                      _selectedGenre == null ? 'All Tracks' : _selectedGenre!,
                    ),
                  ),

                  // Track grid
                  if (_allTracks.isEmpty)
                    SliverToBoxAdapter(
                      child: _buildEmptyState(),
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
                              track: _allTracks[index],
                              onTap: () {
                                // TODO: Navigate to player screen (M3)
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Playing: ${_allTracks[index].title}',
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          childCount: _allTracks.length,
                        ),
                      ),
                    ),

                  // Loading more indicator
                  if (_isLoadingMore)
                    const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Center(child: CircularProgressIndicator()),
                      ),
                    ),
                ],
              ),
      ),
    );
  }

  Widget _buildGenreFilters() {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _genres.length,
        itemBuilder: (context, index) {
          final genre = _genres[index];
          final isSelected = (_selectedGenre == null && genre == 'All') ||
              _selectedGenre == genre;

          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: Text(genre),
              selected: isSelected,
              onSelected: (selected) {
                if (selected) {
                  _onGenreSelected(genre);
                }
              },
              selectedColor: const Color(0xFF5C9DFF),
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : Colors.black87,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildHorizontalTrackList(List<TrackModel> tracks) {
    return SizedBox(
      height: 240,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: tracks.length,
        itemBuilder: (context, index) {
          return SizedBox(
            width: 160,
            child: Padding(
              padding: const EdgeInsets.only(right: 12),
              child: TrackCard(
                track: tracks[index],
                onTap: () {
                  // TODO: Navigate to player screen (M3)
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Playing: ${tracks[index].title}'),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.music_note,
              size: 80,
              color: Color(0xFF5C9DFF),
            ),
            const SizedBox(height: 16),
            const Text(
              'No tracks yet',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Be the first to upload music!',
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
