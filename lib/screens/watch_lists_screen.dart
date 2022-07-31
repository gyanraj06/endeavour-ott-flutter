import 'package:endeavour/constant/style.dart';
import 'package:endeavour/movie_widget/movie_watch_lists.dart';
import 'package:endeavour/tv_widget/tv_watch_lists.dart';
import 'package:flutter/material.dart';

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
            title: const Text('Watch Lists'),
            bottom: const TabBar(
              indicatorWeight: 5,
              indicatorColor: Style.secondColor,
              tabs: [
                Text('Movies',
                    style: TextStyle(
                      fontSize: 20,
                    )),
                Text('TVs',
                    style: TextStyle(
                      fontSize: 20,
                    )),
              ],
            ),
          ),
          body: const TabBarView(
            children: <Widget>[
              MovieWatchLists(),
              TVWatchLists(),
            ],
          )),
    );
  }
}
