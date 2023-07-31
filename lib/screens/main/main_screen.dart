import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wbsessential/controller/MenuAppController.dart';
import 'package:wbsessential/controller/responsive.dart';
import 'package:wbsessential/features/wbs_projects/ui/ui_wbs_project.dart';
import 'package:wbsessential/screens/components/bottom_bar.dart';
import 'package:wbsessential/screens/components/carousel.dart';
import 'package:wbsessential/screens/components/destination_heading.dart';
import 'package:wbsessential/screens/components/explore_drawer.dart';
import 'package:wbsessential/screens/components/featured_heading.dart';
import 'package:wbsessential/screens/components/featured_tiles.dart';
import 'package:wbsessential/screens/components/floating_quick_access_bar.dart';
import 'package:wbsessential/screens/components/responsive.dart';
import 'package:wbsessential/screens/components/top_bar_contents.dart';
import 'package:wbsessential/screens/components/web_scrollbar.dart';
import 'package:wbsessential/screens/ui_home.dart';

import '../../screens/main/components/side_menu.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  late ScrollController _scrollController;
  double _scrollPosition = 0;
  double _opacity = 0;

  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    _opacity = _scrollPosition < screenSize.height * 0.40
        ? _scrollPosition / (screenSize.height * 0.40)
        : 1;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      extendBodyBehindAppBar: true,
      appBar: ResponsiveWidget.isSmallScreen(context)
          ? AppBar(
        backgroundColor:
        Theme.of(context).bottomAppBarColor.withOpacity(_opacity),
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.brightness_6),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () {
              //
            },
          ),
        ],
        title: Text(
          'EXPLORE',
          style: TextStyle(
            color: Colors.blueGrey[100],
            fontSize: 20,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w400,
            letterSpacing: 3,
          ),
        ),
      )
          : PreferredSize(
        preferredSize: Size(screenSize.width, 1000),
        child: TopBarContents(_opacity),
      ),
      drawer: ExploreDrawer(),
      body: WebScrollbar(
        color: Colors.blueGrey,
        backgroundColor: Colors.blueGrey.withOpacity(0.3),
        width: 10,
        heightFraction: 0.3,
        controller: _scrollController,
        child: SingleChildScrollView(
          controller: _scrollController,
          physics: ClampingScrollPhysics(),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    child: SizedBox(
                      height: screenSize.height * 0.45,
                      width: screenSize.width,
                      child: Image.asset(
                        'assets/images/cover.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      FloatingQuickAccessBar(screenSize: screenSize),
                      Container(
                        child: Column(
                          children: [
                            FeaturedHeading(
                              screenSize: screenSize,
                            ),
                            // FeaturedTiles(screenSize: screenSize),
                            ListProjectWbs(screenSize: screenSize)
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
              DestinationHeading(screenSize: screenSize),
              DestinationCarousel(),
              SizedBox(height: screenSize.height / 10),
              BottomBar(),
            ],
          ),
        ),
      ),
    );
  }
}