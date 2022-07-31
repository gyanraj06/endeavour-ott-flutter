import 'package:endeavour/constant/style.dart';
import 'package:endeavour/http/http_request.dart';
import 'package:endeavour/model/genres_model.dart';
import 'package:endeavour/tv_widget/genres_list.dart';
import 'package:flutter/material.dart';

//Get Genre From API
class GetGenres extends StatefulWidget {
  const GetGenres({Key? key}) : super(key: key);

  @override
  State<GetGenres> createState() => _GetGenresState();
}

class _GetGenresState extends State<GetGenres> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<GenreModel>(
      //get genre list of tvs from api
      future: HttpRequest.getGenres("tv"), //api keyword from api doc
      builder: (context, AsyncSnapshot<GenreModel> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.error != null &&
              snapshot.data!.error!.isNotEmpty) {
            return _buildErrorWidget(snapshot.data!.error);
          }
          //else
          return _buildGetGenresWidget(snapshot.data!);
        } else if (snapshot.hasError) {
          return _buildErrorWidget(snapshot.error);
        } else {
          //loding indicator
          return _buildLoadingWidget();
        }
      },
    );
  }

  //methods here!!!!!!!!!!!!!!!!!!!!
  Widget _buildLoadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
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
            'Oops! Wrongie! : $error',
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildGetGenresWidget(GenreModel data) {
    List<Genre>? genres = data.genres;
    if (genres!.isEmpty) {
      return const SizedBox(
        child: Text(
          'No Genres',
          style: TextStyle(
            fontSize: 20,
            color: Style.textColor,
          ),
        ),
      );
    } else {
      return GenreLists(genres: genres);
    }
  }
}
