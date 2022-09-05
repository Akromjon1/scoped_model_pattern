import 'dart:math';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../models/post_model.dart';
import '../services/http_service.dart';



 class DetailScope extends Model {
   TextEditingController titleController = TextEditingController();
   TextEditingController bodyController = TextEditingController();
   bool isLoading = false;



  void updatePost(context) async {
    String title = titleController.text.trim();
    String body = bodyController.text.trim();
    Post post = Post(
        id: Random().nextInt(100),
        title: title,
        body: body,
        userId: Random().nextInt(100));
    isLoading = true;
    Network.PUT(Network.API_UPDATE, post.toJson()).then((value) {
      Navigator.pop(context, "refresh");
    });
    isLoading = false;
  }

  void addPage(context) async {
    String title = titleController.text.trim();
    String body = bodyController.text.trim();
    Post post = Post(
        id: Random().nextInt(100),
        title: title,
        body: body,
        userId: Random().nextInt(100));
    isLoading = true;
    Network.POST(Network.API_UPDATE, post.toJson()).then((value) {
      Navigator.pop(context, "add");
    });
    isLoading = false;
  }

}





