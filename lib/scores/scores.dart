import 'package:flutter/material.dart';

import 'package:mgm_flutter/data_repository/model.dart';
import 'package:mgm_flutter/scores/score_view_model.dart';
import 'scores_view_model.dart';

class ScoresPage extends StatefulWidget {
  ScoresViewModel viewModel;

  ScoresPage(this.viewModel);

  @override
  _ScoresPageState createState() => _ScoresPageState(viewModel);
}

class _ScoresPageState extends State<ScoresPage> {
  ScoresViewModel viewModel;

  _ScoresPageState(this.viewModel);

  FutureBuilder _albumModels() {
    return FutureBuilder<List<ScoreViewModel>>(
      future: viewModel.albums,
      builder:
          (BuildContext context, AsyncSnapshot<List<ScoreViewModel>> snapshot) {
        if (snapshot.hasData) {
          List<ScoreViewModel> data = snapshot.data;
          return _albumsView(data);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      },
    );
  }

  ListView _albumsView(List<ScoreViewModel> viewModels) {
    return ListView.builder(
        itemCount: viewModels.length,
        itemBuilder: (context, index) {
          return Card(child: _tile(viewModels[index]));
        });
  }

  ListTile _tile(ScoreViewModel viewModel) {
    return ListTile(
      title: Text(viewModel.albumName,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
          )),
      subtitle: Text(viewModel.artistName),
      leading: Image.network(viewModel.imageUrl(300)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(viewModel.title),
        ),
        body: Center(child: _albumModels()));
  }
}
