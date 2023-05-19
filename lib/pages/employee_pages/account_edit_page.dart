import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:working_app/style.dart';

class AccountEditPage extends HookConsumerWidget {
  AccountEditPage({super.key});

  editUser() async {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: email.text, password: password.text);
    User user = userCredential.user!;
    FirebaseFirestore.instance.collection('users').doc(user.uid).set({
      '会社名':companyname.text,
      '住所':adress.text,
      '電話番号':phonenum.text,
      'メールアドレス':email.text,
      'パスワード':password.text,
      '追加時間':DateTime.now(),
    });
  }

  final TextEditingController companyname = TextEditingController();
  final TextEditingController adress = TextEditingController();
  final TextEditingController representative = TextEditingController();
  final TextEditingController phonenum = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'アカウント追加',
          style: Textstyle.titlesize,
        ),
        backgroundColor: ColorModel.green,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Textfild(
                keybordtype: TextInputType.text,
                hinttext: '会社名',
                controller: companyname,
              ),
              Sizebox,
              Textfild(
                keybordtype: TextInputType.text,
                hinttext: '住所',
                controller: adress,
              ),
              Sizebox,
              Textfild(keybordtype:TextInputType.phone,hinttext: '電話番号', controller: phonenum),
              Sizebox,
              Textfild(keybordtype:TextInputType.emailAddress,hinttext: 'メールアドレス', controller: email),
              Sizebox,
              Textfild(
                keybordtype: TextInputType.text,
                hinttext: '代表者名',
                controller: representative,
              ),
              Sizebox,
              Textfild(
                keybordtype: TextInputType.visiblePassword,
                hinttext: 'パスワード',
                controller: password,
                //isVisible: true,
              ),
              Sizebox,
              Text(password.text == _password.text ? '' : 'パスワードが一致しません'),
              Textfild(
                keybordtype: TextInputType.visiblePassword,
                hinttext: 'パスワード（確認用）',
                controller: _password,
                //isVisible : true,
              ),
              Sizebox,
              ElevatedButton(
                onPressed: () async {
                  try {
                    await editUser();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('ユーザー登録が完了しました'),
                        backgroundColor: Colors.blue,
                      ),
                    );
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'email-already-in-use') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('すでに登録されているメールアドレスです'),
                          backgroundColor: ColorModel.red,
                        ),
                      );
                    } else if (e.code == 'invalid-email') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('メールアドレスが正しくありません'),
                          backgroundColor: ColorModel.red,
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('ユーザー登録が完了しました'),
                          backgroundColor: Colors.blue,
                        ),
                      );
                    }
                  }
                },
                child: const Text('アカウントを作成'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Textfild extends HookConsumerWidget {
  const Textfild({
    super.key,
    required this.keybordtype,
    required this.hinttext,
    required this.controller,
    this.isVisible = false,
  });

  final TextInputType keybordtype;
  final String hinttext;
  final TextEditingController controller;
  final bool isVisible;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextFormField(
      controller: controller,
      //maxLength: isVisible == true?10:null,
      decoration: InputDecoration(
        hintText: hinttext,
      ),
    );
  }
}

SizedBox Sizebox = const SizedBox(height: 30);
