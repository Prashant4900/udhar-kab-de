import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/constants/commons.dart';
import 'package:mobile/constants/tags.dart';
import 'package:mobile/theme/theme_manager.dart';
import 'package:mobile/utils/extensions.dart';
import 'package:mobile/views/account/account_screen.dart';
import 'package:mobile/views/activity/activity_screen.dart';
import 'package:mobile/views/friends/friends_screens.dart';
import 'package:mobile/views/home/home_screen.dart';

final navItems = [
  {
    'icon': Icons.home,
    'label': 'Home',
  },
  {
    'icon': Icons.person_outlined,
    'label': 'Friends',
  },
  {
    'icon': CupertinoIcons.graph_square,
    'label': 'Activity',
  },
  {
    'icon': Icons.account_box,
    'label': 'Account',
  },
];

class MyDashboard extends StatefulWidget {
  const MyDashboard({super.key});

  @override
  State<MyDashboard> createState() => _MyDashboardState();
}

class _MyDashboardState extends State<MyDashboard> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Hero(
          tag: HeroTags.fullTextLogo,
          child: Text(
            selectedIndex == 0
                ? 'Udhar Kab dega'
                : navItems[selectedIndex]['label']! as String,
            style: context.titleStyle.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ),
      ),
      body: IndexedStack(
        index: selectedIndex,
        children: const [
          MyHomeScreen(),
          MyFriendScreen(),
          MyActivityScreen(),
          MyAccountScreen(),
        ],
      ),
      bottomNavigationBar: Container(
        height: 56,
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.grey,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            for (int index = 0; index < navItems.length; index++) ...[
              emptyWidget,
              InkWell(
                splashColor: Colors.transparent,
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                child: BottomNavItem(
                  index: index,
                  selected: selectedIndex == index,
                ),
              ),
            ],
            emptyWidget,
          ],
        ),
      ),
    );
  }
}

class BottomNavItem extends StatelessWidget {
  const BottomNavItem({
    required this.index,
    required this.selected,
    super.key,
  });

  final int index;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter: ColorFilter.mode(
        selected ? context.colorScheme.primary : context.colorScheme.secondary,
        BlendMode.srcIn,
      ),
      child: Column(
        children: [
          SizedBox.square(
            dimension: 32,
            child: Icon(navItems[index]['icon']! as IconData),
          ),
          Text(
            navItems[index]['label']! as String,
            style: context.captionStyle.copyWith(
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}
