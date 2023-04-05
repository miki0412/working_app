import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:working_app/pages/account_edit_page.dart';
import 'package:working_app/pages/top_page.dart';

class LoginPage extends HookConsumerWidget {
  LoginPage({super.key});

  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();

  void Signin() async {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: username.text,
        password: password.text,
      );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ログイン',
          style: TextStyle(color: Color(0xFFFFFFFF)),
        ),
        backgroundColor: const Color(0xFF3CB371),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              text_fild(
                hinttext: 'ユーザー名（メールアドレス）',
                controller: username,
                pass: false,
              ),
              const SizedBox(height: 20),
              text_fild(hinttext: 'パスワード', controller: password),
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: () {
                  try{
                    Signin();{
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => TopPage()),
                      );
                    }
                  }catch(e){}
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
              )
            ],
          ),
        ),
      ),
    );
  }
}

final isObscureProvider = StateProvider((ref) => true);

class text_fild extends HookConsumerWidget {
  const text_fild({
    super.key,
    required this.hinttext,
    required this.controller,
    this.pass = true,
  });

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
