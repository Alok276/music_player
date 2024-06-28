
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:music_player/constants/colors.dart';
import 'package:music_player/providers/audio_player_providers.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class PlayerScreen extends StatefulWidget  {

  const PlayerScreen({super.key,required this.songs});

  final List<SongModel> songs;
 
  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  @override
  Widget build(BuildContext context) {
    final audioProvider = Provider.of<AudioPlayerProvider>(context);
    final currentPlayingIndex = audioProvider.currentPlayingIndex;
    final currentSong = audioProvider.currentSong;
    return Scaffold(
    backgroundColor: newBlack,
        appBar: AppBar(
          backgroundColor: newBlack,
          leading:const  Icon(Icons.arrow_back, color:  whiteColor, ),
          
          title:  const Text("Player",
          style: TextStyle(color: whiteColor, fontWeight: FontWeight.w500, fontSize: 24),),
           centerTitle: true,
        ),

   body: Padding(
     padding: const EdgeInsets.all(8.0),
     child: Column(
     
      children: [
     
       const  SizedBox(height: 40,),
       Text(
                widget.songs[currentPlayingIndex!].title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style:const TextStyle(fontSize: 24, color: whiteColor),
              ),
              const  SizedBox(height: 10,),
              Text(
                widget.songs[currentPlayingIndex].artist ?? " ",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style:const TextStyle(fontSize: 18, color: subtitleColor),
              ),
               const  SizedBox(height: 40,),
             Center(
               child: QueryArtworkWidget(
                  id: widget.songs[currentPlayingIndex].id,
                  type: ArtworkType.AUDIO,
                  artworkWidth: 300,
                  artworkHeight:350,
                  artworkBorder: BorderRadius.circular(16),
                  nullArtworkWidget: Image.asset("assets/images/splash.png", scale: 0.01,)
                ),
             ),
             const  SizedBox(height: 30,),
     
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    Text(
                      _formatDuration(audioProvider.position),
                      style:const TextStyle(fontSize: 16, color: whiteColor),
                    ),
                    Expanded(
                      child: Slider(
                                 
                                 thumbColor: sliderColor,
                                 inactiveColor: whiteColor,
                                 activeColor: sliderColor,
                                 value: audioProvider.position.inSeconds.toDouble(),
                                 min: 0.0,
                          max: audioProvider.duration.inSeconds.toDouble(),
                          onChanged: (newValue) {
                            audioProvider.seek(Duration(seconds: newValue.toInt()));
                          },
                                ),
                    ),
                
                  Text(
                    _formatDuration(audioProvider.duration),
                     style: const TextStyle(fontSize: 16, color: whiteColor),
                  ),
                  ],
                ),
              ),
            const  SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                      onPressed: () {
                        audioProvider.playPreviousSong();
                      },
                      iconSize: 50,
                      icon: const Icon(Icons.skip_previous, color: whiteColor,),
                    ),
                    IconButton(
                      onPressed: () {
                        audioProvider.playPauseHelper();
                        if (audioProvider.isPlaying) {
                          AudioPlayer().pause();
                          audioProvider.isPlaying;
                        } else {
                          AudioPlayer().resume();
                        }
                      },
                      iconSize: 50,
                      icon: Icon(audioProvider.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow, color: whiteColor,),
                    ),
     
                    IconButton(
                      onPressed: () {
                        
                        audioProvider.playNextSong();
                         
                      },
                      iconSize: 50,
                      icon: const Icon(Icons.skip_next, color: whiteColor,),
                    ),
              ],
            )
      ] 
     ),
   ),
    );

  }
}

 String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
