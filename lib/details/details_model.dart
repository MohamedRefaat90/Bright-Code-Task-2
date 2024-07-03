import '../bright_code/bright_code_util.dart';
import 'details_widget.dart' show DetailsWidget;
import 'package:flutter/material.dart';

class DetailsModel extends bright_codeModel<DetailsWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
