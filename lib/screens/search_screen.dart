import 'package:flutter/material.dart';
import 'package:studentprovider/styles/styles.dart';

class SeacrchScreen extends StatelessWidget {
  const SeacrchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(140),
        child: AppBar(
          foregroundColor: Colors.black,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30)),
          ),
          backgroundColor: themecode,
          title: const Text(
            "Student Details",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          flexibleSpace: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 60,
                ),
                SizedBox(
                  width: double.infinity,
                  child: TextFormField(
                    //  controller: searchController,
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
                    // onChanged: (value) {
                    //   studentController.searchStudent(value);
                    // },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
