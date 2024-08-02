import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:studentprovider/provider/provider.dart';
import 'package:studentprovider/screens/add_screen.dart';
import 'package:studentprovider/screens/edit_screen.dart';
import 'package:studentprovider/screens/home_screen.dart';
import 'package:studentprovider/student_model.dart';
import 'package:path_provider/path_provider.dart' as path;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final directory = await path.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
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
        ChangeNotifierProxyProvider<StudentProvider, SearchProvider>(
          create: (context) =>
              SearchProvider(context.read<StudentProvider>().student),
          update: (context, studentProvider, previous) =>
              SearchProvider(studentProvider.student),
        ),
        ChangeNotifierProvider(create: (context) => ImageProviderImg()),
        ChangeNotifierProvider(create: (context) => EditingImageprovider()),
        // ChangeNotifierProvider(create: (context) => TabIndexProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.amber),
        home: const HomeScreen(),
      ),
    );
  }
}
