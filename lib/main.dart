

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


import 'home_page.dart';

/// Let's an App that will show our basketball live score

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const crud());
}

class crud extends StatelessWidget {
  const crud({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: HomeScreen(),
      themeMode: ThemeMode.light,
      theme:ThemeData(
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder()
        )
      )
    );
  }
}

