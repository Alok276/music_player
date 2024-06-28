import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:music_player/constants/colors.dart';
import 'package:music_player/providers/audio_player_providers.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class MiniPlayer extends StatelessWidget {
  final List<SongModel> songs;

  const MiniPlayer({super.key, required this.songs});

  // NOw let's add the audio playing functions

  @override
  Widget build(BuildContext context) {
    final audioProvider = Provider.of<AudioPlayerProvider>(context);
    final currentPlayingIndex = audioProvider.currentPlayingIndex;
    final currentSong = audioProvider.currentSong;
    return currentPlayingIndex != null && currentSong != null
        ? BottomAppBar(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 02, vertical: 8),
              child: Row(
                children: [
                  QueryArtworkWidget(
              id: songs[currentPlayingIndex].id,
              type: ArtworkType.AUDIO,
              artworkWidth: 26,
              artworkHeight: 26,
              artworkBorder: BorderRadius.circular(16),
              nullArtworkWidget: const Icon(
                Icons.music_note,
                color: bgColor,
                size: 24,
              ),
              
            
            ),
           const SizedBox(width:20),
            
                  SizedBox(
                    width: 150,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          currentSong.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          currentSong.artist ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                   IconButton(
                    onPressed: () {
                      final previousIndex =
                          (currentPlayingIndex - 1) % songs.length;
                      audioProvider.playPause(previousIndex, songs);
                    },
                    iconSize: 30,
                    icon: const Icon(Icons.skip_previous),
                  ),
                  IconButton(
                    onPressed: () {
                      audioProvider.playPause(currentPlayingIndex, songs);
                      if (audioProvider.isPlaying) {
                        AudioPlayer().pause();
                      } else {
                        AudioPlayer().resume();
                      }
                    },
                    iconSize: 30,
                    icon: Icon(audioProvider.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow),
                  ),

                  IconButton(
                    onPressed: () {
                      final nextIndex =
                          (currentPlayingIndex + 1) % songs.length;
                      audioProvider.playPause(nextIndex, songs);
                    },
                    iconSize: 30,
                    icon: const Icon(Icons.skip_next),
                  ),
                ],
              ),
            ),
          )
        : const SizedBox();
  }
}