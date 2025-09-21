import 'package:evently/core/resources/routes_manager.dart';
import 'package:evently/features/layout/fav/fav_tab.dart';
import 'package:evently/features/layout/home/home_tab.dart';
import 'package:evently/features/layout/map/map_tab.dart';
import 'package:evently/features/layout/profile/profile_tab.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int selectedIndex = 0;

  final List<Widget> tabs = [HomeTab(), MapTab(), FavTab(), ProfileTab()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: tabs[selectedIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, RoutesManager.createEvent);
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 8,
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
          onTap: (newIndex) {
            setState(() {
              selectedIndex = newIndex;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                selectedIndex == 0 ? Icons.home_filled : Icons.home_outlined,
              ),
              label: AppLocalizations.of(context)!.home,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                selectedIndex == 1
                    ? Icons.location_on_sharp
                    : Icons.location_on_outlined,
              ),
              label: AppLocalizations.of(context)!.map,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                selectedIndex == 2 ? Icons.favorite : Icons.favorite_outline,
              ),
              label: AppLocalizations.of(context)!.favorite,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                selectedIndex == 3 ? Icons.person : Icons.person_outline,
              ),
              label: AppLocalizations.of(context)!.profile,
            ),
          ],
        ),
      ),
    );
  }
}
