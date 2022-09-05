import 'package:flutter/material.dart';
import 'package:pattern_set_state/scopes/detail_scope.dart';
import 'package:scoped_model/scoped_model.dart';
import '../models/post_model.dart';

enum DetailState { create, update }

class DetailPage extends StatefulWidget {
  final Post? post;
  final DetailState state;

  const DetailPage({Key? key, this.post, this.state = DetailState.create})
      : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  DetailScope detailScope = DetailScope();
  void init() {
    if (widget.state == DetailState.update) {
      detailScope.titleController = TextEditingController(text: widget.post!.title);
      detailScope.bodyController = TextEditingController(text: widget.post!.body);
    }
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<DetailScope>(model: detailScope,
        child: ScopedModelDescendant<DetailScope>(
          builder: (context, child, model){
            return Scaffold(
              appBar: AppBar(
                centerTitle: false,
                title: widget.state == DetailState.create
                    ? const Text("Add post")
                    : const Text("Update post"),
              ),
              body: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        TextField(
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          controller: detailScope.titleController,
                          decoration: InputDecoration(
                              label: const Text("Title"),
                              hintText: "Title",
                              hintStyle: TextStyle(
                                color: Colors.grey.shade400,
                              ),
                              border: const OutlineInputBorder()),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextField(
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          controller: detailScope.bodyController,
                          decoration: InputDecoration(
                              label: const Text("Body"),
                              hintText: "Body",
                              hintStyle: TextStyle(color: Colors.grey.shade400),
                              border: const OutlineInputBorder()),
                        ),
                        const SizedBox(height: 20,),
                        MaterialButton(
                          color: Colors.blue,
                          onPressed: () {
                            if (widget.state == DetailState.create) {
                              detailScope.addPage(context);
                            } else {
                              detailScope.updatePost(context);
                            }
                          },
                          child: const Text("Submit Text"),
                        )
                      ],
                    ),
                  ),
                  Visibility(
                    visible: detailScope.isLoading,
                    child: const CircularProgressIndicator(
                      color: Colors.red,
                    ),
                  )
                ],
              ),
            );
          },
        ));
  }
}
