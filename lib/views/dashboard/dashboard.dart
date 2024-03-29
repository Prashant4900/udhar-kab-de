import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/constants/commons.dart';
import 'package:mobile/constants/tags.dart';
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
            style: context.textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.bold,
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
      bottomNavigationBar: SizedBox(
        height: kToolbarHeight + 20,
        child: Padding(
          padding: bottomPadding8,
          child: Column(
            children: [
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  for (int index = 0; index < navItems.length; index++) ...[
                    emptyWidget,
                    InkWell(
                      borderRadius: BorderRadius.circular(8),
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
            ],
          ),
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
          Icon(navItems[index]['icon']! as IconData),
          Text(navItems[index]['label']! as String),
        ],
      ),
    );
  }
}
