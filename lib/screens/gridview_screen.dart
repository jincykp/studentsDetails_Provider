import 'package:flutter/material.dart';
import 'package:studentprovider/styles/styles.dart';

class GridViewScreen extends StatelessWidget {
  const GridViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                  itemCount: 8,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return const Card(
                      color: themecode,
                      child: SizedBox(
                        height: 40,
                        width: 40,
                      ),
                    );
                  }),
            )
          ],
        ),
      )),
    );
  }
}
