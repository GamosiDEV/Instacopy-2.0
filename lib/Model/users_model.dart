import 'package:cloud_firestore/cloud_firestore.dart';

class UsersModel {
  String bio = '';
  Timestamp birthDate = Timestamp.now();
  List<String> commentsSended = [];
  String email = '';
  List<String> followedBy = [];
  List<String> followerOf = [];
  String fullname = '';
  String genere = '';
  String keyFromUser = '';
  List<String> likesInComments = [];
  List<String> likesInUploads = [];
  String myLinks = '';
  String profileImageReference = '';
  List<String> savedPosts = [];
  List<String> userUploads = [];
  String username = '';

  UsersModel(this.keyFromUser);
}
