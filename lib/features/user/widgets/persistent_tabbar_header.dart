import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PersistentTabBarHeader extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.grey.shade300, width: .5),
          bottom: BorderSide(color: Colors.grey.shade300, width: .5),
        ),
      ),
      child: TabBar(
        indicatorColor: Colors.black,
        labelColor: Colors.black,
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
