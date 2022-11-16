import 'package:instacopy2/Controller/firebase_database_controller.dart';

class UploadCardFeedController {
  FirebaseDatabaseController _firebaseDatabaseController =
      FirebaseDatabaseController();

  Future<String> getImageUrlBy(String reference) async {
    return await _firebaseDatabaseController.getImageUrlBy(reference);
  }
}
