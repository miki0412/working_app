import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:working_app/style.dart';
import 'package:working_app/pages/administrator_pages/adminstrator_custom_drawer.dart';
import 'package:working_app/pages/administrator_pages/businesstripapplication_list.dart';
import 'package:working_app/pages/administrator_pages/constructionregistration_list.dart';
import 'package:working_app/pages/administrator_pages/holidayworkapplications_list.dart';
import 'package:working_app/pages/administrator_pages/paidleaveapplication_list.dart';
import 'package:working_app/pages/administrator_pages/offhoursapplication_list.dart';
import 'package:working_app/pages/administrator_pages/substituteholidayapplications_list.dart';

class AdminstratorTopPage extends HookConsumerWidget {
  AdminstratorTopPage({super.key});

  final offhourscountProvider = StreamProvider.autoDispose<int>((ref) async*{
    final snapshot = await FirebaseFirestore.instance.collection('時間外申請').get();
    yield snapshot.size;
  });
  final holidayworkcountProvider = StreamProvider.autoDispose<int>((ref) async*{
    final snapshot = await FirebaseFirestore.instance.collection('休日出勤申請').get();
    yield snapshot.size;
  });
  final paidleavecountProvider = StreamProvider.autoDispose<int>((ref) async*{
    final snapshot = await FirebaseFirestore.instance.collection('有給休暇申請').get();
    yield snapshot.size;
  });
  final substituteholidaycountProvider = StreamProvider.autoDispose<int>((ref) async*{
    final snapshot = await FirebaseFirestore.instance.collection('振替休日申請').get();
    yield snapshot.size;
  });
  final businesstripcountProvider = StreamProvider.autoDispose<int>((ref) async*{
    final snapshot = await FirebaseFirestore.instance.collection('有給休暇申請').get();
    yield snapshot.size;
  });
  final constructioncountProvider = StreamProvider.autoDispose<int>((ref) async*{
    final snapshot = await FirebaseFirestore.instance.collection('工事登録').get();
    yield snapshot.size;
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<int> offhourscount = ref.watch(offhourscountProvider);
    final AsyncValue<int> holidayworkcount = ref.watch(holidayworkcountProvider);
    final AsyncValue<int> paidleavecount = ref.watch(paidleavecountProvider);
    final AsyncValue<int> substituteholidaycount = ref.watch(substituteholidaycountProvider);
    final AsyncValue<int> businesstripcount = ref.watch(businesstripcountProvider);
    final AsyncValue<int> constructioncount = ref.watch(constructioncountProvider);
    //StreamProviderから取得されたデータは非同期データの１種でありそのまま取得したデータをTextとして表出するとAsyncData<int>(value: 3)と表出されるため.valueなどでデータのみを取り出す必要がある
    return Scaffold(
      appBar: AppBar(
        title: Text('トップページ',style: Textstyle.titlesize),
        backgroundColor: ColorModel.green,
      ),
      endDrawer: AdminstratorCustomDrawer(),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 10, right: 10, left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('各種申請が届いています。\n通知がある場合は必ず確認し、承認を行なってください。'),
              const SizedBox(height: 15),
              RowModel(
                  titles: '時間外申請',
                  pages: OffhoursapplicationList(),
                  countnum: offhourscount,
              ),
              RowModel(
                  titles: '休日出勤申請',
                  pages: HolidayworkapplicationsList(),
                  countnum: holidayworkcount,
              ),
              RowModel(
                  titles: '有給休暇申請',
                  pages: PaidleaveapplicationList(),
                  countnum: paidleavecount,
              ),
              RowModel(
                  titles: '振替休日申請',
                  pages: SubstituteapplicationList(),
                  countnum: substituteholidaycount,
              ),
              RowModel(
                  titles: '出張申請',
                  pages: BusinesstripapplicationList(),
                  countnum: businesstripcount,
              ),
              RowModel(
                titles: '工事登録申請',
                pages: ConstractionregistrationList(),
                countnum:constructioncount,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RowModel extends StatelessWidget {
  const RowModel({
    super.key,
    required this.titles,
    required this.pages,
    required this.countnum,
  });
  final String titles;
  final Widget pages;
  final AsyncValue<int> countnum;

  @override
  Widget build(BuildContext context){
    return Row(
      children: [
        Expanded(child: Text(titles,style: Textstyle.titlesize),),
        Expanded(child: TextButton(
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => pages));
            },
            child: Text('${countnum.value}  件',style: Textstyle.titlesize),
        ),),
      ],
    );
  }
}
