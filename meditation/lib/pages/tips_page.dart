import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:meditation/providers/auth_povider.dart';
import 'package:meditation/providers/tips_provider.dart';
import 'package:meditation/services/cllient.dart';
import 'package:provider/provider.dart';

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
            icon: Icon(Icons.person),
            onPressed: () {
              GoRouter.of(context).push('/profile');
            },
          ),
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
              //to sort the tips by the votes
              tipsProvider.tipsList.sort((case1, case2) =>
                  (case2.upvotesCount - case2.downvotesCount)
                      .compareTo(case1.upvotesCount - case1.downvotesCount));
              return ListView.builder(
                shrinkWrap: true,
                itemCount: tipsProvider.tipsList.length,
                itemBuilder: (context, index) {
                  ///upvote & downvote

                  String username = '';
                  final token = context.watch<AuthProvider>().token;
                  if (token.isNotEmpty) {
                    Map<String, dynamic>? decodedToken = Jwt.parseJwt(token);
                    username = decodedToken['username'];
                    print('Username from token: $username');
                  }

                  var upvoteTips = [];
                  var downvoteTips = [];

                  Future<void> upvoteTip(int? Id) async {
                    if (!upvoteTips.contains(Id)) {
                      try {
                        await ApiClient.put('/tips/$Id/upvote');
                        final upvote =
                            tipsProvider.tipsList.firstWhere((e) => e.id == Id);
                        if (upvote.upvotes!.isNotEmpty) {
                          setState(() {
                            upvote.upvotesCount++;
                            upvote.upvotes?.add(username);

                            if (upvote.downvotes!.contains(username)) {
                              upvote.downvotes!.remove(username);
                              upvote.downvotesCount--;
                            }
                          });
                        }
                      } catch (error) {
                        print('Error upvoting tip: $error');
                      }
                    }
                    tipsProvider.getTips();
                  }

                  Future<void> downvoteTip(int? Id) async {
                    if (!downvoteTips.contains(Id)) {
                      try {
                        await ApiClient.put('/tips/$Id/downvote');
                        final downvote =
                            tipsProvider.tipsList.firstWhere((e) => e.id == Id);
                        if (downvote.downvotes!.isNotEmpty) {
                          setState(() {
                            downvote.downvotesCount++;
                            downvote.downvotes?.add(username);

                            if (downvote.upvotes!.contains(username)) {
                              downvote.upvotes!.remove(username);
                              downvote.upvotesCount--;
                            }
                          });
                        }
                      } catch (error) {
                        print('Error upvoting tip: $error');
                      }
                    }
                    tipsProvider.getTips();
                  }

                  return Card(
                    child: ListTile(
                      title: Text("${tipsProvider.tipsList[index].text}"),
                      subtitle:
                          Text('By: ${tipsProvider.tipsList[index].author}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              upvoteTip(tipsProvider.tipsList[index].id);
                            },
                            icon: Icon(Icons.arrow_drop_up),
                          ),
                          Text(
                            '${tipsProvider.tipsList[index].upvotes?.length}',
                          ),
                          SizedBox(width: 10),
                          IconButton(
                            onPressed: () {
                              downvoteTip(tipsProvider.tipsList[index].id);
                            },
                            icon: Icon(Icons.arrow_drop_down),
                          ),
                          Text(
                            '${tipsProvider.tipsList[index].downvotes?.length}',
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
                itemCount: tipsProvider.myTipsList.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                        title: Text("${tipsProvider.myTipsList[index].text}"),
                        subtitle: Text(
                            'By: ${tipsProvider.myTipsList[index].author}'),
                        trailing: IconButton(
                            onPressed: () {}, icon: Icon(Icons.delete))),
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
