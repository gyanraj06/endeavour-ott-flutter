import 'package:endeavour/constants/style.dart';
import 'package:endeavour/http/http_request.dart';
import 'package:endeavour/models/tv/tv_model.dart';
import 'package:endeavour/screens/tv_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class TVsWidget extends StatefulWidget {
  const TVsWidget({super.key, required this.text, required this.request});

  final String text;
  final String request;

  @override
  State<TVsWidget> createState() => _TVsWidgetState();
}

class _TVsWidgetState extends State<TVsWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, top: 20),
          child: Text(
            "${widget.text} TV Shows",
            style: GoogleFonts.montserrat(
                color: Style.textColor,
                fontWeight: FontWeight.bold,
                fontSize: 15),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        FutureBuilder<TVModel>(
          future: HttpRequest.getTVShows(widget.request),
          builder: (context, AsyncSnapshot<TVModel> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.error != null &&
                  snapshot.data!.error!.isNotEmpty) {
                return _buildErrorWidget(snapshot.data!.error);
              }

              return _buildMoviesByGenreWidget(snapshot.data!);
            } else if (snapshot.hasError) {
              return _buildErrorWidget(snapshot.error);
            } else {
              return _buildLoadingWidget();
            }
          },
        ),
      ],
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
}

Widget _buildMoviesByGenreWidget(TVModel data) {
  List<TVShows>? tvshows = data.tvShows;
  if (tvshows!.isEmpty) {
    return SizedBox(
      child: Text(
        'No Movies found',
        style: GoogleFonts.montserrat(
          fontSize: 20,
          color: Style.textColor,
        ),
      ),
    );
  } else {
    return Container(
      height: 270,
      padding: const EdgeInsets.only(left: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tvshows.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 10,
              right: 10,
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => TVsDetailsScreen(tvShows: tvshows[index])));
              },
              child: Column(
                children: <Widget>[
                  tvshows[index].poster == null
                      ? Container(
                          width: 120,
                          height: 180,
                          decoration: const BoxDecoration(
                            color: Style.tempColor,
                            borderRadius: BorderRadius.all(Radius.circular(2)),
                            shape: BoxShape.rectangle,
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.videocam_off,
                              color: Colors.white,
                              size: 50,
                            ),
                          ),
                        )
                      : Hero(
                          tag: "${tvshows[index].id}",
                          child: Container(
                            width: 120,
                            height: 180,
                            decoration: BoxDecoration(
                              color: Style.tempColor,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                              shape: BoxShape.rectangle,
                              image: DecorationImage(
                                image: NetworkImage(
                                    "https://image.tmdb.org/t/p/w200/${tvshows[index].poster!}"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                  const SizedBox(
                    height: 10,
                  ),

                  //*Title of movie
                  SizedBox(
                    width: 100,
                    child: Text(
                      tvshows[index].name!,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        height: 1.4,
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),

                  //*Ratings
                  Row(
                    children: [
                      const SizedBox(
                        width: 5,
                      ),
                      RatingBar.builder(
                        itemSize: 8,
                        initialRating: tvshows[index].rating! / 2,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding: const EdgeInsets.symmetric(horizontal: 2),
                        itemBuilder: (context, _) {
                          return const Icon(
                            Icons.star,
                            color: Style.tempColor,
                          );
                        },
                        onRatingUpdate: (rating) {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
