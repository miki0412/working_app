import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:working_app/style.dart';

class HolidayworkApplicationApproval extends HookConsumerWidget{
  HolidayworkApplicationApproval(this.holidayworkapplicationData);
  final DocumentSnapshot holidayworkapplicationData;
  
  @override
  Widget build(BuildContext context,WidgetRef ref){
    return Scaffold(
      appBar: AppBar(
        title: Text('休日出勤申請承認ページ',style: Textstyle.titlesize),
        backgroundColor: ColorModel.green,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 30,horizontal: 10),
        child: Column(
          children: [
            Row(
              children: [
                Text('日付　：　',style: Textstyle.titlesize),
                Text('${holidayworkapplicationData.get('month')}月${holidayworkapplicationData.get('day')}日',style: Textstyle.titlesize),
              ],
            ),
            Sizebox,
            Row(
              children: [
                Text('時間　：　',style: Textstyle.titlesize),
                Text('${holidayworkapplicationData.get('hour')}:${holidayworkapplicationData.get('minute')}〜${holidayworkapplicationData.get('_hour')}:${holidayworkapplicationData.get('_minute')}',style: Textstyle.titlesize),
              ],
            ),
            Sizebox,
            Row(
              children: [
                Text('場所　：　',style: Textstyle.titlesize),
                Text('${holidayworkapplicationData.get('holidayworkplace')}',style: Textstyle.titlesize),
              ],
            ),
            Sizebox,
            Row(
              children: [
                Text('理由　：　',style: Textstyle.titlesize),
                Text('${holidayworkapplicationData.get('thepurpose')}',style: Textstyle.titlesize),
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
            ),
          ],
        ),
      ),
    );
  }
}

SizedBox Sizebox = const SizedBox(height: 10);