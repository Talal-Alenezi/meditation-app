import 'package:flutter/material.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:meditation/providers/auth_povider.dart';
import 'package:meditation/providers/tips_provider.dart';
import 'package:provider/provider.dart';
import 'package:meditation/models/tips_model.dart';

class TipsPage extends StatefulWidget {
  const TipsPage({Key? key}) : super(key: key);

  @override
  State<TipsPage> createState() => _TipsPageState();
}

class _TipsPageState extends State<TipsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  TextEditingController tipController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

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
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'All Tips'),
            Tab(text: 'My Tips'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildTipsList(context),
          _buildMyTipsList(context),
        ],
      ),
    );
  }

  Widget _buildTipsList(BuildContext context) {
    return FutureBuilder(
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
                          'By: ${tipsProvider.tipsList[index].author}'),
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
    );
  }

  Widget _buildMyTipsList(BuildContext context) {
    String username = '';
    final token = context.watch<AuthProvider>().token;
    if (token.isNotEmpty) {
      Map<String, dynamic>? decodedToken = Jwt.parseJwt(token);
      username = decodedToken['username'];
      print('Username from token: $username');
    }
    return FutureBuilder(
      future: context.read<TipsProvider>().myTips(username),
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
                itemCount: tipsProvider.myTipsList.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text("${tipsProvider.myTipsList[index].text}"),
                      subtitle: Text(
                          'By: ${tipsProvider.myTipsList[index].author}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.arrow_drop_up),
                          ),
                          Text(
                            '${tipsProvider.myTipsList[index].upvotes?.length}',
                          ),
                          SizedBox(width: 10),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.arrow_drop_down),
                          ),
                          Text(
                            '${tipsProvider.myTipsList[index].downvotes?.length}', // Replace with actual downvote count
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
    );
  }
}
