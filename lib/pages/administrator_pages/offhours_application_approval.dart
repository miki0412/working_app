import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:working_app/style.dart';

class OffhoursApplicationApproval extends HookConsumerWidget{
  OffhoursApplicationApproval(this.offhourData);
  final DocumentSnapshot offhourData;

  void approvaldata() async {
    await FirebaseFirestore.instance.collection('時間外申請済み').doc().set({
      '月':offhourData['month'],
      '日':offhourData['day'],
      '開始時':offhourData['hour'],
      '開始分':offhourData['minute'],
      '終了時':offhourData['_hour'],
      '終了分':offhourData['_minute'],
      '理由':offhourData['thepurpose'],
      '場所':offhourData['offhourswokplace'],
    });
  }

  void rejectiondata() async {
    await FirebaseFirestore.instance.collection('時間外拒否').doc().set({
      '月':offhourData['month'],
      '日':offhourData['day'],
      '開始時':offhourData['hour'],
      '開始分':offhourData['minute'],
      '終了時':offhourData['_hour'],
      '終了分':offhourData['_minute'],
      '理由':offhourData['thepurpose'],
      '場所':offhourData['offhourswokplace'],
    });
  }

  @override
  Widget build(BuildContext context,WidgetRef ref){
    return Scaffold(
      appBar: AppBar(
        title: Text('時間外申請承認ページ',style: Textstyle.titlesize),
        backgroundColor: ColorModel.green,
      ),
      body: Column(
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
                      onPressed: () async {
                        await FirebaseFirestore.instance.collection('時間外申請').doc(offhourData.id).delete();
                        approvaldata();
                      },
                      child: const Text('承  認',style: TextStyle(fontSize: 20),),
                  ),),
                  SizedBox(
                    width: 170,
                    child:ElevatedButton(
                      onPressed: () async {
                        await FirebaseFirestore.instance.collection('時間外申請').doc(offhourData.id).delete();
                        rejectiondata();
                      },
                      child: const Text('拒  否',style: TextStyle(fontSize: 20),),
                  ),),
                ],
              )
            ],
          ),
        );
  }
}

SizedBox Sizebox = const SizedBox(height: 10);
