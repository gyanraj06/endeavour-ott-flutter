// ignore_for_file: no_leading_underscores_for_local_identifiers, avoid_unnecessary_containers

import 'package:endeavour/constants/style.dart';
import 'package:endeavour/screens/movie_screen.dart';
import 'package:endeavour/screens/tv_screen.dart';
import 'package:endeavour/screens/user_settings.dart';
import 'package:endeavour/screens/watchlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    //page controller
    PageController _controller = PageController();
    void onTapIcon(int index) {
      _controller.animateToPage(index,
          duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Row(
          children: [
            const Image(
              image: AssetImage("assets/logo.png"),
              height: 28,
            ),
            const SizedBox(
              width: 10,
            ),
            _buildTitle(_currentIndex)
          ],
        ),
      ),

      //body page view
      body: Container(
        child: PageView(
          controller: _controller,
          children: const [
            MovieScreen(),
            TVsScreen(),
            WatchLists(),
            UserSettings()
          ],
          onPageChanged: (value) {
            setState(() {
              _currentIndex = value;
            });
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: GNav(
          gap: 15,
          tabBackgroundColor: Colors.grey.shade800,
          padding: const EdgeInsets.all(16),
          onTabChange: onTapIcon,
          tabs: const [
            GButton(
              icon: Icons.movie,
              iconColor: Colors.white,
              iconActiveColor: Style.textColor,
              text: 'Movies',
              textColor: Style.textColor,
            ),
            GButton(
              icon: Icons.tv,
              iconColor: Colors.white,
              iconActiveColor: Style.textColor,
              text: 'TV Shows',
              textColor: Style.textColor,
            ),
            GButton(
              icon: Icons.list,
              iconColor: Colors.white,
              iconActiveColor: Style.textColor,
              text: 'Watch List',
              textColor: Style.textColor,
            ),
            GButton(
              icon: Icons.settings,
              iconColor: Colors.white,
              iconActiveColor: Style.textColor,
              text: 'Settings',
              textColor: Style.textColor,
            ),
          ],
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   backgroundColor: Style.primaryColor,
      //   selectedItemColor: Style.tempColor,
      //   unselectedItemColor: Style.textColor,
      //   currentIndex: _currentIndex,
      //   onTap: onTapIcon,
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(icon: Icon(Icons.movie), label: "Movies"),
      //     BottomNavigationBarItem(icon: Icon(Icons.tv), label: "TV Shows"),
      //     BottomNavigationBarItem(icon: Icon(Icons.list), label: "Watch List")
      //   ],
      // ),
    );
  }

  _buildTitle(int _index) {
    switch (_index) {
      case 0:
        return Text("Movies",
            style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w500, color: Style.textColor));
      case 1:
        return Text("TV Shows",
            style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w500, color: Style.textColor));
      case 2:
        return Text("Watch List",
            style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w500, color: Style.textColor));
      case 3:
        return Text("Settings",
            style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w500, color: Style.textColor));
      // case 3:
      //   return Text("User Settings",
      //       style: GoogleFonts.montserrat(
      //           fontWeight: FontWeight.w500, color: Style.textColor));
      default:
        return null;
    }
  }
}
