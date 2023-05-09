import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:working_app/model.dart';

class OffhoursApplicationApproval extends HookConsumerWidget{
  OffhoursApplicationApproval(this.offhourData);
  final DocumentSnapshot offhourData;

  @override
  Widget build(BuildContext context,WidgetRef ref){
    return Scaffold(
      appBar: const appbarmodel(title: '時間外申請承認ページ'),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 30),
          child: Column(
            children: [
              Row(
                children: [
                  Text('日付　　　：　',style: textstyle.titlesize),
                  Text('${offhourData.get('month')}月${offhourData.get('day')}日',style: textstyle.titlesize),
                ],
              ),
              sizebox,
              Row(
                children: [
                  Text('時間　　　：　',style: textstyle.titlesize),
                  Text('${offhourData.get('hour')}:${offhourData.get('minute')}〜${offhourData.get('_hour')}:${offhourData.get('_minute')}',style: textstyle.titlesize)
                ],
              ),
              sizebox,
              Row(
                children: [
                  Text('残業場所　：　',style: textstyle.titlesize),
                  Text('${offhourData.get('offhourswokplace')}',style: textstyle.titlesize),
                ],
              ),
              sizebox,
              Row(
                children: [
                  Text('理由　　　：　',style: textstyle.titlesize),
                  Text('${offhourData.get('thepurpose')}',style: textstyle.titlesize),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 170,
                    child:ElevatedButton(
                      onPressed: (){},
                      child: const Text('承  認',style: TextStyle(fontSize: 20),),
                  ),),
                  SizedBox(
                    width: 170,
                    child:ElevatedButton(
                      onPressed: (){},
                      child: const Text('拒  否',style: TextStyle(fontSize: 20),),
                  ),),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

SizedBox sizebox = const SizedBox(height: 10);
