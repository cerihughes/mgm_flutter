import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:mgm_flutter/scores/score_view_model.dart';
import 'package:mgm_flutter/scores/scores_view_model.dart';

class ScoresPage extends StatefulWidget {
  ScoresViewModel viewModel;

  ScoresPage(this.viewModel);

  @override
  _ScoresPageState createState() => _ScoresPageState(viewModel);
}

class _ScoresPageState extends State<ScoresPage> {
  ScoresViewModel viewModel;

  _ScoresPageState(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(viewModel.title),
        ),
        body: Center(child: _listViewBuilder()));
  }

  FutureBuilder _listViewBuilder() {
    return FutureBuilder<List<ScoreViewModel>>(
      future: viewModel.albums,
      builder:
          (BuildContext context, AsyncSnapshot<List<ScoreViewModel>> snapshot) {
        if (snapshot.hasData) {
          List<ScoreViewModel> viewModels = snapshot.data;
          return ListView.separated(
              separatorBuilder: (context, index) =>
                  Divider(color: Colors.black),
              itemCount: viewModels.length,
              itemBuilder: (context, index) => _tile(viewModels[index]));
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      },
    );
  }

  ListTile _tile(ScoreViewModel viewModel) {
    return ListTile(
      title: Text(viewModel.albumName,
          style: TextStyle(fontSize: 14),
          maxLines: 1,
          overflow: TextOverflow.ellipsis),
      subtitle: Text(viewModel.artistName,
          style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
          maxLines: 1,
          overflow: TextOverflow.ellipsis),
      leading: Image.network(viewModel.imageUrl(300) ??
          "https://mgm-gcp.appspot.com/fallback.jpg"),
      trailing: Image(image: viewModel.awardImage),
    );
  }
}
