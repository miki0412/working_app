import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:working_app/pages/administrator_pages/adminstrator_top_page.dart';
import 'package:working_app/pages/employee_pages/login_page.dart';
import 'package:working_app/pages/administrator_pages/administrator_account_edit_page.dart';
import 'package:working_app/style.dart';

class AdministratorLoginPage extends HookConsumerWidget {
  AdministratorLoginPage({super.key});
  final firebaseAuthProvider =
  Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);
  final usernameProvider =
  StateProvider.autoDispose((ref) => TextEditingController());
  final passwordProvider =
  StateProvider.autoDispose((ref) => TextEditingController());

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

  void initState(){
    checkSignin();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firebaseauth = ref.watch(firebaseAuthProvider);
    final username = ref.watch(usernameProvider);
    final password = ref.watch(passwordProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('ログイン（管理者ページ）',style: Textstyle.titlesize),
        backgroundColor: ColorModel.green,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Textfild(
                keybordtype:TextInputType.emailAddress,
                hinttext: 'ユーザー名（メールアドレス）',
                controller: username,
                pass: false,
              ),
              const SizedBox(height: 20),
              Textfild(
                  keybordtype: TextInputType.visiblePassword,
                  hinttext: 'パスワード',
                  controller: password
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: () async {
                  try {
                    final userId = FirebaseAuth.instance.currentUser?.uid;
                    DocumentSnapshot documentsnapshot = await FirebaseFirestore.instance.collection('administrator').doc(userId).get();
                            (await firebaseauth.signInWithEmailAndPassword(
                              email: username.text,
                              password: password.text,
                            )).user;
                        if (documentsnapshot.get('isAdmin') == true){
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (BuildContext context) => AdminstratorTopPage()),
                        );}
                  }on FirebaseAuthException catch(e){
                    if (e.code == 'user-not-found'){
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('登録されていないメールアドレスです'),
                          backgroundColor: ColorModel.red,
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    }else if(e.code == 'wrong-password'){
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('パスワードが違います'),
                          backgroundColor: ColorModel.red,
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    }
                  }
                },
                child: const Text('ログイン'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AdministratorAccountEditPage(),
                  ),
                ),
                child: const Text('アカウントをお持ちでない方はこちらから'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LoginPage()),
                ),
                child: const Text('従業員の方はこちらから'),
              )
            ],
          ),
      ),
    );
  }
}

final isObscureProvider = StateProvider((ref) => true);

class Textfild extends HookConsumerWidget {
  const Textfild({
  super.key,
  required this.keybordtype,
  required this.hinttext,
  required this.controller,
  this.pass = true,
  });

  final TextInputType keybordtype;
  final String hinttext;
  final TextEditingController controller;
  final bool pass;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isObscure = ref.watch(isObscureProvider);
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue),
        borderRadius: BorderRadius.circular(5),
      ),
      child: TextFormField(
        keyboardType: keybordtype,
        obscureText: pass ? isObscure : false,
        decoration: InputDecoration(
          suffixIcon: pass
              ? IconButton(
            onPressed: () {
              ref.read(isObscureProvider.notifier).state = !isObscure;
            },
            icon: Icon(
              isObscure ? Icons.visibility_off : Icons.visibility,
            ),
          )
              : null,
          hintText: hinttext,
        ),
        controller: controller,
      ),
    );
  }
}