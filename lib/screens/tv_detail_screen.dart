import 'package:endeavour/constants/style.dart';
import 'package:endeavour/models/hive_tv_model.dart';
import 'package:endeavour/models/tv/tv_model.dart';
import 'package:endeavour/screens/review.dart';
import 'package:endeavour/screens/trailer_screen.dart';
import 'package:endeavour/widgets/tv_widget/similar_tv.dart';
import 'package:endeavour/widgets/tv_widget/tv_info.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';

class TVsDetailsScreen extends StatefulWidget {
  const TVsDetailsScreen({super.key, required this.tvShows, this.request});
  final TVShows tvShows;
  final String? request;
  @override
  State<TVsDetailsScreen> createState() => _TVsDetailsScreenState();
}

class _TVsDetailsScreenState extends State<TVsDetailsScreen> {
  late Box<HiveTVModel> _tvWatchList;

  @override
  void initState() {
    _tvWatchList = Hive.box<HiveTVModel>("tv_lists");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Style.tempColor,
            )),
        title: Text(
          widget.tvShows.name!,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.montserrat(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              clipBehavior: Clip.none,
              children: [
                _buildBackDrop(),
                Positioned(
                  top: 150,
                  left: 30,
                  child: Hero(
                    tag: widget.request == null
                        ? "${widget.tvShows.id}"
                        : "${widget.tvShows.id}${widget.request!}",
                    child: _buildPoster(),
                  ),
                ),
              ],
            ),
            TVInfo(id: widget.tvShows.id!),
            SimilarTVShow(id: widget.tvShows.id!),
            Reviews(
              id: widget.tvShows.id!,
              request: "tv",
            ),
          ],
        ),
      ),
      persistentFooterButtons: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    topLeft: Radius.circular(10)),
                child: Container(
                  color: Colors.red,
                  child: TextButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => TrailersScreen(
                              shows: "tv", id: widget.tvShows.id!),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.play_circle_fill_rounded,
                      size: 30,
                      color: Colors.white,
                    ),
                    label: Text(
                      'Watch Trailers',
                      style: GoogleFonts.montserrat(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 2,
            ),

            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                child: Container(
                  color: Colors.white,
                  child: TextButton.icon(
                    onPressed: () {
                      // if (widget.hiveId == null) {
                      HiveTVModel newValue = HiveTVModel(
                        id: widget.tvShows.id!,
                        rating: widget.tvShows.rating!,
                        name: widget.tvShows.name!,
                        backDrop: widget.tvShows.backDrop!,
                        poster: widget.tvShows.poster!,
                        overview: widget.tvShows.overview!,
                      );
                      _tvWatchList.add(newValue);
                      _showAlertDialog();
                      // }
                      // if (widget.hiveId != null) {
                      //   _movieWatchLists.deleteAt(widget.hiveId!);
                      //   Navigator.of(context).pop(true);
                      // }
                    },
                    icon: const Icon(
                      Icons.list,
                      size: 30,
                      color: Colors.red,
                    ),
                    label: Text(
                      'Watch List',
                      style: GoogleFonts.montserrat(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Expanded(
            //   child: Container(
            //     color: Style.secondaryColor,
            //     child: TextButton.icon(
            //       onPressed: () {
            //         // if (widget.hiveId == null) {
            //         //   HiveMovieModel newValue = HiveMovieModel(
            //         //     id: widget.movie.id!,
            //         //     rating: widget.movie.rating!,
            //         //     title: widget.movie.title!,
            //         //     backDrop: widget.movie.backDrop!,
            //         //     poster: widget.movie.poster!,
            //         //     overview: widget.movie.overview!,
            //         //   );
            //         //   _movieWatchLists.add(newValue);
            //         //   _showAlertDialog();
            //         // }
            //         // if (widget.hiveId != null) {
            //         //   _movieWatchLists.deleteAt(widget.hiveId!);
            //         //   Navigator.of(context).pop(true);
            //         // }
            //       },
            //       icon: Icon(
            //         widget.hiveId == null
            //             ? Icons.list_alt_outlined
            //             : Icons.delete,
            //         size: 30,
            //         color: Colors.white,
            //       ),
            //       label: Text(
            //         widget.hiveId == null ? 'Add To Lists' : 'Delete This',
            //         style: const TextStyle(
            //           fontSize: 15,
            //           color: Colors.white,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ],
    );
  }

  Widget _buildPoster() {
    return Container(
      width: 120,
      height: 180,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 255, 251, 251)
                .withOpacity(0.5), // Shadow color
            spreadRadius: 2, // Spread radius
            blurRadius: 1, // Offset to control the position of the shadow
          ),
        ],
        borderRadius: const  BorderRadius.all(Radius.circular(10)),
        image: DecorationImage(
          image: NetworkImage(
            "https://image.tmdb.org/t/p/w200/${widget.tvShows.poster!}",
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildBackDrop() {
    return Stack(
      children: [
        Container(
          height: 200,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            image: DecorationImage(
              image: NetworkImage(
                "https://image.tmdb.org/t/p/original/${widget.tvShows.backDrop!}",
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }

  void _showAlertDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Added to List"),
          content:
              Text("${widget.tvShows.name!} successfully added to watch list"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            )
          ],
        );
      },
    );
  }
}
