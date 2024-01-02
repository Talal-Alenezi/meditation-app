import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final List<Map<String, dynamic>> cards = [
    {
      'title': 'Tips',
      'icon': Icons.lightbulb_rounded,
      'route': 'tips',
    },
    {
      'title': 'Yoga Videos',
      'icon': Icons.ondemand_video_rounded,
      'route': 'yogaVideos',
    },
    {
      'title': 'Music',
      'icon': Icons.music_note_rounded,
      'route': 'music',
    },
    {
      'title': 'Meditation',
      'icon': Icons.mood_rounded,
      'route': 'meditation',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              GoRouter.of(context).push('/profile');
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: cards.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              GoRouter.of(context).push("/${cards[index]['route']}");
            },
            child: Card(
              elevation: 5.0,
              margin: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Icon(
                    cards[index]['icon'],
                    size: 150.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      cards[index]['title'],
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
