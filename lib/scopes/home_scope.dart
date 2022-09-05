import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../models/post_model.dart';
import '../pages/detail_page.dart';
import '../services/http_service.dart';





 class HomeScoped extends Model {
   List<Post> items = [];
   bool isLoading = false;

  void apiPostList(BuildContext context) async {
    isLoading = true;
    String? response =
    await Network.GET(Network.API_LIST, Network.paramsEmpty());
    if (response != null) {
      items = Network.parsePostList(response);
    } else {
      items = [];
    }
    isLoading = false;
    notifyListeners();

  }

  void apiPostDelete(BuildContext context, Post post) async {
    isLoading = true;
    String? response = await Network.DEL(
        Network.API_DELETE + post.id.toString(), Network.paramsEmpty());
    if (response != null) {
      apiPostList(context);
    }
    // apiPostList();
    isLoading = false;
    notifyListeners();
  }

  void goToDetailPage(context) async {
    String? response =
    await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return const DetailPage(
        state: DetailState.create,
      );
    }));
    if (response == "add") {
      apiPostList(context);
    }
    notifyListeners();
  }

  void goToDetailPageUpdate(Post post, context) async {
    String? response =
    await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return DetailPage(
        post: post,
        state: DetailState.update,
      );
    }));
    if (response == "refresh") {
      apiPostList(context);
    }
    notifyListeners();
  }

}