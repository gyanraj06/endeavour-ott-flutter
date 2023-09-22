import 'package:endeavour/constants/style.dart';
import 'package:endeavour/widgets/movie_widgets/movie_watch_list.dart';
import 'package:endeavour/widgets/tv_widget/tv_watchlist.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WatchLists extends StatefulWidget {
  const WatchLists({Key? key}) : super(key: key);

  @override
  State<WatchLists> createState() => _WatchListsState();
}

class _WatchListsState extends State<WatchLists> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          bottom: TabBar(
            labelColor: Style.tempColor,
            indicatorColor: Colors.black,
            dividerColor: Colors.black,
            tabs: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(20)),
                child: Text('Movies',
                    style: GoogleFonts.montserrat(
                        fontSize: 20, fontWeight: FontWeight.w500)),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(20)),
                child: Text('TV Shows',
                    style: GoogleFonts.montserrat(
                        fontSize: 20, fontWeight: FontWeight.w500)),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            MovieWatchLists(),
            TVWatchList(),
            // TVWatchLists(),
          ],
        ),
      ),
    );
  }
}
