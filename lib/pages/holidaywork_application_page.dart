import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:working_app/model.dart';
import 'package:working_app/pages/custom_drawer.dart';


class HolidayworkApplicationPage extends HookConsumerWidget{
  HolidayworkApplicationPage({super.key});

  final TextEditingController month = TextEditingController();
  final TextEditingController day = TextEditingController();
  final TextEditingController hour = TextEditingController();
  final TextEditingController minute = TextEditingController();
  final placeProvider = StateProvider((ref) => '場所を選択してください');

  @override
  Widget build(BuildContext context,WidgetRef ref){
    final place = ref.watch(placeProvider);
    return Scaffold(
      appBar: const appbarmodel(
        title: '休日出勤申請',
      ),
      endDrawer: const CustomDrawer(),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 30,horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              child: const FittedBox(
                fit: BoxFit.scaleDown,
                child: Text('休日出勤をする場合は前日の15時までに提出してください'),
              ),
            ),
            const SizedBox(height: 10),
            const Text('休日出勤をする日にち及び時間を入力してください'),
            const SizedBox(height: 5),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
              child:Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: container(controller: month, hinttext: '月'),),
                      const Text('月'),
                      Expanded(
                          child: container(
                              controller: day,
                              hinttext: '日'
                          )
                      ),
                      const Text('日'),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(child: container(controller: hour, hinttext: '時'),),
                      const Text('時'),
                      Expanded(child: container(controller: minute, hinttext: '分'),),
                      const Text('分'),
                      const Text('〜'),
                      Expanded(child: container(controller: hour, hinttext: '時'),),
                      const Text('時'),
                      Expanded(child: container(controller: minute, hinttext: '分'),),
                      const Text('分'),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(vertical: 15),
                    padding: const EdgeInsets.symmetric(horizontal: 7),
                    decoration: BoxDecoration(
                      border: Border.all(color: ColorModel.primary),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child:DropdownButton(
                      isExpanded:true,
                      underline: Container(),
                      items: const [
                        DropdownMenuItem(value:'場所を選択してください',child: Text('場所を選択ださい'),),
                        DropdownMenuItem(value:'会社',child: Text('会社'),),
                        DropdownMenuItem(value:'現場',child: Text('現場'),),
                      ],
                      value: place,
                      onChanged: (String? value){ref.read(placeProvider.notifier).state = value!;},
                    ),),
                  Container(
                    margin: const EdgeInsets.only(top: 15,bottom:15),
                    decoration: BoxDecoration(
                      border: Border.all(color: ColorModel.primary),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child:TextFormField(
                      maxLines: 5,
                      decoration: const InputDecoration(
                        hintText: '理由を入力してください',
                        border: OutlineInputBorder(),
                      ),

                    ),),
                  const SizedBox(height: 30),
                  sizedbox(
                      widthsize: double.infinity,
                      heightsize: 40,
                      child: ElevatedButton(
                        onPressed: (){},
                        child: const Text('申請する',style: TextStyle(fontSize: 15),),
                      )
                  ),
                ],
              ),),
          ],
        ),
      ),
    );
  }
}

class container extends StatelessWidget{
  const container({
    required this.controller,
    required this.hinttext,
  });
  final TextEditingController controller;
  final String hinttext;

  @override
  Widget build(BuildContext context){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: const Color(0xFF000000),),
        color: ColorModel.white,
      ),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hinttext,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}

