import 'package:flutter/material.dart';
import 'package:music_player/providers/audio_player_providers.dart';
import 'package:music_player/screens/home.dart';
import 'package:provider/provider.dart';
//import 'package:music_player/screens/start.dart';

void main() {
  
  runApp(
    
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AudioPlayerProvider()),
      ],
       child: const  MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home:   Home(),
      );
  }
}

