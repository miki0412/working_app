import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:working_app/pages/administrator_pages/administrator_information_page.dart';
import 'package:working_app/pages/administrator_pages/administrator_login_page.dart';
import 'package:working_app/pages/administrator_pages/adminstrator_top_page.dart';
import 'package:working_app/pages/administrator_pages/employee_management_page.dart';
import 'package:working_app/pages/administrator_pages/employee_monthly_report.dart';
import 'package:working_app/pages/administrator_pages/man_hour_management_page.dart';
import 'package:working_app/pages/navigation_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AdminstratorCustomDrawer extends HookConsumerWidget {
  AdminstratorCustomDrawer({super.key,});

  final navigationProvider = ChangeNotifierProvider((ref) => NavigationProvider());

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigationState = ref.watch(navigationProvider);
    switch (navigationState.currentPage) {
      case '/_top': return AdminstratorTopPage();
      case '/management' : return EmployeeManagementPage();
      case '/monthly' : return EmployeeMonthlyReport();
      case '/information' : return AdministratorInformationPage();
      case '/manhourmanagement' : return ManHourManagementPage();
    }
    return Drawer(
      child: ListView(
        children: <Widget>[
          ListTile(
            title: Row(children: [
              const Icon(Icons.home),
              Text('トップページへ',style: textStyle),
            ],),
            onTap: (){
              navigationState.NavigatePage('/_top');
            },
            selected: navigationState.currentPage == '/_top',
          ),
          ListTile(
            title: Row(children: [
              const Icon(Icons.app_registration),
              Text('各種情報管理',style: textStyle),
            ],),
            onTap: (){
              navigationState.NavigatePage('/management');
            },
            selected: navigationState.currentPage == '/management',
          ),
          ListTile(
            title: Row(children: [
              const Icon(Icons.list_alt),
              Text('月報',style: textStyle),
            ],),
            onTap: (){
              navigationState.NavigatePage('/monthly');
            },
            selected: navigationState.currentPage == 'monthly',
          ),
          ListTile(
            title: Row(children: [
              const Icon(Icons.engineering),
              Text('工数管理',style: textStyle),
            ],),
            onTap: (){
              navigationState.NavigatePage('/manhourmanagement');
            },
            selected: navigationState.currentPage == '/manhourmanagement',
          ),
          ListTile(
            title: Row(children:[
              const Icon(Icons.info),
              Text('お知らせ',style: textStyle),
            ],),
            onTap: (){
              navigationState.NavigatePage('/information');
            },
            selected: navigationState.currentPage == '/information',
          ),
          ListTile(
            title: Row(children: [
              const Icon(Icons.logout),
              Text('ログアウト',style: textStyle),
            ],),
            onTap: (){
              FirebaseAuth.instance.signOut();
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => AdministratorLoginPage()));
            },
          ),
        ],
      ),
    );
  }
}

TextStyle textStyle =
const TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
SizedBox sizebox = const SizedBox(width: 10);