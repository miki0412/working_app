import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:working_app/pages/login_page.dart';
import 'package:working_app/pages/paidleave_application_page.dart';
import 'package:working_app/pages/request_lists_page.dart';


class CustomDrawer extends HookConsumerWidget{
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref){
    return Drawer(
      child:ListView(
        children: <Widget>[
          const Padding(padding: EdgeInsets.only(top: 20),),
          ListTile(
            title: Text('申請一覧',style: textStyle),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const RequestListsPage(),
              ),
            ),
          ),
          ListTile(
            title: Text('月報',style: textStyle),
            onTap: (){},
          ),
          ListTile(
            title: Text('工数管理',style: textStyle),
            onTap: (){},
          ),
          ListTile(
            title: Text('お知らせ',style: textStyle),
            onTap: (){},
          ),
          ListTile(
            title: Text('ログアウト',style: textStyle),
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              await Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
            },
          )
        ],
      ),
    );
  }
}

TextStyle textStyle = const  TextStyle(fontSize: 20,fontWeight: FontWeight.bold);

