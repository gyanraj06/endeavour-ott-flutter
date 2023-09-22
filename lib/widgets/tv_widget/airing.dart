import 'package:endeavour/constants/style.dart';
import 'package:endeavour/http/http_request.dart';
import 'package:endeavour/models/tv/tv_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AiringToday extends StatefulWidget {
  const AiringToday({Key? key}) : super(key: key);

  @override
  State<AiringToday> createState() => _AiringTodayState();
}

class _AiringTodayState extends State<AiringToday> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<TVModel>(
      future: HttpRequest.getTVShows("airing_today"),
      builder: (context, AsyncSnapshot<TVModel> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.error != null &&
              snapshot.data!.error!.isNotEmpty) {
            return _buildErrorWidget(snapshot.data!.error);
          }
          return _buildAiringTodayWidget(snapshot.data!);
        } else if (snapshot.hasError) {
          return _buildErrorWidget(snapshot.error);
        } else {
          return _buildLoadingWidget();
        }
      },
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
              valueColor: AlwaysStoppedAnimation<Color>(Style.tempColor),
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

  Widget _buildAiringTodayWidget(TVModel data) {
    List<TVShows>? movies = data.tvShows;
    if (movies!.isEmpty) {
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 220,
        child: const Center(
          child: Text(
            'No Movies found',
            style: TextStyle(
              fontSize: 20,
              color: Style.textColor,
            ),
          ),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: SizedBox(
          height: 250,
          child: RotatedBox(
            quarterTurns: -1,
            child: ListWheelScrollView(
              controller: FixedExtentScrollController(
                initialItem: movies.length ~/ 2 - 4,
              ),
              physics: const FixedExtentScrollPhysics(),
              // Set the scroll direction to horizontal
              itemExtent: 170, // Use the screen width as the item extent
              children: movies.take(10).map((movie) {
                return RotatedBox(
                  quarterTurns: 1,
                  child: Stack(
                    children: [
                      Container(
                        width: 200,
                        height: 245,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(25),
                          ),
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(
                                "https://image.tmdb.org/t/p/original${movie.poster!}"),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Style.primaryColor.withOpacity(1),
                              Style.primaryColor.withOpacity(0),
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            stops: const [0.0, 0.9],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 50,
                        right: 1,
                        left: 1,
                        child: Container(
                          // decoration: BoxDecoration(
                          //     border: Border.all(color: Colors.cyanAccent)),
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Column(
                            children: [
                              Text(
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                movie.name!,
                                style: GoogleFonts.montserrat(
                                    color: Style.textColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
              // Calculate the initial scroll offset to center the view horizontally
            ),
          ),
        ),
      );
    }
  }
}


// itemExtent: 100,
//         children: movies
//             .map((value) => Stack(
//                   children: <Widget>[
//                     Container(
//                       width: 300,
//                       height: 220,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.rectangle,
//                         image: DecorationImage(
//                           image: NetworkImage(
//                               "https://image.tmdb.org/t/p/original${movies[0].backDrop!}"),
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                     Container(
//                       decoration: BoxDecoration(
//                           gradient: LinearGradient(
//                         colors: [
//                           Style.primaryColor.withOpacity(1),
//                           Style.primaryColor.withOpacity(0),
//                         ],
//                         begin: Alignment.bottomCenter,
//                         end: Alignment.topCenter,
//                         stops: const [0.0, 0.9],
//                       )),
//                     ),
//                     Positioned(
//                       bottom: 30.0,
//                       child: Container(
//                         padding: const EdgeInsets.only(left: 10, right: 10),
//                         width: 250,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: <Widget>[
//                             Text(
//                               movies[0].title!,
//                               style: const TextStyle(
//                                 height: 1.5,
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 16,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ))
//             .toList(),