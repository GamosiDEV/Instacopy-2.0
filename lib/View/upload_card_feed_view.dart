import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:instacopy2/Model/uploads_model.dart';

class UploadCardFeedView extends StatefulWidget {
  UploadsModel upload;

  UploadCardFeedView({Key? key, required this.upload}) : super(key: key);

  @override
  State<UploadCardFeedView> createState() => _UploadCardFeedViewState();
}

class _UploadCardFeedViewState extends State<UploadCardFeedView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(widget.upload.keyFromUpload),
    );
  }
}
