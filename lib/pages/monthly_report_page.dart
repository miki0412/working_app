import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:working_app/model.dart';
import 'package:working_app/pages/custom_drawer.dart';
import 'package:intl/intl.dart';

class MonthlyReportPage extends HookConsumerWidget{
  MonthlyReportPage ({super.key});

  @override
  DateFormat monthformat = DateFormat('M');
  DateTime month = DateTime.now();
  Widget build(BuildContext context,WidgetRef ref){
    return Scaffold(
      appBar: const appbarmodel(title: '月報'),
      endDrawer: const CustomDrawer(),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${monthformat.format(month)}月月報',style: textstyle.titlesize),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child:DataTable(
                  columnSpacing: 0,
                  columns: const [
                    DataColumn(label:Text('月'),),
                    DataColumn(label:Text('日'), ),
                    DataColumn(label: Text('曜日'),),
                    DataColumn(label: Text('区分'),),
                    DataColumn(label: Text('業務内容'),),
                  ],
                  rows: const[
                    DataRow(cells: [
                      DataCell(Text('４'),),
                      DataCell(Text('１６'),),
                      DataCell(Text('日'),),
                      DataCell(Text('休日出勤'),),
                      DataCell(Text('現場管理'),),
                    ],),
                    DataRow(cells: [
                      DataCell(Text('４'),),
                      DataCell(Text('１７'),),
                      DataCell(Text('月'),),
                      DataCell(Text('出勤'),),
                      DataCell(Text('現場管理'),),
                    ],),
                    DataRow(cells: [
                      DataCell(Text('４'),),
                      DataCell(Text('１８'),),
                      DataCell(Text('火'),),
                      DataCell(Text('出勤'),),
                      DataCell(Text('現場管理'),),
                    ],),
                  ]
              ),),
            ],
          ),
        ),
      ),
    );
  }
}

// class MonthlyReportPage extends HookConsumerWidget{
//   MonthlyReportPage ({super.key});
//
//   final Stream<QuerySnapshot> _userStream = FirebaseFirestore.instance.collection('有給休暇申請').snapshots();
//
//   @override
//   Widget build(BuildContext context,WidgetRef ref){
//     return Scaffold(
//       appBar: const appbarmodel(title: '月報'),
//       endDrawer: const CustomDrawer(),
//       body: SingleChildScrollView(
//         child: Container(
//           margin: const EdgeInsets.only(top: 10,right: 10,left: 10),
//           child: Column(
//             children: [
//               StreamBuilder<QuerySnapshot>(
//                   stream: _userStream,
//                   builder: (context, snapshot) {
//                     if (snapshot.hasData) {
//                       List<DocumentSnapshot> usersData = snapshot.data!.docs;
//                       return ListView.separated(
//                         shrinkWrap: true,
//                         separatorBuilder: (BuildContext context,
//                             int index) => const Divider(),
//                         itemBuilder: (BuildContext context, int index) {
//                           Map<String, dynamic> userData = usersData[index]
//                               .data()! as Map<String, dynamic>;
//                           return Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children:[
//                                 Row(
//                                   children: [
//                                     Text('${userData['_month']}月',style: textstyle.titlesize),
//                                     Text('${userData['_day']}日',style: textstyle.titlesize),
//                                     const Text('〜'),
//                                     Text('${userData['month']}月',style: textstyle.titlesize),
//                                     Text('${userData['day']}日',style: textstyle.titlesize),
//                               ],
//                             ),
//                               Text('${userData['thepurpose']}',style: const TextStyle(fontSize: 20),),],
//                           );
//                         },
//                         itemCount: usersData.length,
//                       );
//                     } else {
//                       return const Center(child:Text('データがありません'),);
//                     }
//                   }
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
