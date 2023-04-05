import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


class AccountEditPage extends HookConsumerWidget{
  AccountEditPage({super.key});

  void editUser()async{
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text
    );
    User user = userCredential.user!;
    FirebaseFirestore.instance.collection('users').doc(user.uid).set({
      '会社名':companyname.text,
      '住所':adress.text,
      '電話番号':phonenum.text,
      'メールアドレス':email.text,
      'パスワード':password.text,
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
  Widget build(BuildContext context,WidgetRef ref){
    return Scaffold(
      appBar: AppBar(
        title: const Text('アカウント追加',style: TextStyle(color: Color(0xFFFFFFFF)),),
        backgroundColor: const Color(0xFF3CB371),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
        child: Column(
          crossAxisAlignment:CrossAxisAlignment.center,
          children: [
            textfild(
                hinttext: '会社名',
                controller: companyname,
            ),
            sized_box,
            textfild(
                hinttext: '住所',
                controller: adress,
            ),
            sized_box,
            textfild(
                hinttext: '電話番号',
                controller: phonenum
            ),
            sized_box,
            textfild(
                hinttext: 'メールアドレス',
                controller: email
            ),
            sized_box,
            textfild(
                hinttext: '代表者名',
                controller: representative,
            ),
            sized_box,
            textfild(
                hinttext: 'パスワード',
                controller: password,
                //isVisible: true,
            ),
            sized_box,
            Text(password == _password?'':'パスワードが一致しません',style: const TextStyle(color: Colors.red),),
            textfild(
                hinttext: 'パスワード（確認用）',
                controller: _password,
                //isVisible : true,
            ),
            sized_box,
            ElevatedButton(
              onPressed: (){editUser();},
              child: const Text('アカウントを作成'),
            ),
          ],
        ),
      ),
    );
  }
}

class textfild extends HookConsumerWidget{
  const textfild({
    super.key,
    required this.hinttext,
    required this.controller,
    this.isVisible = false,
  });
  final String hinttext;
  final TextEditingController controller;
  final bool isVisible;

  @override
  Widget build(BuildContext context,WidgetRef ref){
    return TextFormField(
      controller: controller,
      //maxLength: isVisible == true?10:null,
      decoration: InputDecoration(
        hintText: hinttext,
      ),
    );
  }
}

SizedBox sized_box = const SizedBox(height: 30);