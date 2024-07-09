import 'package:flutter/material.dart';

import 'package:mgm_flutter/scores/score_view_model.dart';
import 'package:mgm_flutter/scores/scores_view_model.dart';
import 'package:url_launcher/url_launcher.dart';

class ScoresPage extends StatefulWidget {
  final ScoresViewModel viewModel;

  ScoresPage(this.viewModel);

  @override
  _ScoresPageState createState() => _ScoresPageState(viewModel);
}

class _ScoresPageState extends State<ScoresPage> {
  final ScoresViewModel viewModel;

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
        List<ScoreViewModel>? viewModels = snapshot.data;
        if (viewModels != null) {
          return ListView.separated(
              separatorBuilder: (context, index) =>
                  Divider(height: 8, color: Colors.grey[400]),
              itemCount: viewModels.length,
              itemBuilder: (context, index) =>
                  _tappableTile(viewModels[index]));
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      },
    );
  }

  Widget _tappableTile(ScoreViewModel viewModel) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () async {
        final url = viewModel.spotifyUrl;
        if (url != null) {
          if (await canLaunch(url)) {
            await launch(url);
          }
        }
      },
      child: _tile(viewModel),
    );
  }

  Widget _tile(ScoreViewModel viewModel) {
    return Row(children: <Widget>[
      SizedBox(width: 10),
      Container(
          height: 64,
          width: 64,
          decoration: BoxDecoration(
            border: Border.all(width: 1),
          ),
          child: FadeInImage(
              image: NetworkImage(viewModel.imageUrl(60)),
              placeholder: viewModel.loadingImage)),
      SizedBox(width: 4),
      Expanded(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(viewModel.albumName,
              style: TextStyle(fontSize: 14),
              maxLines: 1,
              overflow: TextOverflow.ellipsis),
          Text(viewModel.artistName,
              style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
              maxLines: 1,
              overflow: TextOverflow.ellipsis),
        ],
      )),
      SizedBox(width: 4),
      Stack(alignment: AlignmentDirectional.topCenter, children: <Widget>[
        Image(image: viewModel.awardImage, height: 58),
        Column(children: <Widget>[
          Text(
            viewModel.position,
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 14.0),
          ),
          Text(
            viewModel.rating,
            style: TextStyle(
                color: viewModel.ratingFontColor,
                fontWeight: FontWeight.bold,
                fontSize: 19.0),
          )
        ])
      ]),
      SizedBox(width: 10),
    ]);
  }
}
