import 'package:endeavour/constants/style.dart';
import 'package:endeavour/http/http_request.dart';
import 'package:endeavour/models/trailer_model.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TrailersScreen extends StatefulWidget {
  const TrailersScreen({Key? key, required this.shows, required this.id})
      : super(key: key);
  final String shows;
  final int id;

  @override
  State<TrailersScreen> createState() => _TrailersScreenState();
}

class _TrailersScreenState extends State<TrailersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<TrailersModel>(
        future: HttpRequest.getTrailers(widget.shows, widget.id),
        builder: (context, AsyncSnapshot<TrailersModel> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.error != null &&
                snapshot.data!.error!.isNotEmpty) {
              return _buildErrorWidget(snapshot.data!.error);
            }
            return _buildTrailersWidget(snapshot.data!);
          } else if (snapshot.hasError) {
            return _buildErrorWidget(snapshot.error);
          } else {
            return _buildLoadingWidget();
          }
        },
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 25.0,
            height: 25.0,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              strokeWidth: 4.0,
            ),
          )
        ],
      ),
    );
  }

  //display error
  Widget _buildErrorWidget(dynamic error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Something is wrong : $error',
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTrailersWidget(TrailersModel data) {
    List<Video>? videos = data.trailers;
    return Stack(
      children: <Widget>[
        Center(
          child: YoutubePlayer(
            progressIndicatorColor: Style.tempColor,
            controller: YoutubePlayerController(
              initialVideoId: videos![0].key!,
              flags: const YoutubePlayerFlags(
                hideControls: false,
                autoPlay: true,
              ),
            ),
          ),
        ),
        //close button
        Positioned(
          top: 250,
          right: 20,
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.close_rounded,
                color: Colors.black,
              ),
            ),
          ),
          // child: IconButton(
          //   icon: const Icon(Icons.close_sharp),
          //   color: Colors.white,
          //   onPressed: () => Navigator.of(context).pop(),
          // ),
        ),
      ],
    );
  }
}
