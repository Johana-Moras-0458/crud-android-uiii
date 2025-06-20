import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
//import 'package:myapp/pages/add_name_page.dart';//
//import 'package:myapp/pages/edit_name_page.dart';//
//import 'package:myapp/pages/home_page.dart';//
import 'package:myapp/pages/peluches_page.dart';
import 'package:myapp/pages/add_peluche_page.dart';
import 'package:myapp/pages/edit_peluche_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "mi crud",
      initialRoute: "/peluches",
      routes: {
        //"/": (context) => const Home(),//
        //"/add": (context) => const AddNamePage(),
        //"/edit": (context) => const EditNamePage(),//
        "/peluches": (context) => const PeluchesPage(),
        "/add": (context) => const AddPeluchePage(),     // <- actualizado
        "/edit": (context) => const EditPeluchePage(), 
      },
    );
  }
}

