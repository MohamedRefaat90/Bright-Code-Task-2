import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test_test/add_movie/widgets/custom_btn.dart';
import 'package:test_test/add_movie/widgets/custom_text_field.dart';
import 'package:test_test/add_movie/widgets/flushbar.dart';
import 'package:test_test/backend/backend.dart';
import 'package:test_test/bright_code/bright_code_util.dart';

import '../widgets/custom_appbar.dart';

class EditMovieScreen extends StatefulWidget {
  final String? docID;
  const EditMovieScreen({super.key, this.docID});
  @override
  State<EditMovieScreen> createState() => _EditMovieScreenState();
}

class _EditMovieScreenState extends State<EditMovieScreen> {
  TextEditingController title = TextEditingController();
  TextEditingController disc = TextEditingController();
  TextEditingController trailer = TextEditingController();
  TextEditingController gener = TextEditingController();
  TextEditingController length = TextEditingController();
  TextEditingController year = TextEditingController();
  final ImagePicker picker = ImagePicker();
  XFile? image;
  DocumentReference? movieDoc;
  MoviesRecord? movieData;
  @override
  void initState() {
    getCurrnetMovieData();

    super.initState();
  }

  getCurrnetMovieData() async {
    movieDoc =
        FirebaseFirestore.instance.collection('movies').doc(widget.docID);

    movieData = await MoviesRecord.getDocumentOnce(movieDoc!);
    setState(() {});
  }

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
                  placeholderText: movieData?.title ?? "Movie Name",
                  textEditingController: title),
              CustomTextField(
                  placeholderText:
                      movieData?.discription ?? "Movie Discription",
                  textEditingController: disc),
              CustomTextField(
                  placeholderText: movieData?.trailerLInke ?? "Trailer Link",
                  textEditingController: trailer),
              CustomTextField(
                  placeholderText: movieData?.gener ?? "Gener",
                  textEditingController: gener),
              CustomTextField(
                  placeholderText: movieData?.lenth ?? "Length",
                  textEditingController: length),
              CustomTextField(
                  placeholderText: movieData?.year.toString() ?? "Year",
                  inputFormat: FilteringTextInputFormatter.digitsOnly,
                  keyboardType: TextInputType.number,
                  textEditingController: year),
              const SizedBox(height: 20),
              IconButton(
                onPressed: () => pickImageForMovie(),
                padding: const EdgeInsets.all(0),
                icon: const Icon(
                  Icons.image_search,
                  size: 50,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 50),
              CustomBTN(
                widget: const Text("Edit", style: TextStyle(fontSize: 20)),
                padding: 15,
                radius: 10,
                width: double.infinity,
                color: Colors.green,
                press: () {
                  try {
                    FirebaseFirestore.instance
                        .collection('movies')
                        .doc(widget.docID)
                        .update({
                      "title":
                          title.text.isEmpty ? movieData!.title : title.text,
                      "discription": disc.text.isEmpty
                          ? movieData!.discription
                          : disc.text,
                      "gener":
                          gener.text.isEmpty ? movieData!.gener : gener.text,
                      "image": image != null ? image!.path : "",
                      "lenth":
                          length.text.isEmpty ? movieData!.lenth : length.text,
                      "year": year.text.isEmpty
                          ? movieData!.year
                          : int.parse(year.text),
                      "trailerLInke": trailer.text.isEmpty
                          ? movieData!.trailerLInke
                          : trailer.text
                    }).then(
                      (value) {
                        flushBar(context, "Movie Edited Succssfully");
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
