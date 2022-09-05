import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pattern_set_state/scopes/home_scope.dart';
import 'package:scoped_model/scoped_model.dart';
import '../models/post_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  HomeScoped homeScoped = HomeScoped();
  @override
  void initState() {
    super.initState();
    homeScoped.apiPostList(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pattern Scoped_model"),
      ),
      body: ScopedModel<HomeScoped>(
        model: homeScoped,
        child: ScopedModelDescendant<HomeScoped>(
          builder: (context, child, model){
            return Stack(
              children: [
                ListView.builder(
                    itemCount: homeScoped.items.length,
                    itemBuilder: (context, index) {
                      return itemsOfPost(homeScoped.items[index]);
                    }),
                Visibility(
                  visible: homeScoped.isLoading,
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: Colors.red,
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        onPressed: () {
          homeScoped.goToDetailPage(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget itemsOfPost(Post post) {
    return Slidable(
      key: UniqueKey(),
      startActionPane: ActionPane(
        extentRatio: 0.5,
        dismissible: DismissiblePane(onDismissed: () {
          homeScoped.apiPostDelete(context, post);
        }),
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              homeScoped.apiPostDelete(context, post);
            },
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete_outline,
          ),
          SlidableAction(
            onPressed: (context) {
              homeScoped.goToDetailPageUpdate(post, context);
            },
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            icon: Icons.update,
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Column(
          children: [
            Text(
              post.title.toUpperCase(),
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.w900),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              post.body,
              style: const TextStyle(color: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
