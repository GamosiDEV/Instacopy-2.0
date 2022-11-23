import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:instacopy2/Controller/application_controller.dart';
import 'package:instacopy2/Controller/upload_editor_controller.dart';
import 'package:instacopy2/Model/uploads_model.dart';

class UploadEditorView extends StatefulWidget {
  UploadsModel upload;

  UploadEditorView({Key? key, required this.upload}) : super(key: key);

  @override
  State<UploadEditorView> createState() => _UploadEditorViewState();
}

class _UploadEditorViewState extends State<UploadEditorView> {
  TextEditingController _uploadDescriptionController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  UploadEditorController _uploadEditorController = UploadEditorController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _uploadDescriptionController.text = widget.upload.description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          alignment: Alignment.centerLeft,
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Editar descrição"),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: _uploadDescriptionController.text !=
                    widget.upload.description
                ? () {
                    updateDescription();
                    ApplicationController.showSnackBar(
                        'Descrição atualizada!', context);
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  }
                : null,
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(8.0),
                child: Card(
                  child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        maxLines: 7,
                        onChanged: (value) => setState(() {}),
                        controller: _uploadDescriptionController,
                        decoration: const InputDecoration(
                          hintText: 'Digite uma descrição para imagem',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void updateDescription() {
    _uploadEditorController.updateDescription(
        widget.upload.keyFromUpload, _uploadDescriptionController.text);
  }
}
