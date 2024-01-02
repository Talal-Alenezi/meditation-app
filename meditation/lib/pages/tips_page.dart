import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:meditation/providers/auth_povider.dart';
import 'package:meditation/providers/tips_provider.dart';
import 'package:meditation/services/cllient.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class TipsPage extends StatefulWidget {
  const TipsPage({Key? key}) : super(key: key);

  @override
  State<TipsPage> createState() => _TipsPageState();
}

class _TipsPageState extends State<TipsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  TextEditingController tipController = TextEditingController();
  TextEditingController searchController =
      TextEditingController(); // Add search controller

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
          title: Text('Add a New Tip',
              style: TextStyle(
                  color: const Color.fromARGB(255, 122, 128, 133),
                  fontSize: 25,
                  fontWeight: FontWeight.w800)),
          content: TextField(
            controller: tipController,
            decoration: InputDecoration(labelText: 'Enter your tip'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel',
                  style: TextStyle(
                      color: const Color.fromARGB(255, 122, 128, 133),
                      fontSize: 15,
                      fontWeight: FontWeight.bold)),
            ),
            TextButton(
              onPressed: () {
                String newTip = tipController.text;
                Navigator.of(context).pop(); // Close the dialog
                if (newTip.isNotEmpty) {
                  context.read<TipsProvider>().addTip(newTip);
                }
              },
              child: Text('Add Tip',
                  style: TextStyle(
                      color: const Color.fromARGB(255, 122, 128, 133),
                      fontSize: 15,
                      fontWeight: FontWeight.bold)),
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
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: searchController,
            onChanged: (value) {
              context.read<TipsProvider>().searchTips(value);
            },
            decoration: InputDecoration(
              labelText: 'Search by text or author',
              prefixIcon: Icon(Icons.search),
            ),
          ),
        ),
        Expanded(
          child: FutureBuilder(
            future: context.read<TipsProvider>().getTips(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.error != null) {
                return const Center(child: Text('An error occurred'));
              } else {
                return Consumer<TipsProvider>(
                  builder: (context, tipsProvider, child) {
                    tipsProvider.tipsList.sort((case1, case2) =>
                        (case2.upvotesCount - case2.downvotesCount).compareTo(
                            case1.upvotesCount - case1.downvotesCount));
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: tipsProvider.filteredTipsList.length,
                      // Use filteredTipsList instead of tipsList
                      itemBuilder: (context, index) {
                        String username = '';
                        final token = context.watch<AuthProvider>().token;
                        if (token.isNotEmpty) {
                          Map<String, dynamic>? decodedToken =
                              Jwt.parseJwt(token);
                          username = decodedToken['username'];
                          print('Username from token: $username');
                        }

                        var upvoteTips = [];
                        var downvoteTips = [];

                        Future<void> upvoteTip(int? Id) async {
                          if (!upvoteTips.contains(Id)) {
                            try {
                              await ApiClient.put('/tips/$Id/upvote');
                              final upvote = tipsProvider.filteredTipsList
                                  .firstWhere((e) => e.id == Id);
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
                              final downvote = tipsProvider.filteredTipsList
                                  .firstWhere((e) => e.id == Id);
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

                        void shareTip(String? text) {
                          Share.share(text!);
                        }

                        return Card(
                          child: ListTile(
                            title: Text(
                                "${tipsProvider.filteredTipsList[index].text}"),
                            // Use filteredTipsList instead of tipsList
                            subtitle: Text(
                                'By: ${tipsProvider.filteredTipsList[index].author}'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    upvoteTip(tipsProvider
                                        .filteredTipsList[index].id);
                                  },
                                  icon: Icon(
                                    Icons.arrow_drop_up,
                                    color: Colors.green,
                                  ),
                                ),
                                Text(
                                  '${tipsProvider.filteredTipsList[index].upvotes?.length}',
                                ),
                                SizedBox(width: 10),
                                IconButton(
                                  onPressed: () {
                                    downvoteTip(tipsProvider
                                        .filteredTipsList[index].id);
                                  },
                                  icon: Icon(Icons.arrow_drop_down,
                                      color: Colors.red),
                                ),
                                Text(
                                  '${tipsProvider.filteredTipsList[index].downvotes?.length}',
                                ),
                                SizedBox(width: 30),
                                IconButton(
                                    onPressed: () {
                                      shareTip(tipsProvider
                                          .filteredTipsList[index].text);
                                    },
                                    icon: Icon(
                                      Icons.share,
                                      size: 20,
                                    )),
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
        ),
      ],
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
              var deletedTips = [];
              Future<void> deleteTip(int? id) async {
                if (deletedTips.contains(id)) {}
                try {
                  await ApiClient.delete('/tips/$id');

                  tipsProvider.tipsList.removeWhere((e) => e.id == id);
                  tipsProvider.myTipsList.removeWhere((e) => e.id == id);
                  setState(() {
                    tipsProvider.tipsList = tipsProvider.tipsList;
                    tipsProvider.myTipsList = tipsProvider.myTipsList;
                  });
                } catch (error) {
                  print('Error deleting tip: $error');
                }
                tipsProvider.getTips();
                tipsProvider.myTips(username);
              }

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
                            onPressed: () {
                              deleteTip(tipsProvider.myTipsList[index].id);
                            },
                            icon: Icon(Icons.delete))),
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
