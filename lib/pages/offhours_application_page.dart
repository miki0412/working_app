import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:working_app/model.dart';
import 'package:working_app/pages/custom_drawer.dart';


class OffhoursApplicationPage extends HookConsumerWidget{
  OffhoursApplicationPage({super.key});

  final TextEditingController month = TextEditingController();
  final TextEditingController day = TextEditingController();
  final TextEditingController hour = TextEditingController();
  final TextEditingController minute = TextEditingController();

  @override
  Widget build(BuildContext context,WidgetRef ref){
    return Scaffold(
      appBar: const appbarmodel(
        title: '時間外申請',
      ),
      endDrawer: const CustomDrawer(),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              child: const FittedBox(
                fit: BoxFit.scaleDown,
                child: Text('時間外申請はなるべく当日の15時までに申請するようにしましょう'),
              ),
            ),
            const SizedBox(height: 10),
            const Text('時間外をする日にち及び時間を入力してください'),
            const SizedBox(height: 5),
            Row(
              children: [
                Expanded(child: container(controller: month, hinttext: '月'),),
                // Expanded(child: Container(
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(5),
                //     border: Border.all(color: const Color(0xFF000000),),
                //   ),
                //   child:TextFormField(
                //   decoration: const InputDecoration(
                //     hintText: '月'
                //   ),),
                // ),),
                const Text('月'),
                Expanded(
                    child: container(
                        controller: day,
                        hinttext: '日'
                    )
                ),
                // Expanded(child:Container(
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(5),
                //     border: Border.all(color: const Color(0xFF000000),),
                //   ),
                //   child:TextFormField(
                //     decoration: const InputDecoration(
                //         hintText: '日'
                //     ),),
                // ),),
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
      ),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hinttext,
        ),
      ),
    );
  }
}

