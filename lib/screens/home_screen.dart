import 'package:endeavour/constant/style.dart';
import 'package:endeavour/screens/movie_screen.dart';
import 'package:endeavour/screens/tv_screen.dart';
import 'package:endeavour/screens/watch_lists_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    // page control
    PageController _controller = PageController();
    void onTapIcon(int index) {
      _controller.animateToPage(index,
          duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
    }

    return Scaffold(
      appBar: _currentIndex != 2
          ? AppBar(
              title: _buildTitle(_currentIndex),
            )
          : null,

      //page body here
      body: PageView(
        controller: _controller,
        children: const <Widget>[
          MovieScreen(),
          TVsScreen(),
          WatchLists(),
        ],
        onPageChanged: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Style.primaryColor,
        selectedItemColor: Style.secondColor,
        unselectedItemColor: Style.textColor,
        onTap: onTapIcon,
        currentIndex: _currentIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.movie), label: "Movies"),
          BottomNavigationBarItem(icon: Icon(Icons.tv), label: "TVs"),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "Watch List"),
        ],
      ),
    );
  }

  //app bar title
  _buildTitle(int _index) {
    switch (_index) {
      case 0:
        return const Text('Movie Shows');
      case 1:
        return const Text('TV Shows');
      default:
        null;
    }
  }
}
