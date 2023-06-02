import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:working_app/pages/employee_pages/construction_registration_page.dart';
import 'package:working_app/pages/employee_pages/employee_man_hour_management_page.dart';
import 'package:working_app/pages/employee_pages/imformation_page.dart';
import 'package:working_app/pages/employee_pages/login_page.dart';
import 'package:working_app/pages/employee_pages/monthly_report_page.dart';
import 'package:working_app/pages/employee_pages/payment_record_page.dart';
import 'package:working_app/pages/employee_pages/request_lists_page.dart';
import 'package:working_app/pages/employee_pages/task_list.dart';
import 'package:working_app/pages/employee_pages/top_page.dart';
import 'package:working_app/pages/navigation_provider.dart';

class CustomDrawer extends HookConsumerWidget {
  CustomDrawer({super.key});

  final navigtionProvider = ChangeNotifierProvider((ref) => NavigationProvider());

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigationState = ref.watch(navigtionProvider);
    switch (navigationState.currentPage) {
      case '/top' : return TopPage();
      case '/task' : return TaskList();
      case '/request' : return RequestListsPage();
      case '/monthly' : return MonthlyReportPage();
      case '/construction' : return ConstructionRegistrationPage();
      case '/paymentrecordpage' : return PaymentRecordPage();
      case '/manhourmanagement' : return EmployeeManHourManagementPage();
      case '/info' : return InformationPage();
    }
    return Drawer(
      child: ListView(
        children: <Widget>[
          ListTile(
            title: Row(
              children: [
                const Icon(Icons.home),
                sizebox,
                Text('トップページへ', style: textStyle),
              ],
            ),
            onTap: (){
              navigationState.NavigatePage('/top');
            },
            selected: navigationState.currentPage == '/top',
          ),
          ListTile(
            title: Row(children: [
                const Icon(Icons.task),
                sizebox,
                Text('タスク一覧',style: textStyle),
              ],),
            onTap: (){
              navigationState.NavigatePage('/task');
            },
            selected: navigationState.currentPage == '/task',
          ),
          ListTile(
            title: Row(
              children: [
                const Icon(Icons.app_registration),
                sizebox,
                Text('申請一覧', style: textStyle),
              ],
            ),
            onTap: (){
              navigationState.NavigatePage('/request');
            },
            selected: navigationState.currentPage == '/request',
          ),
          ListTile(
            title: Row(
              children: [
                const Icon(Icons.list_alt),
                sizebox,
                Text('月報', style: textStyle),
              ],
            ),
            onTap: (){
              navigationState.NavigatePage('/monthly');
            },
            selected: navigationState.currentPage == '/monthly',
          ),
          ListTile(
            title: Row(
              children: [
                const Icon(Icons.handyman),
                sizebox,
                Text('工事登録', style: textStyle),
              ],
            ),
            onTap: (){
              navigationState.NavigatePage('/construction');
            },
            selected: navigationState.currentPage == '/construction',
          ),
          ListTile(
            title: Row(
              children: [
                const Icon(Icons.currency_yen),
                sizebox,
                Text('支払調書', style: textStyle),
              ],
            ),
            onTap: (){
              navigationState.NavigatePage('/paymentrecordpage');
            },
            selected: navigationState.currentPage == '/paymentrecordpage',
          ),
          ListTile(
            title: Row(
              children: [
                const Icon(Icons.engineering),
                sizebox,
                Text('工数管理', style: textStyle),
              ],
            ),
            onTap: (){
              navigationState.NavigatePage('/manhourmanagement');
            },
            selected: navigationState.currentPage == 'manhourmanagement',
          ),
          ListTile(
            title: Row(
              children: [
                const Icon(Icons.info),
                sizebox,
                Text('お知らせ', style: textStyle),
              ],
            ),
            onTap: (){
              navigationState.NavigatePage('/info');
            },
            selected: navigationState.currentPage == 'info',
          ),
          ListTile(
            title: Row(
              children: [
                const Icon(Icons.logout),
                sizebox,
                Text('ログアウト', style: textStyle),
              ],
            ),
            onTap: (){
              FirebaseAuth.instance.signOut();
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
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