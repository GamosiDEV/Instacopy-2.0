import 'package:instacopy2/Controller/firebase_database_controller.dart';
import 'package:instacopy2/Model/uploads_model.dart';

class TabFeedController {
  FirebaseDatabaseController _firebaseDatabaseController =
      FirebaseDatabaseController();

  Future<List<UploadsModel>> getListOfPostForFeed() async {
    return await _firebaseDatabaseController.getListOfPostForFeed();
  }
}
