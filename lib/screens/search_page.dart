import 'package:flutter/material.dart';
import 'package:music_player/constants/colors.dart';
import 'package:music_player/providers/audio_player_providers.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget  {
   const SearchPage({super.key, required this.songs});
 
 final List<SongModel> songs;
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
 final  TextEditingController _searchController = TextEditingController();
 final OnAudioQuery audioQuery = OnAudioQuery();
  List<SongModel> _searchResults = [];

  @override
  void initState() {
    super.initState();
    _fetchSongs();
  }

  


   Future<void> _fetchSongs() async {
    List<SongModel> songs = await audioQuery.querySongs();

    setState(() {
      songs = songs;
    });    
    
  }
  void _filterSearchResults(String searchItem) {
    if (searchItem.isNotEmpty) {
      List<SongModel> dummyListData = [];
      for (int i=0;i<widget.songs.length;i++) {
        if (widget.songs[i].title.toLowerCase().contains(searchItem.toLowerCase())) {
          dummyListData.add(widget.songs[i]);
        }
      }
      setState(() {
        _searchResults = dummyListData;
      });
      return;
    } 
  }


  @override
      Widget build(BuildContext context) {
        //print("hello");
        final audioProvider = Provider.of<AudioPlayerProvider>(context);
        return Scaffold(
          backgroundColor: const  Color(0xff121212),
          appBar: AppBar(
          elevation: 4,
          backgroundColor: const Color(0xff121212),
          title: TextField(
        onChanged: (value) {
          _filterSearchResults(value);
        },
        controller: _searchController,
        cursorColor: Colors.white,
        decoration: const InputDecoration(
          hintText: "Search",
          hintStyle: TextStyle(color: Colors.white),
          prefixIcon: Icon(Icons.search, color: Colors.white),
          border: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
        ),
        style: const TextStyle(color: Colors.white),
      ),
    ),

      
     
      body: 
      ListView.builder(
        itemCount: _searchResults.length,
        itemBuilder: (context, index) {
          return ListTile(
            tileColor: audioProvider.isPlaying
                ? audioProvider.currentPlayingIndex == index
                    ? bgColor
                    : null
                : null,
            onTap: () {
              audioProvider.playPause(index, _searchResults);
            },
            leading: QueryArtworkWidget(
              id: _searchResults[index].id,
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
              _searchResults[index].title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style:const TextStyle(fontSize: 16, color: whiteColor),
            ),
            subtitle: Text(
              
              _searchResults[index].artist ?? '',
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

      
     
      // bottomNavigationBar: Column(
      //   children: [
         
      //     MiniPlayer(
      //       songs: widget.songs,
      //     ),
      //  ],
     // ),
    );
  }
}