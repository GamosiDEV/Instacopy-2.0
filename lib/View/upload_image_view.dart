import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:file_picker/file_picker.dart';

class UploadImageView extends StatefulWidget {
  const UploadImageView({Key? key}) : super(key: key);

  @override
  State<UploadImageView> createState() => _UploadImageViewState();
}

class _UploadImageViewState extends State<UploadImageView> {
  bool hasUploadEnabled = true;
  String? _selectedFilePath;
  final _formKey = GlobalKey<FormState>();
  final imageDescriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            }),
        actions: [
          IconButton(
              onPressed: hasUploadEnabled && hasSlectedFilePathValid()
                  ? () {
                      disableUploadButton();
                      uploadNewImageToLoggedProfile();
                      popUploadImageView();
                    }
                  : null,
              icon: Icon(Icons.check))
        ],
      ),
      body: Container(
          width: double.infinity,
          height: double.infinity,
          child: ListView(
            children: [
              InkWell(
                onTap: selectImageFromHardwareStorage,
                child: Container(
                    height: MediaQuery.of(context).size.height * 0.65,
                    child: (_selectedFilePath == null)
                        ? SizedBox(
                            height: 400,
                            child: Container(
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.bottomLeft,
                                    end: Alignment.topRight,
                                    colors: [
                                      Color(0xFFFFB344),
                                      Color(0xFFE60064),
                                    ]),
                              ),
                              height: 300,
                              child: const Center(
                                child: Text('Aperte para selecionar uma imagem',
                                    style: TextStyle(
                                      color: Color(0xFFFAFAFA),
                                      fontSize: 18,
                                    )),
                              ),
                            ),
                          )
                        : FadeInImage(
                            fit: BoxFit.contain,
                            placeholder: MemoryImage(kTransparentImage),
                            image: Image.file(File(_selectedFilePath!)).image)),
              ),
              Container(
                padding: EdgeInsets.all(6.0),
                child: Card(
                  child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        maxLines: 7,
                        controller: imageDescriptionController,
                        decoration: const InputDecoration(
                          hintText: 'Digite uma descrição para imagem',
                          border: InputBorder.none,
                        ),
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'Caption is empty';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  void uploadNewImageToLoggedProfile() {}

  void disableUploadButton() {
    setState(() {
      hasUploadEnabled = false;
    });
  }

  void popUploadImageView() {
    Navigator.pop(context);
  }

  Future<void> selectImageFromHardwareStorage() async {
    final image = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg'],
    );

    if (hasImageValid(image)) {
      setState(() {
        setImagePath(image?.files.single.path);
      });
    }
  }

  bool hasImageValid(final selectedImage) {
    if (selectedImage == null) {
      return false;
    }
    return true;
  }

  void setImagePath(String? path) {
    _selectedFilePath = path;
  }

  bool hasSlectedFilePathValid() {
    if (_selectedFilePath != null) {
      return true;
    }
    return false;
  }
}
