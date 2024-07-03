import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test_test/add_movie/widgets/custom_btn.dart';
import 'package:test_test/add_movie/widgets/custom_text_field.dart';
import 'package:test_test/add_movie/widgets/flushbar.dart';
import 'package:test_test/backend/backend.dart';
import 'package:test_test/bright_code/bright_code_util.dart';

import '../widgets/custom_appbar.dart';

class AddMovieScreen extends StatefulWidget {
  final DocumentReference? filmdeatilsParamiters;
  const AddMovieScreen({super.key, this.filmdeatilsParamiters});
  @override
  State<AddMovieScreen> createState() => _AddMovieScreenState();
}

class _AddMovieScreenState extends State<AddMovieScreen> {
  TextEditingController title = TextEditingController();
  TextEditingController disc = TextEditingController();
  TextEditingController trailer = TextEditingController();
  TextEditingController gener = TextEditingController();
  TextEditingController length = TextEditingController();
  TextEditingController year = TextEditingController();
  final ImagePicker picker = ImagePicker();
  XFile? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,
      appBar: customAppbar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              CustomTextField(
                  placeholderText: "Movie Name", textEditingController: title),
              CustomTextField(
                  placeholderText: "Movie Discription",
                  textEditingController: disc),
              CustomTextField(
                  placeholderText: "Trailer Link",
                  textEditingController: trailer),
              CustomTextField(
                  placeholderText: "Gener", textEditingController: gener),
              CustomTextField(
                  placeholderText: "Length", textEditingController: length),
              CustomTextField(
                  placeholderText: "Year",
                  inputFormat: FilteringTextInputFormatter.digitsOnly,
                  keyboardType: TextInputType.number,
                  textEditingController: year),
              const SizedBox(height: 20),
              image == null
                  ? IconButton(
                      onPressed: () => pickImageForMovie(),
                      padding: const EdgeInsets.all(0),
                      icon: const Icon(
                        Icons.image_search,
                        size: 50,
                        color: Colors.grey,
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white)),
                      child: Image.file(
                        File(image!.path),
                        height: 170,
                      ),
                    ),
              const SizedBox(height: 50),
              CustomBTN(
                widget: const Text("Add", style: TextStyle(fontSize: 20)),
                padding: 15,
                radius: 10,
                width: double.infinity,
                color: Colors.amber,
                press: () {
                  try {
                    FirebaseFirestore.instance
                        .collection('movies')
                        .add(createMoviesRecordData(
                            title: title.text,
                            discription: disc.text,
                            gener: gener.text,
                            image: image?.path ?? "",
                            lenth: length.text,
                            year: int.parse(year.text),
                            trailerLInke: trailer.text))
                        .then(
                      (value) {
                        flushBar(context, "Movie Added Succssfully");
                        Future.delayed(
                          const Duration(seconds: 2),
                          () => context.goNamed("home"),
                        );
                      },
                    );
                  } catch (e) {
                    debugPrint(e.toString());
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    title.dispose();
    disc.dispose();
    trailer.dispose();
    gener.dispose();
    length.dispose();
    year.dispose();
    super.dispose();
  }

  pickImageForMovie() async {
    try {
      image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        // Process the image
        setState(() {
          debugPrint('Image picked: ${image!.path}');
        });
      } else {
        debugPrint('No image selected.');
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
  }
}
