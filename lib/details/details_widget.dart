import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '../bright_code/bright_code_icon_button.dart';
import '../bright_code/bright_code_theme.dart';
import '../bright_code/bright_code_util.dart';
import '../bright_code/bright_code_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'details_model.dart';
export 'details_model.dart';

class DetailsWidget extends StatefulWidget {
  const DetailsWidget({
    super.key,
    required this.filmdeatilsParamiters,
  });

  final DocumentReference? filmdeatilsParamiters;

  @override
  State<DetailsWidget> createState() => _DetailsWidgetState();
}

class _DetailsWidgetState extends State<DetailsWidget> {
  late DetailsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DetailsModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MoviesRecord>(
      stream: MoviesRecord.getDocument(widget.filmdeatilsParamiters!),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: Colors.black,
            body: Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    bright_codeTheme.of(context).primary,
                  ),
                ),
              ),
            ),
          );
        }
        final detailsMoviesRecord = snapshot.data!;
        return GestureDetector(
          onTap: () => _model.unfocusNode.canRequestFocus
              ? FocusScope.of(context).requestFocus(_model.unfocusNode)
              : FocusScope.of(context).unfocus(),
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: Colors.black,
              automaticallyImplyLeading: false,
              leading: bright_codeIconButton(
                borderColor: Colors.transparent,
                borderRadius: 30.0,
                borderWidth: 1.0,
                buttonSize: 60.0,
                icon: Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.white,
                  size: 30.0,
                ),
                onPressed: () async {
                  context.pop();
                },
              ),
              title: Text(
                detailsMoviesRecord.title,
                style: bright_codeTheme.of(context).headlineMedium.override(
                      fontFamily: 'Outfit',
                      color: Colors.white,
                      fontSize: 22.0,
                      letterSpacing: 0.0,
                    ),
              ),
              actions: [],
              centerTitle: true,
              elevation: 2.0,
            ),
            body: SafeArea(
              top: true,
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            detailsMoviesRecord.image,
                            width: 180.0,
                            height: 250.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              detailsMoviesRecord.title,
                              style: bright_codeTheme
                                  .of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    color: bright_codeTheme
                                        .of(context)
                                        .primaryBackground,
                                    fontSize: 18.0,
                                    letterSpacing: 0.0,
                                  ),
                            ),
                            Text(
                              detailsMoviesRecord.gener,
                              style: bright_codeTheme
                                  .of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    color: bright_codeTheme
                                        .of(context)
                                        .primaryBackground,
                                    fontSize: 18.0,
                                    letterSpacing: 0.0,
                                  ),
                            ),
                            Text(
                              detailsMoviesRecord.lenth,
                              style: bright_codeTheme
                                  .of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    color: bright_codeTheme
                                        .of(context)
                                        .primaryBackground,
                                    fontSize: 18.0,
                                    letterSpacing: 0.0,
                                  ),
                            ),
                            Text(
                              detailsMoviesRecord.year.toString(),
                              style: bright_codeTheme
                                  .of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    color: bright_codeTheme
                                        .of(context)
                                        .primaryBackground,
                                    fontSize: 18.0,
                                    letterSpacing: 0.0,
                                  ),
                            ),
                            Text(
                              'whatchNow',
                              style: bright_codeTheme
                                  .of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    color: bright_codeTheme
                                        .of(context)
                                        .primaryBackground,
                                    fontSize: 18.0,
                                    letterSpacing: 0.0,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    if (detailsMoviesRecord.likedByUser
                            .contains(currentUserReference) ==
                        false)
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 20.0, 20.0, 20.0),
                        child: ButtonWidget(
                          onPressed: () async {
                            await currentUserReference!.update({
                              ...mapToFirestore(
                                {
                                  'mylsit': FieldValue.arrayUnion(
                                      [detailsMoviesRecord.reference]),
                                },
                              ),
                            });

                            await detailsMoviesRecord.reference.update({
                              ...mapToFirestore(
                                {
                                  'likedByUser': FieldValue.arrayUnion(
                                      [currentUserReference]),
                                },
                              ),
                            });
                          },
                          text: 'add to list',
                          options: ButtonOptions(
                            width: double.infinity,
                            height: 40.0,
                            padding: EdgeInsetsDirectional.fromSTEB(
                                24.0, 0.0, 24.0, 0.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: Color(0xFF5A0E0E),
                            textStyle: bright_codeTheme
                                .of(context)
                                .titleSmall
                                .override(
                                  fontFamily: 'Readex Pro',
                                  color: Colors.white,
                                  letterSpacing: 0.0,
                                ),
                            elevation: 3.0,
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    if (detailsMoviesRecord.likedByUser
                            .contains(currentUserReference) ==
                        true)
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 20.0, 20.0, 20.0),
                        child: ButtonWidget(
                          onPressed: () async {
                            await currentUserReference!.update({
                              ...mapToFirestore(
                                {
                                  'mylsit': FieldValue.arrayRemove(
                                      [detailsMoviesRecord.reference]),
                                },
                              ),
                            });

                            await detailsMoviesRecord.reference.update({
                              ...mapToFirestore(
                                {
                                  'likedByUser': FieldValue.arrayRemove(
                                      [currentUserReference]),
                                },
                              ),
                            });
                          },
                          text: 'remove from list',
                          options: ButtonOptions(
                            width: double.infinity,
                            height: 40.0,
                            padding: EdgeInsetsDirectional.fromSTEB(
                                24.0, 0.0, 24.0, 0.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: Color(0xFF5A0E0E),
                            textStyle: bright_codeTheme
                                .of(context)
                                .titleSmall
                                .override(
                                  fontFamily: 'Readex Pro',
                                  color: Colors.white,
                                  letterSpacing: 0.0,
                                ),
                            elevation: 3.0,
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    Align(
                      alignment: AlignmentDirectional(-0.85, 0.0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            10.0, 25.0, 10.0, 10.0),
                        child: Text(
                          detailsMoviesRecord.discription,
                          style:
                              bright_codeTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Readex Pro',
                                    color: bright_codeTheme
                                        .of(context)
                                        .primaryBackground,
                                    fontSize: 18.0,
                                    letterSpacing: 0.0,
                                  ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
