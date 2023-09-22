import 'package:endeavour/constants/style.dart';
import 'package:endeavour/models/hive_movie_model.dart';
import 'package:endeavour/models/movie/movie_model.dart';
import 'package:endeavour/screens/trailer_screen.dart';
import 'package:endeavour/widgets/movie_widgets/movie_info.dart';
import 'package:endeavour/screens/review.dart';
import 'package:endeavour/widgets/movie_widgets/similar_movie.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

class MovieDetailScreen extends StatefulWidget {
  const MovieDetailScreen({super.key, required this.movie, this.request});
  final Movie movie;
  final String? request;
  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  late Box<HiveMovieModel> _movieWatchLists;

  @override
  void initState() {
    _movieWatchLists = Hive.box<HiveMovieModel>('movie_lists');
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
          widget.movie.title!,
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
                        ? "${widget.movie.id}"
                        : "${widget.movie.id}${widget.request!}",
                    child: _buildPoster(),
                  ),
                ),
              ],
            ),
            MovieInfo(id: widget.movie.id!),
            SimilarMovies(id: widget.movie.id!),
            Reviews(
              id: widget.movie.id!,
              request: "movie",
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
                              shows: "movie", id: widget.movie.id!),
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
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  color: Style.textColor,
                ),
                child: TextButton.icon(
                  onPressed: () {
                    // if (widget.hiveId == null) {
                    HiveMovieModel newValue = HiveMovieModel(
                      id: widget.movie.id!,
                      rating: widget.movie.rating!,
                      title: widget.movie.title!,
                      backDrop: widget.movie.backDrop!,
                      poster: widget.movie.poster!,
                      overview: widget.movie.overview!,
                    );
                    _movieWatchLists.add(newValue);
                    _showAlertDialog();
                    // }
                    // if (widget.hiveId != null) {
                    //   _movieWatchLists.deleteAt(widget.hiveId!);
                    //   Navigator.of(context).pop(true);
                    // }
                  },
                  icon: const Icon(
                    Icons.list_alt_outlined,
                    size: 30,
                    color: Colors.red,
                  ),
                  label: Text(
                    //
                    "Watch List",
                    style: GoogleFonts.montserrat(
                        fontSize: 15,
                        color: Colors.red,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
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
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        image: DecorationImage(
          image: NetworkImage(
            "https://image.tmdb.org/t/p/w200/${widget.movie.poster!}",
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
                "https://image.tmdb.org/t/p/original/${widget.movie.backDrop!}",
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
              Text("${widget.movie.title!} successfully added to watch list"),
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
