import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ulas_buku_mobile/features/authentication/presentation/login/login_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
      ),
      home: const LoginPage(),
    );
  }
}
