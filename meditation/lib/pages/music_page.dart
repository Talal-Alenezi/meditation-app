import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:meditation/providers/music_provider.dart';
import 'package:provider/provider.dart';

class MusicPage extends StatelessWidget {
  const MusicPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Music'),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              GoRouter.of(context).push('/profile');
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: context.read<MusicProvider>().getMusic(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.error != null) {
            return const Center(child: Text('An error occurred'));
          } else {
            return Consumer<MusicProvider>(
              builder: (context, musicProvider, child) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: musicProvider.musicList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text("${musicProvider.musicList[index].title}"),
                        subtitle: ElevatedButton(
                          onPressed: () {
                            final musicUrl =
                                musicProvider.musicList[index].file;
                            GoRouter.of(context)
                                .push("/mediaPlayer", extra: musicUrl);
                          },
                          child: Text("Listen to the music track",
                              style: TextStyle(color: Colors.black)),
                        ),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
