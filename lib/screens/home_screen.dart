import 'package:fbk_clone/config/palette.dart';
import 'package:fbk_clone/data/data.dart';
import 'package:fbk_clone/models/models.dart';
import 'package:fbk_clone/widgets/circle_button.dart';
import 'package:fbk_clone/widgets/create_post_container.dart';
import 'package:fbk_clone/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:fbk_clone/data/data.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //To enable unfocus of the textfield by clicking anywhere on the screen
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Responsive(
          mobile: _HomeScreenMobile(),
          desktop: _HomeScreenDesktop(),
        ),
      ),
    );
  }
}

class _HomeScreenMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          title: Text(
            "facebook",
            style: const TextStyle(
                color: Palette.facebookBlue,
                fontSize: 28.0,
                letterSpacing: -1.2,
                fontWeight: FontWeight.bold),
          ),
          centerTitle: false,
          floating: true,
          actions: [
            GreyCircularrBtn(
                icon: Icons.search, iconSize: 30.0, onPressed: () {}),
            GreyCircularrBtn(
                icon: MdiIcons.facebookMessenger,
                iconSize: 30.0,
                onPressed: () {}),
          ],
        ),
        SliverToBoxAdapter(
          child: CreatePostContainer(
            currentUser: currentUser,
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
          sliver: SliverToBoxAdapter(
            child: Rooms(onlineUsers: onlineUsers),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
          sliver: SliverToBoxAdapter(
            child: Stories(
              currentUser: currentUser,
              stories: stories,
            ),
          ),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
          final Post currPost = posts[index];
          return PostContainer(
            post: currPost,
          );
        }, childCount: posts.length))
      ],
    );
  }
}

class _HomeScreenDesktop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
            flex: 2,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: MoreOptionsList(
                    currentUser: currentUser,
                  )),
            )),
        const Spacer(),
        Container(
          width: 600.0,
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 10.0),
                sliver: SliverToBoxAdapter(
                  child: Stories(
                    currentUser: currentUser,
                    stories: stories,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: CreatePostContainer(
                  currentUser: currentUser,
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
                sliver: SliverToBoxAdapter(
                  child: Rooms(onlineUsers: onlineUsers),
                ),
              ),
              SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                final Post currPost = posts[index];
                return PostContainer(
                  post: currPost,
                );
              }, childCount: posts.length))
            ],
          ),
        ),
        const Spacer(),
        Flexible(
            flex: 2,
            child: Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: ContactsList(users: onlineUsers),
              ),
            )),
      ],
    );
  }
}
