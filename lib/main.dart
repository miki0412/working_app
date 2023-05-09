import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:working_app/firebase_options.dart';
import 'package:working_app/pages/employee_pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:working_app/pages/employee_pages/top_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}
bool signCheck = false;

void checkSignin(){
  FirebaseAuth.instance.authStateChanges().listen((User?user) {
    if(user == null){
      signCheck = false;
    }else{
      signCheck = true;
    }
  });
}

@override
void initState(){
  checkSignin();
}

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '勤怠アプリ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProviderScope(child:signCheck == false?LoginPage():TopPage()),
    );
  }
}