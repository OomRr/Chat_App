
import 'package:chat_app_version_one/pages/chat_page.dart';
import 'package:chat_app_version_one/pages/login_page.dart';
import 'package:chat_app_version_one/pages/register_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp( const ScholarChat());
}
class ScholarChat extends StatelessWidget {
  const ScholarChat({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        LonginPage.id:(context)=>LonginPage(),
        RegisterPage.id:(context)=>const RegisterPage(),
        ChatPage.id:(context)=>ChatPage(),
      },
      initialRoute: LonginPage.id,
    );
  }
}
