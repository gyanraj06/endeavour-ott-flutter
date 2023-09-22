// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:endeavour/models/hive_tv_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';

class TVWatchList extends StatefulWidget {
  const TVWatchList({super.key});

  @override
  State<TVWatchList> createState() => _TVWatchListState();
}

class _TVWatchListState extends State<TVWatchList> {
  late Box<HiveTVModel> _tvWatchList;

  @override
  void initState() {
    _tvWatchList = Hive.box<HiveTVModel>("tv_lists");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: _tvWatchList.isEmpty
            ? Center(
                child: Text(
                  "No TV Shows Added Yet!",
                  style:
                      GoogleFonts.montserrat(color: Colors.white, fontSize: 20),
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    ValueListenableBuilder(
                      valueListenable: _tvWatchList.listenable(),
                      builder: (context, Box<HiveTVModel> item, _) {
                        List<int> keys = item.keys.cast<int>().toList();
                        return ListView.builder(
                          itemCount: keys.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final key = keys[index];
                            final HiveTVModel? _item = item.get(key);
                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, top: 10, right: 10),
                              child: Container(
                                height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                child: Center(
                                  child: ListTile(
                                    //start from here...................
                                    title: Text(
                                      _item!.name,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.montserrat(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    subtitle: Text(
                                      _item.overview,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.montserrat(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    leading: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(7)),
                                      child: Image.network(
                                        "https://image.tmdb.org/t/p/w200/${_item.poster}",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    trailing: IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: () {
                                        setState(() {
                                          _tvWatchList.deleteAt(index);
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ));
  }
}
