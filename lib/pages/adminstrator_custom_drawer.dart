import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:working_app/pages/administrator_login_page.dart';
import 'package:working_app/pages/adminstrator_top_page.dart';
import 'package:working_app/pages/employee_management_page.dart';

class AdminstratorCustomDrawer extends HookConsumerWidget {
  const AdminstratorCustomDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(top: 20),
          ),
          ListTile(
            title: Row(
              children: [
                const Icon(Icons.home),
                sizebox,
                Text('トップページへ', style: textStyle),
              ],
            ),
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => const AdminstratorTopPage())),
          ),
          ListTile(
            title: Row(
              children: [
                const Icon(Icons.app_registration),
                sizebox,
                Text('各種情報管理', style: textStyle),
              ],
            ),
            onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (context)=> EmployeeManagementPage()));},
          ),
          ListTile(
            title: Row(
              children: [
                const Icon(Icons.list_alt),
                sizebox,
                Text('月報', style: textStyle),
              ],
            ),
            onTap: () {},
          ),
          ListTile(
            title: Row(
              children: [
                const Icon(Icons.engineering),
                sizebox,
                Text('工数管理', style: textStyle),
              ],
            ),
            onTap: () {},
          ),
          ListTile(
            title: Row(
              children: [
                const Icon(Icons.info),
                sizebox,
                Text('お知らせ', style: textStyle),
              ],
            ),
            onTap: () {},
          ),
          ListTile(
            title: Row(
              children: [
                const Icon(Icons.logout),
                sizebox,
                Text('ログアウト', style: textStyle),
              ],
            ),
            onTap: () {
              FirebaseAuth.instance.signOut();
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => AdministratorLoginPage()));
            },
          )
        ],
      ),
    );
  }
}

TextStyle textStyle =
const TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
SizedBox sizebox = const SizedBox(width: 10);