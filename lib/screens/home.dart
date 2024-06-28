import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_player/constants/colors.dart';
import 'package:music_player/providers/audio_player_providers.dart';
import 'package:music_player/screens/mini_player.dart';
import 'package:music_player/screens/player_screen.dart';
import 'package:music_player/screens/search_page.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {

  const Home({super.key });

  
   
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

   final OnAudioQuery audioQuery = OnAudioQuery();
   List<SongModel> _songs = [];
  


 @override
  void initState() {
    super.initState();
    requestPermission();
  }

  Future<void> requestPermission() async {
    final deviceInfo = await DeviceInfoPlugin().androidInfo;
    if (Theme.of(context).platform == TargetPlatform.android) {
      if (await Permission.audio.isGranted ||
          await Permission.storage.isGranted) {
        _fetchSongs();
      } else {
        if (deviceInfo.version.sdkInt > 32) {
          await Permission.audio.request();
        } else {
          await Permission.storage.request();
        }
      }
    } else if (Theme.of(context).platform == TargetPlatform.iOS) {
      if (await Permission.mediaLibrary.isGranted) {
     
      } else {
        await Permission.mediaLibrary.request();
      }
    }
  }

  Future<void> _fetchSongs() async {
    List<SongModel> songs = await audioQuery.querySongs();

    setState(() {
      _songs = songs;
    }); 
  
  }




  @override
  Widget build(BuildContext context) {
     final audioProvider = Provider.of<AudioPlayerProvider>(context);
    return Scaffold(
      backgroundColor: const  Color(0xff121212),
      appBar: AppBar(
        //App bar of the app
        backgroundColor: const  Color(0xff121212),
        title: const  Text("Recently Played",
        style: TextStyle(
          fontSize: 19,
          fontWeight: FontWeight.w600,
          color: Color(0xffffffff)
        )
        ),
        actions:  [
          IconButton(onPressed: (){
             Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  PlayerScreen(songs: _songs)),
        );
          }, icon: const Icon(Icons.notifications_none_rounded),color: const Color(0xffffffff),),
          const SizedBox(width: 10,),
          IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.clock),color: const Color(0xffffffff),),
          
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: IconButton(onPressed: (){

             Navigator.of(context).push(
  // ignore: non_constant_identifier_names
  MaterialPageRoute(builder: (MaterialAppContext) => SearchPage(songs: _songs,))
);
            }, icon: const Icon(Icons.search),color: Colors.white,),
          )
        ],
        elevation:04 ,
      ),


      body: ListView.builder(
        itemCount: _songs.length,
        itemBuilder: (context, index) {
          return ListTile(
            tileColor: audioProvider.isPlaying
                ? audioProvider.currentPlayingIndex == index
                    ? bgColor
                    : null
                : null,
            onTap: () {
              audioProvider.playPause(index, _songs);
              Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  PlayerScreen(songs: _songs)),
        );
            },
            leading: QueryArtworkWidget(
              id: _songs[index].id,
              type: ArtworkType.AUDIO,
              artworkWidth: 30,
              artworkHeight: 35,
              artworkBorder: BorderRadius.circular(6),
              nullArtworkWidget: const Icon(
                Icons.music_note,
                color: whiteColor,
                size: 28,
              )
            ),
            title: Text(
              _songs[index].title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style:const TextStyle(fontSize: 16, color: whiteColor),
            ),
            subtitle: Text(
              
              _songs[index].artist ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 13, color: subtitleColor),
            ),
            trailing: audioProvider.isPlaying
                ? audioProvider.currentPlayingIndex == index
                    ?const  Icon(Icons.graphic_eq, color: whiteColor)
                    : null
                : null,
                
          );
        },
      ),
      bottomNavigationBar: MiniPlayer(
        songs: _songs,
      ),
    );
      
  }
}