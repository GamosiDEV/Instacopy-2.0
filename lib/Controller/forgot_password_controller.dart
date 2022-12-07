import 'firebase_database_controller.dart';

class ForgotPasswordController {
  final FirebaseDatabaseController _firebaseDatabaseController =
      FirebaseDatabaseController();

  Future<void> sendForgotPasswordMessageByEmail(String email) async {
    await _firebaseDatabaseController.sendForgotPasswordMessage(email);
  }
}
