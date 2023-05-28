import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:working_app/style.dart';
import 'package:working_app/pages/employee_pages/account_edit_page.dart';
import 'package:working_app/pages/administrator_pages/administrator_login_page.dart';
import 'package:working_app/pages/employee_pages/top_page.dart';

class LoginPage extends HookConsumerWidget {
  LoginPage({super.key});

  final firebaseAuthProvider =
      Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);
  final usernameProvider =
      StateProvider.autoDispose((ref) => TextEditingController());
  final passwordProvider =
      StateProvider.autoDispose((ref) => TextEditingController());

  bool signCheck = false;

  void signInTime() async{
    await FirebaseFirestore.instance.collection('ログイン日時').doc().set({
      'ログイン日時':DateTime.now(),
    });
  }

  void checkSignin() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        signCheck = false;
      } else {
        signCheck = true;
      }
    });
  }

  void initState() {
    checkSignin();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firebaseauth = ref.watch(firebaseAuthProvider);
    final username = ref.watch(usernameProvider);
    final password = ref.watch(passwordProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ログイン(従業員ページ）',
          style: TextStyle(color: Color(0xFFFFFFFF)),
        ),
        backgroundColor: const Color(0xFF3CB371),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Textfild(
              keybordtype: TextInputType.emailAddress,
              hinttext: 'ユーザー名（メールアドレス）',
              controller: username,
              pass: false,
            ),
            const SizedBox(height: 20),
            Textfild(
                keybordtype: TextInputType.visiblePassword,
                hinttext: 'パスワード',
                controller: password),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: () async {
                try {
                  final User? user =
                      (await firebaseauth.signInWithEmailAndPassword(
                    email: username.text,
                    password: password.text,
                  ))
                          .user;
                  if (user != null)
                    signInTime();
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) {
                        return TopPage();
                      }),
                    );
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'user-not-found') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('登録されていないメールアドレスです'),
                        backgroundColor: ColorModel.red,
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  } else if (e.code == 'wrong-password') {
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
                  builder: (context) => AccountEditPage(),
                ),
              ),
              child: const Text('アカウントをお持ちでない方はこちらから'),
            ),
            TextButton(
              onPressed: () => {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => AdministratorLoginPage())),
              },
              child: const Text('管理者の方はこちらから'),
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
