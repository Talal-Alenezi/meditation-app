import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meditation/providers/exercises_provider.dart';
import 'package:provider/provider.dart';

class Exercises extends StatelessWidget {
  const Exercises({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yoga'),
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
        future: context.read<ExercisesProvider>().getExercises(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.error != null) {
            return const Center(child: Text('An error occurred'));
          } else {
            return Consumer<ExercisesProvider>(
              builder: (context, exercisesProvider, child) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: exercisesProvider.exercisesList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(
                            "${exercisesProvider.exercisesList[index].title}"),
                        subtitle: Text(
                            '${exercisesProvider.exercisesList[index].file}'),
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
