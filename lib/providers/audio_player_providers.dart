import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AudioPlayerProvider with ChangeNotifier {
  int? _currentPlayingIndex;
  List<SongModel> _songs = []; // Initialize _songs with an empty list
  bool _isPlaying = false;

  int? get currentPlayingIndex => _currentPlayingIndex;
  SongModel? get currentSong =>
      _currentPlayingIndex != null ? _songs[_currentPlayingIndex!] : null;
  bool get isPlaying => _isPlaying;


  

  final player = AudioPlayer();

  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  Duration get duration => _duration;
  Duration get position => _position;

  AudioPlayerProvider() {
    player.onPlayerComplete.listen((event) {
      // Called when a song finishes playing
      playNextSong();
      notifyListeners();
    });

    player.onDurationChanged.listen((newDuration) {
      _duration = newDuration;
      notifyListeners();
    });
    
    player.onPositionChanged.listen((newPosition) {
      _position = newPosition;
      notifyListeners();
    });
 
 
  }

 

  


  
    

  void playNextSong() {
    if (_currentPlayingIndex != null &&
        _currentPlayingIndex! < _songs.length - 1) {
      // Play the next song in the list
      playPause(_currentPlayingIndex! + 1, _songs);
    } else {
      // Stop playback if there are no more songs
      stop();
    }

    
  }

  void playPreviousSong() {
    if(currentPlayingIndex==0){
      playPause(_currentPlayingIndex! , _songs);
    }
   else  if (_currentPlayingIndex != null &&
        _currentPlayingIndex! >= 0) {
      // Play the next song in the list
      playPause(_currentPlayingIndex! - 1, _songs);
    } else  {
      // Stop playback if there are no more songs
      stop();
    }
    
  }


   void playPauseHelper() {
      // Play the next song in the list
      playPause(_currentPlayingIndex! , _songs);
  }
  void stop() {
    player.stop();
    _isPlaying = false;
    _currentPlayingIndex = null;
    notifyListeners();
  }

  // Play and Pause Function

  void playPause(int index, List<SongModel> songs) async {
    
    _songs = songs; // Update _songs before accessing it
    if (_currentPlayingIndex == index) {
      // Toggle play/pause for the same index
      _isPlaying ? await player.pause() : await player.resume();
      _isPlaying = !_isPlaying;
    } else {
      // Pause the currently playing song
      if (_currentPlayingIndex != null) {
        await player.stop();
        _isPlaying = false;
      }

      // Start playing the new song
      _currentPlayingIndex = index;
      await player.play(DeviceFileSource(_songs[index].data));
      _isPlaying = true;
    }

   
    notifyListeners();
  }
   

  Future<void> seek(Duration position) async {
    await player.seek(position);
    _position = position;
    notifyListeners();
  }

  String _formatDuration(Duration duration) {
  final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
  final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
  return '$minutes:$seconds';
}


}
