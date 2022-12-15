import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:instacopy2/Controller/application_controller.dart';
import 'package:instacopy2/Controller/profile_editing_controller.dart';
import 'package:instacopy2/Model/users_model.dart';
import 'package:transparent_image/transparent_image.dart';

class ProfileEditingView extends StatefulWidget {
  UsersModel userModel;
  ProfileEditingView({Key? key, required this.userModel}) : super(key: key);

  @override
  State<ProfileEditingView> createState() => _ProfileEditingViewState();
}

class _ProfileEditingViewState extends State<ProfileEditingView> {
  GlobalKey _formKey = new GlobalKey();
  String? _selectedFilePath;
  ProfileEditingController _profileEditingController =
      ProfileEditingController();

  TextEditingController fullnameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController genereController = TextEditingController();
  TextEditingController linksController = TextEditingController();
  TextEditingController birthController = TextEditingController();
  DateTime birth = DateTime.now();

  var mounths = [
    'Janeiro',
    'Fevereiro',
    'Março',
    'Abril',
    'Maio',
    'Junho',
    'Julho',
    'Agosto',
    'Setembro',
    'Outubro',
    'Novembro',
    'Dezembro'
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        setFieldsWithLoggedUser();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: hasUserDataChage() ? updateProfileAndReturn : null,
              icon: Icon(Icons.check),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(6, 4, 6, 4),
            child: Card(
              child: Container(
                alignment: Alignment.topCenter,
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      InkWell(
                        onTap: changeProfileImage,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipOval(
                            child: SizedBox.fromSize(
                                size: Size.fromRadius(48),
                                child: widget.userModel.profileImageReference ==
                                            null ||
                                        widget.userModel
                                                .profileImageReference ==
                                            '' ||
                                        _selectedFilePath != null
                                    ? showPlaceholderImage()
                                    : showCurrentProfileImage()),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                              text: 'Alterar imagem de Perfil',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.lightBlue),
                              recognizer: TapGestureRecognizer()
                                ..onTap = changeProfileImage),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) return 'Insira um nome';
                          },
                          controller: fullnameController,
                          onChanged: ((value) {
                            setState(() {});
                          }),
                          decoration: InputDecoration(
                            labelText: 'Nome Completo',
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty)
                              return 'Insira um nome de usuario';
                          },
                          controller: usernameController,
                          onChanged: ((value) {
                            setState(() {});
                          }),
                          decoration: InputDecoration(
                            labelText: 'Nome de Usuario',
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextField(
                          controller: genereController,
                          onChanged: ((value) {
                            setState(() {});
                          }),
                          //TODO:Feminino/Masculino/Personalizado/Não informar
                          decoration: InputDecoration(
                            labelText: 'Genero',
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextField(
                          controller: bioController,
                          onChanged: ((value) {
                            setState(() {});
                          }),
                          decoration: InputDecoration(
                            labelText: 'Bio',
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextField(
                          controller: linksController,
                          onChanged: ((value) {
                            setState(() {});
                          }),
                          decoration: InputDecoration(
                            labelText: 'Links',
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextField(
                          onTap: () {
                            showDatePicker(
                              context: context,
                              initialDate: birth,
                              firstDate: DateTime(1850),
                              lastDate: DateTime.now(),
                            ).then((value) {
                              setState(() {
                                birth = value!;
                                setBirthDateToController();
                              });
                            });
                          },
                          readOnly: true,
                          controller: birthController,
                          onChanged: ((value) {
                            setState(() {});
                          }),
                          decoration: InputDecoration(
                            labelText: 'Data de Nascimento',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  void setFieldsWithLoggedUser() {
    if (widget.userModel != null) {
      setState(() {
        usernameController.text = widget.userModel.username;
        if (widget.userModel.fullname != null)
          fullnameController.text = widget.userModel.fullname;
        if (widget.userModel.genere != null)
          genereController.text = widget.userModel.genere;
        if (widget.userModel.bio != null) {
          bioController.text = widget.userModel.bio;
        }
        if (widget.userModel.myLinks != null)
          linksController.text = widget.userModel.myLinks;
        if (widget.userModel.birthDate != null) {
          birth = widget.userModel.birthDate.toDate();
          setBirthDateToController();
        }
      });
    }
  }

  void updateProfileAndReturn() {
    UsersModel updateOfUser = widget.userModel;
    updateOfUser.fullname = fullnameController.text;
    updateOfUser.username = usernameController.text;
    updateOfUser.genere = genereController.text;
    updateOfUser.bio = bioController.text;
    updateOfUser.myLinks = linksController.text;
    updateOfUser.birthDate = Timestamp.fromDate(birth);

    updateProfileImage();

    updadeProfileData(updateOfUser);

    Navigator.pop(context, true);
  }

  Future<void> updateProfileImage() async {
    if (_selectedFilePath != null) {
      await _profileEditingController.updateProfileImage(
          _selectedFilePath.toString(), widget.userModel.profileImageReference);
    }
  }

  Future<void> updadeProfileData(UsersModel updateUser) async {
    await _profileEditingController.updateProfileData(updateUser);
  }

  Widget showCurrentProfileImage() {
    return FutureBuilder(
        future: getUrlFromProfileImage(),
        builder: (context, snapshot) {
          if (snapshot.data == null || snapshot.data == '') {
            return Container();
          }
          String url = snapshot.data as String;
          return Image.network(url);
        });
  }

  Future<String> getUrlFromProfileImage() async {
    if (widget.userModel.profileImageUrl != null &&
        widget.userModel.profileImageUrl != '') {
      return widget.userModel.profileImageUrl;
    }
    return await _profileEditingController
        .getUrlFromProfileImageWith(widget.userModel)
        .then((urlFromProfileImage) {
      return urlFromProfileImage;
    });
  }

  Widget showPlaceholderImage() {
    if (_selectedFilePath != null && _selectedFilePath != '') {
      return Image.file(
        File(_selectedFilePath!),
        fit: BoxFit.cover,
      );
    }
    return FadeInImage(
        fit: BoxFit.contain,
        placeholder: MemoryImage(kTransparentImage),
        image: placeHolderProfileImage());
  }

  ImageProvider placeHolderProfileImage() {
    return const AssetImage('assets/images/profile.jpg');
  }

  void changeProfileImage() async {
    final image = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg'],
    );

    if (hasImageValid(image)) {
      setState(() {
        setSelectedImageToPlace(image?.files.single.path);
      });
    }
  }

  bool hasImageValid(final selectedImage) {
    if (selectedImage == null) {
      return false;
    }
    return true;
  }

  void setSelectedImageToPlace(final path) {
    _selectedFilePath = path;
  }

  void setBirthDateToController() {
    birthController.text = birth.day.toString() +
        " de " +
        mounths[birth.month - 1] +
        " de " +
        birth.year.toString();
  }

  bool hasUserDataChage() {
    if (_selectedFilePath != null) return true;
    if (fullnameController.text != widget.userModel.fullname) return true;
    if (usernameController.text != widget.userModel.username) return true;
    if (genereController.text != widget.userModel.genere) return true;
    if (bioController.text != widget.userModel.bio) return true;
    if (linksController.text != widget.userModel.myLinks) return true;
    if (birth != widget.userModel.birthDate.toDate()) return true;

    return false;
  }
}
