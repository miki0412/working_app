import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:working_app/style.dart';

class OffhoursApplicationApproval extends HookConsumerWidget{
  OffhoursApplicationApproval(this.offhourData);
  final DocumentSnapshot offhourData;

  @override
  Widget build(BuildContext context,WidgetRef ref){
    return Scaffold(
      appBar: AppBar(
        title: Text('時間外申請承認ページ',style: Textstyle.titlesize),
        backgroundColor: ColorModel.green,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 30),
          child: Column(
            children: [
              Row(
                children: [
                  Text('日付　　　：　',style: Textstyle.titlesize),
                  Text('${offhourData.get('month')}月${offhourData.get('day')}日',style: Textstyle.titlesize),
                ],
              ),
              Sizebox,
              Row(
                children: [
                  Text('時間　　　：　',style: Textstyle.titlesize),
                  Text('${offhourData.get('hour')}:${offhourData.get('minute')}〜${offhourData.get('_hour')}:${offhourData.get('_minute')}',style: Textstyle.titlesize)
                ],
              ),
              Sizebox,
              Row(
                children: [
                  Text('残業場所　：　',style: Textstyle.titlesize),
                  Text('${offhourData.get('offhourswokplace')}',style: Textstyle.titlesize),
                ],
              ),
              Sizebox,
              Row(
                children: [
                  Text('理由　　　：　',style: Textstyle.titlesize),
                  Text('${offhourData.get('thepurpose')}',style: Textstyle.titlesize),
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

SizedBox Sizebox = const SizedBox(height: 10);
