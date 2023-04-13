import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:working_app/model.dart';
import 'package:working_app/pages/custom_drawer.dart';

class BusinesstripApplicationPage extends HookConsumerWidget {
  BusinesstripApplicationPage({super.key});

  void applications() async {
    await FirebaseFirestore.instance.collection('出張申請').doc().set({
      'month': month.text,
      'day':day.text,
      '_month':_month.text,
      '_day':_day.text,
      'tripplace':tripplace.text,
      'thepurpose':thepurpose.text,
      'tripmethod':tripmethod.text,
    });
  }

  final TextEditingController month = TextEditingController();
  final TextEditingController day = TextEditingController();
  final TextEditingController _month = TextEditingController();
  final TextEditingController _day = TextEditingController();
  final TextEditingController minute = TextEditingController();
  final TextEditingController tripplace = TextEditingController();
  final TextEditingController thepurpose = TextEditingController();
  final TextEditingController tripmethod = TextEditingController();
  final placeProvider = StateProvider((ref) => '交通手段を選択してください');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final place = ref.watch(placeProvider);
    return Scaffold(
      appBar: const appbarmodel(
        title: '出張申請',
      ),
      endDrawer: const CustomDrawer(),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               const Text('出発１週間前間までに提出してください'),
              const SizedBox(height: 10),
              const Text('項目を全て入力してください'),
              const SizedBox(height: 5),
              Container(
                padding:
                    const EdgeInsets.only(top: 15, right: 10,left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('出張日を入力してください'),
                    Row(
                      children: [
                        Expanded(
                          child: container(controller: month, hinttext: '月'),
                        ),
                        const Text('月'),
                        Expanded(
                            child: container(controller: day, hinttext: '日')),
                        const Text('日'),
                        const Text('〜'),
                        Expanded(
                          child: container(controller: _month, hinttext: '月'),
                        ),
                        const Text('月'),
                        Expanded(
                            child: container(controller: _day, hinttext: '日')),
                        const Text('日'),
                      ],
                    ),
                    const SizedBox(height: 10),
                    container(
                      controller: tripplace,
                      hinttext: '出張先を入力してください',
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(vertical: 15),
                      padding: const EdgeInsets.symmetric(horizontal: 7),
                      decoration: BoxDecoration(
                        border: Border.all(color: ColorModel.primary),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: DropdownButton(
                        isExpanded: true,
                        underline: Container(),
                        items: const [
                          DropdownMenuItem(
                            value: '交通手段を選択してください',
                            child: Text('交通手段を選択ださい'),
                          ),
                          DropdownMenuItem(
                            value: '社有車',
                            child: Text('社有車'),
                          ),
                          DropdownMenuItem(
                            value: '自家用車',
                            child: Text('自家用車'),
                          ),
                          DropdownMenuItem(
                            value: '新幹線',
                            child: Text('新幹線'),
                          ),
                          DropdownMenuItem(
                            value: 'バス',
                            child: Text('バス'),
                          ),
                          DropdownMenuItem(
                            value: '飛行機',
                            child: Text('飛行機'),
                          ),
                        ],
                        value: place,
                        onChanged: (value) {
                          ref.read(placeProvider.notifier).state = value!;
                          tripmethod.text = value!;
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 15, bottom: 15),
                      decoration: BoxDecoration(
                        border: Border.all(color: ColorModel.primary),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextFormField(
                        maxLines: 10,
                        controller: thepurpose,
                        decoration: const InputDecoration(
                          hintText: '出張の目的を入力してください',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    sizedbox(
                        widthsize: double.infinity,
                        heightsize: 40,
                        child: ElevatedButton(
                          onPressed: () {applications();},
                          child: const Text(
                            '申請する',
                            style: TextStyle(fontSize: 15),
                          ),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class container extends StatelessWidget {
  const container({
    required this.controller,
    required this.hinttext,
  });

  final TextEditingController controller;
  final String hinttext;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: const Color(0xFF000000),
        ),
        color: ColorModel.white,
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hinttext,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
