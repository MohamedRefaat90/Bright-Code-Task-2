import 'package:flutter/material.dart';

import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '../bright_code/bright_code_theme.dart';
import '../bright_code/bright_code_util.dart';
import 'home_model.dart';

export 'home_model.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  late HomeModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.black,
        floatingActionButton: FloatingActionButton(
          onPressed: () => context.pushNamed("addMovie"),
          backgroundColor: Colors.amber,
          shape: const BeveledRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: const Icon(
            Icons.add,
            size: 35,
          ),
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              primary: false,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: const AlignmentDirectional(0.0, 0.0),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              15.0, 0.0, 0.0, 0.0),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              GoRouter.of(context).prepareAuthEvent();
                              await authManager.signOut();
                              GoRouter.of(context).clearRedirectLocation();

                              context.goNamedAuth('Auth1', context.mounted);
                            },
                            child: Text(
                              'testBrightCode&logOut',
                              style: bright_codeTheme
                                  .of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Outfit',
                                    color: const Color(0xFFFF0000),
                                    fontSize: 22.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w800,
                                  ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 40.0,
                        height: 40.0,
                        clipBehavior: Clip.antiAlias,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(
                          'https://h.top4top.io/p_310420kmv1.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                  if ((currentUserDocument?.mylsit.toList() ?? []).isNotEmpty)
                    AuthUserStreamWidget(
                      builder: (context) => Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Align(
                            alignment: const AlignmentDirectional(-1.0, 0.0),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  5.0, 0.0, 0.0, 10.0),
                              child: Text(
                                'My List',
                                style: bright_codeTheme
                                    .of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      color: bright_codeTheme
                                          .of(context)
                                          .primaryBackground,
                                      fontSize: 22.0,
                                      letterSpacing: 0.0,
                                    ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: const AlignmentDirectional(-1.0, 0.0),
                            child: Container(
                              width: MediaQuery.sizeOf(context).width * 1.0,
                              height: 150.0,
                              decoration: const BoxDecoration(),
                              child: Align(
                                alignment: const AlignmentDirectional(0.0, 0.0),
                                child: Builder(
                                  builder: (context) {
                                    final likedMovie =
                                        (currentUserDocument?.mylsit.toList() ??
                                                [])
                                            .toList();
                                    return ListView.separated(
                                      padding: const EdgeInsets.fromLTRB(
                                        0,
                                        0,
                                        10.0,
                                        0,
                                      ),
                                      scrollDirection: Axis.horizontal,
                                      itemCount: likedMovie.length,
                                      separatorBuilder: (_, __) =>
                                          const SizedBox(width: 15.0),
                                      itemBuilder: (context, likedMovieIndex) {
                                        final likedMovieItem =
                                            likedMovie[likedMovieIndex];
                                        return StreamBuilder<MoviesRecord>(
                                          stream: MoviesRecord.getDocument(
                                              likedMovieItem),
                                          builder: (context, snapshot) {
                                            // Customize what your widget looks like when it's loading.
                                            if (!snapshot.hasData) {
                                              return Center(
                                                child: SizedBox(
                                                  width: 50.0,
                                                  height: 50.0,
                                                  child:
                                                      CircularProgressIndicator(
                                                    valueColor:
                                                        AlwaysStoppedAnimation<
                                                            Color>(
                                                      bright_codeTheme
                                                          .of(context)
                                                          .primary,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }
                                            final imageMoviesRecord =
                                                snapshot.data!;
                                            return InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                context.pushNamed(
                                                  'details',
                                                  queryParameters: {
                                                    'filmdeatilsParamiters':
                                                        serializeParam(
                                                      imageMoviesRecord
                                                          .reference,
                                                      ParamType
                                                          .DocumentReference,
                                                    ),
                                                  }.withoutNulls,
                                                );
                                              },
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                child: Image.network(
                                                  imageMoviesRecord.image,
                                                  width: 140.0,
                                                  height: 140.0,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Align(
                        alignment: const AlignmentDirectional(-1.0, 0.0),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              5.0, 0.0, 0.0, 10.0),
                          child: Text(
                            'all',
                            style: bright_codeTheme
                                .of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Readex Pro',
                                  color: bright_codeTheme
                                      .of(context)
                                      .primaryBackground,
                                  fontSize: 22.0,
                                  letterSpacing: 0.0,
                                ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: const AlignmentDirectional(-1.0, 0.0),
                        child: Container(
                          width: MediaQuery.sizeOf(context).width * 1.0,
                          height: 150.0,
                          decoration: const BoxDecoration(),
                          child: Align(
                            alignment: const AlignmentDirectional(0.0, 0.0),
                            child: StreamBuilder<List<MoviesRecord>>(
                              stream: queryMoviesRecord(),
                              builder: (context, snapshot) {
                                // Customize what your widget looks like when it's loading.
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: SizedBox(
                                      width: 50.0,
                                      height: 50.0,
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          bright_codeTheme.of(context).primary,
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                List<MoviesRecord> listViewMoviesRecordList =
                                    snapshot.data!;
                                return ListView.separated(
                                  padding: const EdgeInsets.fromLTRB(
                                    0,
                                    0,
                                    10.0,
                                    0,
                                  ),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: listViewMoviesRecordList.length,
                                  separatorBuilder: (_, __) =>
                                      const SizedBox(width: 15.0),
                                  itemBuilder: (context, listViewIndex) {
                                    final listViewMoviesRecord =
                                        listViewMoviesRecordList[listViewIndex];
                                    return InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        context.pushNamed(
                                          'details',
                                          queryParameters: {
                                            'filmdeatilsParamiters':
                                                serializeParam(
                                              listViewMoviesRecord.reference,
                                              ParamType.DocumentReference,
                                            ),
                                          }.withoutNulls,
                                        );
                                      },
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: Image.network(
                                          listViewMoviesRecord.image,
                                          width: 140.0,
                                          height: 140.0,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Align(
                        alignment: const AlignmentDirectional(-1.0, 0.0),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              5.0, 0.0, 0.0, 10.0),
                          child: Text(
                            'action',
                            style: bright_codeTheme
                                .of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Readex Pro',
                                  color: bright_codeTheme
                                      .of(context)
                                      .primaryBackground,
                                  fontSize: 22.0,
                                  letterSpacing: 0.0,
                                ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: const AlignmentDirectional(-1.0, 0.0),
                        child: Container(
                          width: MediaQuery.sizeOf(context).width * 1.0,
                          height: 150.0,
                          decoration: const BoxDecoration(),
                          child: Align(
                            alignment: const AlignmentDirectional(0.0, 0.0),
                            child: StreamBuilder<List<MoviesRecord>>(
                              stream: queryMoviesRecord(
                                queryBuilder: (moviesRecord) =>
                                    moviesRecord.where(
                                  'gener',
                                  isEqualTo: 'action',
                                ),
                              ),
                              builder: (context, snapshot) {
                                // Customize what your widget looks like when it's loading.
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: SizedBox(
                                      width: 50.0,
                                      height: 50.0,
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          bright_codeTheme.of(context).primary,
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                List<MoviesRecord> listViewMoviesRecordList =
                                    snapshot.data!;

                                if (listViewMoviesRecordList.isEmpty) {
                                  return const Center(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.warning_amber,
                                          color: Colors.amber,
                                          size: 50,
                                        ),
                                        SizedBox(height: 20),
                                        Text(
                                          "There is No Movies for This Category Yet",
                                          style: TextStyle(color: Colors.amber),
                                        )
                                      ],
                                    ),
                                  );
                                } else {
                                  return ListView.separated(
                                    padding: const EdgeInsets.fromLTRB(
                                      0,
                                      0,
                                      10.0,
                                      0,
                                    ),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: listViewMoviesRecordList.length,
                                    separatorBuilder: (_, __) =>
                                        const SizedBox(width: 15.0),
                                    itemBuilder: (context, listViewIndex) {
                                      final listViewMoviesRecord =
                                          listViewMoviesRecordList[
                                              listViewIndex];
                                      return InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          context.pushNamed(
                                            'details',
                                            queryParameters: {
                                              'filmdeatilsParamiters':
                                                  serializeParam(
                                                listViewMoviesRecord.reference,
                                                ParamType.DocumentReference,
                                              ),
                                            }.withoutNulls,
                                          );
                                        },
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: Image.network(
                                            listViewMoviesRecord.image,
                                            width: 140.0,
                                            height: 140.0,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Align(
                        alignment: const AlignmentDirectional(-1.0, 0.0),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              5.0, 0.0, 0.0, 10.0),
                          child: Text(
                            'drama',
                            style: bright_codeTheme
                                .of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Readex Pro',
                                  color: bright_codeTheme
                                      .of(context)
                                      .primaryBackground,
                                  fontSize: 22.0,
                                  letterSpacing: 0.0,
                                ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: const AlignmentDirectional(-1.0, 0.0),
                        child: Container(
                          width: MediaQuery.sizeOf(context).width * 1.0,
                          height: 150.0,
                          decoration: const BoxDecoration(),
                          child: Align(
                            alignment: const AlignmentDirectional(0.0, 0.0),
                            child: StreamBuilder<List<MoviesRecord>>(
                              stream: queryMoviesRecord(
                                queryBuilder: (moviesRecord) =>
                                    moviesRecord.where(
                                  'gener',
                                  isEqualTo: 'drama',
                                ),
                              ),
                              builder: (context, snapshot) {
                                // Customize what your widget looks like when it's loading.
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: SizedBox(
                                      width: 50.0,
                                      height: 50.0,
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          bright_codeTheme.of(context).primary,
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                List<MoviesRecord> listViewMoviesRecordList =
                                    snapshot.data!;
                                if (listViewMoviesRecordList.isEmpty) {
                                  return const Center(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.warning_amber,
                                          color: Colors.amber,
                                          size: 50,
                                        ),
                                        SizedBox(height: 20),
                                        Text(
                                          "There is No Movies for This Category Yet",
                                          style: TextStyle(color: Colors.amber),
                                        )
                                      ],
                                    ),
                                  );
                                } else {
                                  return ListView.separated(
                                    padding: const EdgeInsets.fromLTRB(
                                      0,
                                      0,
                                      10.0,
                                      0,
                                    ),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: listViewMoviesRecordList.length,
                                    separatorBuilder: (_, __) =>
                                        const SizedBox(width: 15.0),
                                    itemBuilder: (context, listViewIndex) {
                                      final listViewMoviesRecord =
                                          listViewMoviesRecordList[
                                              listViewIndex];
                                      return InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          context.pushNamed(
                                            'details',
                                            queryParameters: {
                                              'filmdeatilsParamiters':
                                                  serializeParam(
                                                listViewMoviesRecord.reference,
                                                ParamType.DocumentReference,
                                              ),
                                            }.withoutNulls,
                                          );
                                        },
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: Image.network(
                                            listViewMoviesRecord.image,
                                            width: 140.0,
                                            height: 140.0,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Align(
                        alignment: const AlignmentDirectional(-1.0, 0.0),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              5.0, 0.0, 0.0, 10.0),
                          child: Text(
                            'comedy',
                            style: bright_codeTheme
                                .of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Readex Pro',
                                  color: bright_codeTheme
                                      .of(context)
                                      .primaryBackground,
                                  fontSize: 22.0,
                                  letterSpacing: 0.0,
                                ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: const AlignmentDirectional(-1.0, 0.0),
                        child: Container(
                          width: MediaQuery.sizeOf(context).width * 1.0,
                          height: 150.0,
                          decoration: const BoxDecoration(),
                          child: Align(
                            alignment: const AlignmentDirectional(0.0, 0.0),
                            child: StreamBuilder<List<MoviesRecord>>(
                              stream: queryMoviesRecord(
                                queryBuilder: (moviesRecord) =>
                                    moviesRecord.where(
                                  'gener',
                                  isEqualTo: 'comedy',
                                ),
                              ),
                              builder: (context, snapshot) {
                                // Customize what your widget looks like when it's loading.
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: SizedBox(
                                      width: 50.0,
                                      height: 50.0,
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          bright_codeTheme.of(context).primary,
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                List<MoviesRecord> listViewMoviesRecordList =
                                    snapshot.data!;
                                if (listViewMoviesRecordList.isEmpty) {
                                  return const Center(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.warning_amber,
                                          color: Colors.amber,
                                          size: 50,
                                        ),
                                        SizedBox(height: 20),
                                        Text(
                                          "There is No Movies for This Category Yet",
                                          style: TextStyle(color: Colors.amber),
                                        )
                                      ],
                                    ),
                                  );
                                } else {
                                  return ListView.separated(
                                    padding: const EdgeInsets.fromLTRB(
                                      0,
                                      0,
                                      10.0,
                                      0,
                                    ),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: listViewMoviesRecordList.length,
                                    separatorBuilder: (_, __) =>
                                        const SizedBox(width: 15.0),
                                    itemBuilder: (context, listViewIndex) {
                                      final listViewMoviesRecord =
                                          listViewMoviesRecordList[
                                              listViewIndex];
                                      return InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          context.pushNamed(
                                            'details',
                                            queryParameters: {
                                              'filmdeatilsParamiters':
                                                  serializeParam(
                                                listViewMoviesRecord.reference,
                                                ParamType.DocumentReference,
                                              ),
                                            }.withoutNulls,
                                          );
                                        },
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: Image.network(
                                            listViewMoviesRecord.image,
                                            width: 140.0,
                                            height: 140.0,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ]
                    .divide(const SizedBox(height: 1.0))
                    .around(const SizedBox(height: 1.0)),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomeModel());
  }
}
