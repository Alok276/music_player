import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;


   const CustomListTile({super.key, 
    required this.imagePath,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8.0), 
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
          width: 45,
          height: 45,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Color(0xffffffff),
        ),
      ),
      subtitle: Text(
        subtitle,
        style:const  TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Color.fromARGB(146, 255, 255, 255),
        ),
      ),
      trailing: const Icon(
        Icons.more_vert,
        size: 24,
        color: Colors.white,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      tileColor: const Color(0xFF121212), // Change this to match the background color in your design
    );
  }
}