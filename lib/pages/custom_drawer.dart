import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:working_app/pages/login_page.dart';
import 'package:working_app/pages/request_lists_page.dart';
import 'package:working_app/pages/top_page.dart';

class CustomDrawer extends HookConsumerWidget {
  const CustomDrawer({super.key});

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
                .push(MaterialPageRoute(builder: (context) => TopPage())),
          ),
          ListTile(
            title: Row(
              children: [
                const Icon(Icons.app_registration),
                sizebox,
                Text('申請一覧', style: textStyle),
              ],
            ),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const RequestListsPage(),
              ),
            ),
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
                  MaterialPageRoute(builder: (context) => LoginPage()));
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