import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:working_app/model.dart';
import 'package:working_app/pages/employee_pages/custom_drawer.dart';
import 'package:working_app/pages/employee_pages/dialyreport_page.dart';

class TopPage extends HookConsumerWidget {
  TopPage({super.key});

  final DateFormat date = DateFormat('yyyy年MM月dd日');
  final DateFormat time = DateFormat('HH:mm:ss');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const appbarmodel(title: 'トップページ'),
      endDrawer: const CustomDrawer(),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                '山田太郎　ログイン日時${date.format(DateTime.now())}${time.format(DateTime.now())}'),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 150, bottom: 50),
              child: Column(
                children: [
                  Text(
                    date.format(DateTime.now()),
                    style: const TextStyle(fontSize: 40),
                  ),
                  Text(
                    time.format(DateTime.now()),
                    style: const TextStyle(fontSize: 40),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child:ElevatedButton(
                  onPressed: () {},
                  child: const Text('出勤'),
                ),),
                const SizedBox(width: 40),
                Expanded(child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('退勤'),
                ),),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DialyreportPage()));
                },
                child: const Text('日報入力ページへ'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
