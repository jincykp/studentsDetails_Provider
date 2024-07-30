import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:studentprovider/provider/provider.dart';
import 'package:studentprovider/screens/add_screen.dart';
import 'package:studentprovider/student_model.dart';
import 'package:studentprovider/widget/tabar.dart';
import 'package:path_provider/path_provider.dart' as path;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final direct = await path.getApplicationDocumentsDirectory();
  Hive.init(direct.path);
  Hive.registerAdapter(StudentsModelAdapter());
  await Hive.openBox<StudentsModel>('students');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => StudentProvider()),
        ChangeNotifierProvider(create: (context) => ImageProviderImg()),
        ChangeNotifierProvider(create: (context) => TabIndexProvider())
      ],
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(primarySwatch: Colors.amber),
          home: const TabBarScreen(),
        );
      },
    );
  }
}
