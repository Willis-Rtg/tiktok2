import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok2/constants/breakpoints.dart';
import 'package:tiktok2/utils.dart';

class PersistentTabBarHeader extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: isDarkMode(context) ? Colors.black : Colors.white,
        border: Border(
          top: BorderSide(color: Colors.grey.shade300, width: .5),
          bottom: BorderSide(color: Colors.grey.shade300, width: .5),
        ),
      ),
      width: Breakpoints.sm,
      constraints: BoxConstraints(maxWidth: Breakpoints.sm),
      child: TabBar(
        indicatorColor: isDarkMode(context) ? Colors.white : Colors.black,
        labelColor: isDarkMode(context) ? Colors.white : Colors.black,
        unselectedLabelColor: Colors.grey,
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        labelStyle: TextStyle(fontWeight: FontWeight.bold),
        labelPadding: EdgeInsets.symmetric(vertical: 8),
        dividerColor: Colors.transparent,
        tabs: [Icon(Icons.grid_view), FaIcon(FontAwesomeIcons.heart)],
      ),
    );
  }

  @override
  double get maxExtent => 44;

  @override
  double get minExtent => 44;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
