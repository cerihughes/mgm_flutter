import 'package:flutter/material.dart';
import 'package:mgm_flutter/data_repository/data_repository.dart';
import 'package:mgm_flutter/data_repository/remote_data_source.dart';
import 'package:mgm_flutter/scores/scores_view_model.dart';

import 'scores/scores.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music Geek Monthly',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ScoresPage(ScoresViewModel(
          DataRepository(RemoteDataSource('https://mgm-gcp.appspot.com')))),
    );
  }
}
