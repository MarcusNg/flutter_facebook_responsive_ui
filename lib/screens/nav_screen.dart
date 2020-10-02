import 'package:fbk_clone/data/data.dart';
import 'package:fbk_clone/screens/home_screen.dart';
import 'package:fbk_clone/widgets/custom_app_bar.dart';
import 'package:fbk_clone/widgets/custom_tab_bar.dart';
import 'package:fbk_clone/widgets/responsive.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class NavScreen extends StatefulWidget {
  @override
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  final List<Widget> _screens = [
    HomeScreen(),
    Scaffold(),
    Scaffold(),
    Scaffold(),
    Scaffold(),
    Scaffold(),
  ];

  final List<IconData> _icons = const [
    Icons.home,
    Icons.ondemand_video,
    MdiIcons.accountCircleOutline,
    MdiIcons.accountGroupOutline,
    MdiIcons.bellOutline,
    Icons.menu
  ];

  int currIndex = 0;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: Responsive.isDesktop(context)
            ? PreferredSize(
                preferredSize: Size(screenSize.width, 100.0),
                child: CustomAppBar(
                  currentUser: currentUser,
                  icons: _icons,
                  selectedIndex: currIndex,
                  onTap: (index) {
                    setState(() {
                      currIndex = index;
                    });
                  },
                ),
              )
            : null,
        body: IndexedStack(
          index: currIndex,
          children: _screens,
        ),
        bottomNavigationBar: !Responsive.isDesktop(context)
            ? Container(
                padding: EdgeInsets.only(bottom: 12.0),
                color: Colors.white,
                child: CustomTabBar(
                  icons: _icons,
                  selectedIndex: currIndex,
                  onTap: (index) {
                    setState(() {
                      currIndex = index;
                    });
                  },
                ),
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}
