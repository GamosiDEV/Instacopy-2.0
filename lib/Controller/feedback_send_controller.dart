import 'package:instacopy2/Controller/firebase_database_controller.dart';
import 'package:instacopy2/firebase_cloudfirestore_names.dart';

class FeedbackSendController {
  final FirebaseDatabaseController _firebaseDatabaseController =
      FirebaseDatabaseController();

  Future<void> sendFeedbackToDatabase(Map<String, String> feedback) async {
    await _firebaseDatabaseController.sendFeedbakcToDatabase(feedback);
  }
}
