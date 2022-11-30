import 'package:instacopy2/Controller/firebase_database_controller.dart';
import 'package:instacopy2/Model/users_model.dart';

class SearchCardController {
  FirebaseDatabaseController _firebaseDatabaseController =
      FirebaseDatabaseController();

  Future<List<UsersModel>> searchInPreLoadedList(
      List<String>? preLoadedListOfSearch, String searchString) async {
    return await _firebaseDatabaseController.searchUsersInPreLoadedList(
        preLoadedListOfSearch, searchString);
  }

  Future<List<UsersModel>> searchInAllUsers(String searchString) async {
    return await _firebaseDatabaseController.searchUsers(searchString);
  }

  Future<String> getProfileImageUrlWith(String imageReference) async {
    return await _firebaseDatabaseController
        .getProfileImageUrlFrom(imageReference);
  }

  Future<void> followUserBy(String userKey) async {
    return await _firebaseDatabaseController.followUserBy(userKey);
  }

  Future<void> unfollowUserBy(String userKey) async {
    return await _firebaseDatabaseController.unfollowUserBy(userKey);
  }

  Future<void> removeFollowerBy(String userKey) async {
    return await _firebaseDatabaseController.removeFollowerBy(userKey);
  }
}
