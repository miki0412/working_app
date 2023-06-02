import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:working_app/style.dart';

class DialyreportPage extends HookConsumerWidget {
  DialyreportPage({super.key});

  void reportadd() async {
    await FirebaseFirestore.instance.collection('diaryreport').doc().set({
      'year': year.text,
      'month': month.text,
      'day': day.text,
      'attends': _attends.text,
      'time':time.text,
      'detail':detail.text,
      'site':site.text,
      'businessconent':businessconent.text,
      'submissiontime': DateTime.now(),
    });
  }

  final TextEditingController year = TextEditingController();
  final TextEditingController month = TextEditingController();
  final TextEditingController day = TextEditingController();
  final TextEditingController _attends = TextEditingController();
  final TextEditingController time = TextEditingController();
  final TextEditingController detail = TextEditingController();
  final TextEditingController site = TextEditingController();
  final TextEditingController businessconent = TextEditingController();

  final attendsProvider = StateProvider(((ref) => '出勤区分を選択して下さい'));

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('日報',style: Textstyle.titlesize),
        backgroundColor: ColorModel.green,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Textfild(
                      text: '年',
                      controller: year,
                    ),
                  ),
                  const Text('年'),
                  Expanded(
                    child: Textfild(text: '月', controller: month),
                  ),
                  const Text('月'),
                  Expanded(
                    child: Textfild(text: '日', controller: day),
                  ),
                  const Text('日'),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Text('出勤区分'),
                  Expanded(
                    child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        margin: const EdgeInsets.only(left: 15),
                        decoration: BoxDecoration(
                          border: Border.all(color: ColorModel.primary),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Dropmenu(
                          lists: const [
                            '出勤区分を選択して下さい',
                            '出勤',
                            '休日出勤',
                          ],
                          providers: attendsProvider,
                          controller: _attends,
                        )),
                  ),
                ],
              ),
              Dialycell(
                keybordtype: TextInputType.datetime,
                time: time,
                detail: detail,
                site: site,
                businessconent: businessconent,
              ),
              Dialycell(
                keybordtype: TextInputType.datetime,
                time: time,
                detail: detail,
                site: site,
                businessconent: businessconent,
              ),
              Dialycell(
                keybordtype: TextInputType.datetime,
                time: time,
                detail: detail,
                site: site,
                businessconent: businessconent,
              ),
              Dialycell(
                keybordtype: TextInputType.datetime,
                time: time,
                detail: detail,
                site: site,
                businessconent: businessconent,
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  onPressed: () {
                    reportadd();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('日報を記録しました'),
                        backgroundColor: Colors.blue,
                      ),
                    );
                  },
                  child: const Text('記録'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Textfild extends StatelessWidget {
  const Textfild({
    super.key,
    required this.text,
    required this.controller,
  });

  final String text;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: text,
        border: const OutlineInputBorder(),
      ),
    );
  }
}

class Dialycell extends HookConsumerWidget {
  Dialycell({
  super.key,
  required this.keybordtype,
  required this.time,
  required this.detail,
  required this.site,
  required this.businessconent,
  });
  final TextInputType keybordtype;
  final TextEditingController time;
  final TextEditingController detail;
  final TextEditingController site;
  final TextEditingController businessconent;

  final dataProvider = StateProvider((ref) => '現場名を選択して下さい');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 150,
                margin: const EdgeInsets.only(right: 5),
                child: Textfild(text: ': ~ :', controller: detail),
              ),
              Expanded(
                child: Dropmenu(
                  lists: const [
                    '現場名を選択して下さい',
                    'A現場',
                    'B現場',
                    'C現場',
                    'D現場',
                  ],
                  providers: dataProvider,
                  controller: site,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Textfild(
            text: '業務内容',
            controller: businessconent,
          ),
        ],
      ),
    );
  }
}