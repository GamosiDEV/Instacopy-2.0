import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:instacopy2/Model/uploads_model.dart';

class UserUploadFeedView extends StatefulWidget {
  List<UploadsModel> listOfUploads;

  UserUploadFeedView({Key? key, required this.listOfUploads}) : super(key: key);

  @override
  State<UserUploadFeedView> createState() => _UserUploadFeedViewState();
}

class _UserUploadFeedViewState extends State<UserUploadFeedView> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
