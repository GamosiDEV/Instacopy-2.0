import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:instacopy2/Controller/commentaries_controller.dart';
import 'package:instacopy2/Model/uploads_model.dart';

class CommentariesView extends StatefulWidget {
  UploadsModel upload;

  CommentariesView({Key? key, required this.upload}) : super(key: key);

  @override
  State<CommentariesView> createState() => _CommentariesViewState();
}

class _CommentariesViewState extends State<CommentariesView> {
  TextEditingController _newCommentarieTextFieldController =
      TextEditingController();

  CommentariesController _commentariesController = CommentariesController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Publicação'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(4.0),
              child: Card(),
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(4.0),
            child: Card(
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 0.0, 4.0, 0.0),
                      child: TextField(
                        controller: _newCommentarieTextFieldController,
                        decoration: const InputDecoration(
                          hintText: 'Digite seu comentario',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: TextButton(
                      onPressed: sendCommentarieToDatabaseAndRefresh,
                      child: Text(
                        'Publicar',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void sendCommentarieToDatabaseAndRefresh() {
    uploadCommentarie().then((value) {
      setState(() {});
    });
  }

  Future<void> uploadCommentarie() async {
    await _commentariesController.uploadCommentarie(
        _newCommentarieTextFieldController.text, widget.upload);
  }
}
