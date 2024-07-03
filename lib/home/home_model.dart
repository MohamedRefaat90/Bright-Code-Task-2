import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '../bright_code/bright_code_theme.dart';
import '../bright_code/bright_code_util.dart';
import '../bright_code/bright_code_widgets.dart';
import 'home_widget.dart' show HomeWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeModel extends bright_codeModel<HomeWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
