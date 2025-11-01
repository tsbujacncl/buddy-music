import 'package:just_audio/just_audio.dart';
import '../models/track_model.dart';

class AudioPlayerService {
  static final AudioPlayerService _instance = AudioPlayerService._internal();
  factory AudioPlayerService() => _instance;
  AudioPlayerService._internal();

  final AudioPlayer _player = AudioPlayer();

  TrackModel? _currentTrack;
  List<TrackModel> _playlist = [];
  int _currentIndex = 0;

  // Getters
  AudioPlayer get player => _player;
  TrackModel? get currentTrack => _currentTrack;
  List<TrackModel> get playlist => _playlist;
  int get currentIndex => _currentIndex;

  // Stream getters for UI updates
  Stream<PlayerState> get playerStateStream => _player.playerStateStream;
  Stream<Duration?> get durationStream => _player.durationStream;
  Stream<Duration> get positionStream => _player.positionStream;
  Stream<bool> get playingStream => _player.playingStream;

  bool get isPlaying => _player.playing;
  bool get hasNext => _currentIndex < _playlist.length - 1;
  bool get hasPrevious => _currentIndex > 0;

  // Play a single track
  Future<void> playTrack(TrackModel track) async {
    try {
      _currentTrack = track;
      _playlist = [track];
      _currentIndex = 0;

      await _player.setUrl(track.audioUrl);
      await _player.play();
    } catch (e) {
      throw Exception('Failed to play track: $e');
    }
  }

  // Play a playlist starting at a specific index
  Future<void> playPlaylist(List<TrackModel> tracks, int startIndex) async {
    if (tracks.isEmpty || startIndex >= tracks.length) {
      throw Exception('Invalid playlist or index');
    }

    try {
      _playlist = tracks;
      _currentIndex = startIndex;
      _currentTrack = tracks[startIndex];

      await _player.setUrl(_currentTrack!.audioUrl);
      await _player.play();
    } catch (e) {
      throw Exception('Failed to play playlist: $e');
    }
  }

  // Play/pause toggle
  Future<void> togglePlayPause() async {
    if (_player.playing) {
      await _player.pause();
    } else {
      await _player.play();
    }
  }

  // Play
  Future<void> play() async {
    await _player.play();
  }

  // Pause
  Future<void> pause() async {
    await _player.pause();
  }

  // Next track
  Future<void> next() async {
    if (hasNext) {
      _currentIndex++;
      _currentTrack = _playlist[_currentIndex];
      await _player.setUrl(_currentTrack!.audioUrl);
      await _player.play();
    }
  }

  // Previous track
  Future<void> previous() async {
    // If more than 3 seconds into the track, restart it
    if (_player.position.inSeconds > 3) {
      await _player.seek(Duration.zero);
    } else if (hasPrevious) {
      _currentIndex--;
      _currentTrack = _playlist[_currentIndex];
      await _player.setUrl(_currentTrack!.audioUrl);
      await _player.play();
    } else {
      // Restart current track
      await _player.seek(Duration.zero);
    }
  }

  // Seek to position
  Future<void> seek(Duration position) async {
    await _player.seek(position);
  }

  // Stop playback
  Future<void> stop() async {
    await _player.stop();
    _currentTrack = null;
  }

  // Dispose (cleanup)
  Future<void> dispose() async {
    await _player.dispose();
  }

  // Set up player to automatically play next track when current finishes
  void setupAutoPlay() {
    _player.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        if (hasNext) {
          next();
        }
      }
    });
  }
}
