import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentprovider/screens/add_screen.dart';
import 'package:studentprovider/screens/gridview_screen.dart';
import 'package:studentprovider/screens/home_screen.dart';
import 'package:studentprovider/screens/search_screen.dart';
import 'package:studentprovider/styles/styles.dart';

class TabBarScreen extends StatelessWidget {
  const TabBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Builder(
        builder: (context) {
          final TabController tabController = DefaultTabController.of(context)!;
          tabController.addListener(() {
            Provider.of<TabIndexProvider>(context, listen: false)
                .updateIndex(tabController.index);
          });

          return Scaffold(
            appBar: AppBar(
              foregroundColor: Colors.black,
              backgroundColor: themecode,
              bottom: const TabBar(
                tabs: [
                  Tab(
                    icon: Icon(
                      Icons.home,
                      color: iconsColor,
                    ),
                  ),
                  Tab(
                    icon: Icon(Icons.search, color: iconsColor),
                  ),
                  Tab(
                    icon: Icon(Icons.grid_view, color: iconsColor),
                  ),
                ],
              ),
              title: const Text(
                "Student Details",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            body: const TabBarView(
              children: [
                HomeScreen(),
                SeacrchScreen(),
                GridViewScreen(),
              ],
            ),
            floatingActionButton: Consumer<TabIndexProvider>(
              builder: (context, tabIndexProvider, child) {
                return tabIndexProvider.currentIndex == 0
                    ? FloatingActionButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddScreen()));
                        },
                        backgroundColor: themecode,
                        child: const Icon(
                          Icons.add,
                          color: iconsColor,
                        ),
                      )
                    : Container(); // Return an empty container when FAB is not needed
              },
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          );
        },
      ),
    );
  }
}

class TabIndexProvider extends ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void updateIndex(int newIndex) {
    _currentIndex = newIndex;
    notifyListeners();
  }
}
