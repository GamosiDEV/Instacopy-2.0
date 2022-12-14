import 'package:instacopy2/Controller/firebase_database_controller.dart';
import 'package:instacopy2/Model/users_model.dart';

class SearchCardController {
  FirebaseDatabaseController _firebaseDatabaseController =
      FirebaseDatabaseController();

  Future<List<UsersModel>> searchInPreLoadedList(
      String profileUserKey, String searchString, String followListName) async {
    return await _firebaseDatabaseController.searchUsersInPreLoadedList(
        profileUserKey, searchString, followListName);
  }

  Future<List<UsersModel>> searchInAllUsers(String searchString) async {
    return await _firebaseDatabaseController.searchUsers(searchString);
  }

  Future<String> getProfileImageUrlWith(UsersModel user) async {
    return await _firebaseDatabaseController.getProfileImageUrlFrom(user);
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
