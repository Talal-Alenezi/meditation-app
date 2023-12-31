import 'package:flutter/material.dart';
import 'package:meditation/providers/tips_provider.dart';
import 'package:provider/provider.dart';

class TipsPage extends StatefulWidget {
  const TipsPage({Key? key}) : super(key: key);

  @override
  State<TipsPage> createState() => _TipsPageState();
}

class _TipsPageState extends State<TipsPage> {
  TextEditingController tipController = TextEditingController();

  void _showAddTipDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add a New Tip'),
          content: TextField(
            controller: tipController,
            decoration: InputDecoration(labelText: 'Enter your tip'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                String newTip = tipController.text;
                print(newTip);
                Navigator.of(context).pop(); // Close the dialog
                if (newTip.isNotEmpty) {
                  context.read<TipsProvider>().addTip(newTip);
                }
              },
              child: Text('Add Tip'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tips'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _showAddTipDialog(context),
          ),
        ],
      ),
      body: FutureBuilder(
        future: context.read<TipsProvider>().getTips(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.error != null) {
            return const Center(child: Text('An error occurred'));
          } else {
            return Consumer<TipsProvider>(
              builder: (context, tipsProvider, child) {
                return ListView.builder(
                  shrinkWrap: true,
                  // physics: const NeverScrollableScrollPhysics(),
                  itemCount: tipsProvider.tipsList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text("${tipsProvider.tipsList[index].text}"),
                        subtitle: Text(
                            'Author: ${tipsProvider.tipsList[index].author}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.arrow_drop_up),
                            ),
                            Text(
                              '${tipsProvider.tipsList[index].upvotes?.length}',
                            ),
                            SizedBox(width: 10),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.arrow_drop_down),
                            ),
                            Text(
                              '${tipsProvider.tipsList[index].downvotes?.length}', // Replace with actual downvote count
                            ),
                          ],
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
