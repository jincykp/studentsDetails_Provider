import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentprovider/provider/provider.dart';
import 'package:studentprovider/screens/add_screen.dart';
import 'package:studentprovider/screens/full_view_screen.dart';
import 'package:studentprovider/screens/gridview_screen.dart';
import 'package:studentprovider/student_model.dart';
import 'package:studentprovider/styles/styles.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final studentProvider = Provider.of<StudentProvider>(context);
    final searchProvider = Provider.of<SearchProvider>(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(140),
        child: AppBar(
          foregroundColor: iconsColor,
          backgroundColor: themecode,
          title: const Text(
            'Student Details',
            style: TextStyle(color: iconsColor, fontWeight: studentfont),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const GridViewScreen()));
                },
                icon: const Icon(
                  Icons.grid_view,
                  size: 30,
                ))
          ],
          flexibleSpace: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 60),
                SizedBox(
                  width: double.infinity,
                  child: TextFormField(
                    onChanged: (query) {
                      searchProvider.updateSearchQuery(query);
                    },
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      contentPadding:
                          const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: searchProvider.filteredStudents.isEmpty &&
                searchProvider._searchQuery.isNotEmpty
            ? const Center(
                child: Text(
                  'No results found',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              )
            : ListView.builder(
                itemCount: searchProvider.filteredStudents.isNotEmpty
                    ? searchProvider.filteredStudents.length
                    : studentProvider.student.length,
                itemBuilder: (context, index) {
                  final student = searchProvider.filteredStudents.isNotEmpty
                      ? searchProvider.filteredStudents[index]
                      : studentProvider.student[index];
                  return Card(
                    color: listTilecolor,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FullViewScreen(
                              student: student,
                            ),
                          ),
                        );
                      },
                      child: ListTile(
                        title: Text(
                          student.studentName!,
                          style: const TextStyle(
                            color: iconsColor,
                            fontWeight: studentfont,
                          ),
                        ),
                        subtitle: Text(student.studentRegNo!),
                      ),
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: themecode,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddScreen()));
        },
        child: const Icon(
          Icons.add,
          color: iconsColor,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

class SearchProvider extends ChangeNotifier {
  final List<StudentsModel> _students;
  String _searchQuery = '';

  SearchProvider(this._students);

  String get searchQuery => _searchQuery;

  List<StudentsModel> get filteredStudents {
    if (_searchQuery.isEmpty) {
      return [];
    }
    return _students.where((student) {
      return student.studentName!
              .toLowerCase()
              .contains(_searchQuery.toLowerCase()) ||
          student.studentRegNo!
              .toLowerCase()
              .contains(_searchQuery.toLowerCase());
    }).toList();
  }

  void updateSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }
}
