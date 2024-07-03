import 'package:flutter/material.dart';
import 'package:test_test/bright_code/bright_code_util.dart';

AppBar customAppbar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.black,
    title: const Text(
      "Edit Movie",
      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22),
    ),
    centerTitle: true,
    leading: IconButton(
        onPressed: () => context.pop(),
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 30)),
  );
}
