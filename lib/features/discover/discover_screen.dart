import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok2/constants/gaps.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: tabs.length, vsync: this);
    tabController.addListener(() {
      FocusScope.of(context).unfocus();
    });
  }

  @override
  void dispose() {
    textController.dispose();
    tabController.dispose();
    super.dispose();
  }

  final tabs = [
    "Top",
    "Users",
    "Videos",
    "Sounds",
    "LIVE",
    "Shopping",
    "Brands",
  ];

  late TabController tabController;

  final TextEditingController textController = TextEditingController(
    text: "Search",
  );

  void onSearchChanged(String value) {
    print(value);
  }

  void onSearchSubmitted(String value) {
    print(value);
  }

  @override
  Widget build(BuildContext context) {
    // TabController _tabController = TabController(length: 3, vsync: TickerProvider);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: CupertinoSearchTextField(
          onChanged: onSearchChanged,
          onSubmitted: onSearchSubmitted,
          cursorColor: Theme.of(context).primaryColor,
        ),
        bottom: TabBar(
          controller: tabController,
          padding: EdgeInsets.only(left: 16),
          tabAlignment: TabAlignment.start,
          isScrollable: true,
          labelColor: Colors.black,
          labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          indicatorColor: Colors.black,
          splashFactory: NoSplash.splashFactory,
          unselectedLabelColor: Colors.grey,
          overlayColor: WidgetStatePropertyAll(Colors.transparent),
          tabs: [for (var tab in tabs) Tab(text: tab)],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          GridView.builder(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 5 / 12,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            itemBuilder:
                (context, index) => Column(
                  children: [
                    AspectRatio(
                      aspectRatio: 3 / 5.5,
                      child: FadeInImage.assetNetwork(
                        placeholder: "assets/images/gpt-background.webp",
                        image:
                            "https://images.unsplash.com/photo-1742201408341-29204ea79380?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxmZWF0dXJlZC1waG90b3MtZmVlZHwzfHx8ZW58MHx8fHx8",
                        fit: BoxFit.cover,
                      ),
                    ),
                    Gaps.v8,
                    Text(
                      "lorem ipsum dolor sit amet. consectetur adipiscing elit. sed do eiusmod tempor incididunt.",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Gaps.v4,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 16,
                          backgroundImage: NetworkImage(
                            "https://d1telmomo28umc.cloudfront.net/media/public/avatars/wills-1636619076.jpg",
                          ),
                        ),
                        Gaps.h4,
                        Expanded(
                          child: Text(
                            "John Doe lorem ipsum dolor sit amet. consectetur adipiscing elit. sed do eiusmod tempor incididunt.",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black54,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        FaIcon(
                          FontAwesomeIcons.heart,
                          size: 20,
                          color: Colors.grey,
                        ),
                        Gaps.h4,
                        Text(
                          "2.5M",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
          ),
          for (var tab in tabs.skip(1)) Center(child: Text(tab)),
        ],
      ),
    );
  }
}
