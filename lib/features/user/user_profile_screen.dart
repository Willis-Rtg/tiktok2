import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok2/constants/breakpoints.dart';
import 'package:tiktok2/constants/gaps.dart';
import 'package:tiktok2/features/user/settings_screen.dart';
import 'package:tiktok2/features/user/widgets/count_follow.dart';
import 'package:tiktok2/features/user/widgets/persistent_tabbar_header.dart';
import 'package:tiktok2/utils.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({
    super.key,
    required this.toFollow,
    required this.username,
  });

  final String username;
  final bool toFollow;

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  void onGearTap() {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => const SettingsScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder:
              (context, innerBoxIsScrolled) => [
                SliverAppBar(
                  pinned: true,
                  backgroundColor:
                      isDarkMode(context) ? Colors.black : Colors.white,
                  surfaceTintColor:
                      isDarkMode(context) ? Colors.black : Colors.white,
                  expandedHeight: 56,
                  collapsedHeight: 56,
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Text(
                      "Willis",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color:
                            isDarkMode(context) ? Colors.white : Colors.black,
                      ),
                    ),
                    // background: Image.network(
                    //   "https://kr-cdn.spooncast.net/profiles/9/reWGO9Uvmgjj3/fe80dbeb-bf0f-4eb3-9d14-351466881f36.jpg",
                    //   fit: BoxFit.cover,
                    // ),
                  ),
                  leading:
                      widget.toFollow
                          ? IconButton(
                            onPressed: () {},
                            icon: FaIcon(FontAwesomeIcons.arrowLeft),
                          )
                          : null,
                  // title: Text("Willis"),
                  actions: [
                    IconButton(
                      onPressed: onGearTap,
                      icon: FaIcon(FontAwesomeIcons.gear, size: 20),
                    ),
                  ],
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 24,
                      right: 24,
                      bottom: 12,
                    ),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 52,
                          foregroundImage: NetworkImage(
                            "https://kr-cdn.spooncast.net/profiles/9/reWGO9Uvmgjj3/fe80dbeb-bf0f-4eb3-9d14-351466881f36.jpg",
                          ),
                          child: Text("Willis"),
                        ),
                        Gaps.v16,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Willis",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color:
                                    isDarkMode(context)
                                        ? Colors.white
                                        : Colors.black,
                              ),
                            ),
                            Gaps.h4,
                            FaIcon(
                              FontAwesomeIcons.solidCircleCheck,
                              size: 12,
                              color: Colors.blue,
                            ),
                          ],
                        ),
                        Gaps.v16,
                        SizedBox(
                          height: 52,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CountFollow(count: "10k", label: "followings"),
                              VerticalDivider(
                                color: Colors.grey.shade300,
                                thickness: 1,
                                indent: 15,
                                endIndent: 15,
                                width: 40,
                              ),
                              CountFollow(count: "80", label: "followers"),
                              VerticalDivider(
                                color: Colors.grey.shade300,
                                thickness: 1,
                                indent: 15,
                                endIndent: 15,
                                width: 40,
                              ),
                              CountFollow(count: "100", label: "likes"),
                            ],
                          ),
                        ),
                        Gaps.v16,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.33,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Center(
                                child: Text(
                                  "Follow",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Gaps.h4,
                            Container(
                              width: 40,
                              height: 40,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: IconButton(
                                onPressed: () {},
                                icon: FaIcon(
                                  FontAwesomeIcons.youtube,
                                  size: 20,
                                ),
                              ),
                            ),
                            Gaps.h4,
                            Container(
                              width: 40,
                              height: 40,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: IconButton(
                                onPressed: () {},
                                icon: FaIcon(
                                  FontAwesomeIcons.chevronDown,
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Gaps.v16,
                        Text(
                          "Maudine de batèche de charogne de mosus de boswell de cossin de sapristi.",
                          style: TextStyle(fontSize: 12),
                          textAlign: TextAlign.center,
                        ),
                        Gaps.v8,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FaIcon(FontAwesomeIcons.link, size: 12),
                            Gaps.h4,
                            Text(
                              "https://www.더쉼.com/",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  // constraints: BoxConstraints(maxWidth: Breakpoints.sm),
                  child: SliverPersistentHeader(
                    delegate: PersistentTabBarHeader(),
                    pinned: true,
                  ),
                ),
              ],
          body: Column(
            children: [
              Expanded(
                child: TabBarView(
                  children: [
                    GridView.builder(
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 7 / 9,
                        mainAxisSpacing: 4,
                        crossAxisSpacing: 4,
                      ),
                      itemBuilder:
                          (context, index) => Column(
                            children: [
                              AspectRatio(
                                aspectRatio: 7 / 9,
                                child: FadeInImage.assetNetwork(
                                  placeholder:
                                      "assets/images/gpt-background.webp",
                                  image:
                                      "https://images.unsplash.com/photo-1742201408341-29204ea79380?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxmZWF0dXJlZC1waG90b3MtZmVlZHwzfHx8ZW58MHx8fHx8",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),
                    ),
                    GridView.builder(
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 7 / 9,
                        mainAxisSpacing: 4,
                        crossAxisSpacing: 4,
                      ),
                      itemBuilder:
                          (context, index) => Column(
                            children: [
                              AspectRatio(
                                aspectRatio: 7 / 9,
                                child: FadeInImage.assetNetwork(
                                  placeholder:
                                      "assets/images/gpt-background.webp",
                                  image:
                                      "https://images.unsplash.com/photo-1742201408341-29204ea79380?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxmZWF0dXJlZC1waG90b3MtZmVlZHwzfHx8ZW58MHx8fHx8",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
