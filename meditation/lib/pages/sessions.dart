import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meditation/providers/sessions_provider.dart';
import 'package:provider/provider.dart';

class Sessions extends StatelessWidget {
  const Sessions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sessions'),
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
        future: context.read<SessionProvider>().getSessions(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.error != null) {
            return const Center(child: Text('An error occurred'));
          } else {
            return Consumer<SessionProvider>(
              builder: (context, sessionProvider, child) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: sessionProvider.sessionsList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(
                            "${sessionProvider.sessionsList[index].title}"),
                        // subtitle:
                        //     Text('${sessionProvider.sessionsList[index].file}'),
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
