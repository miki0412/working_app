import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:working_app/model.dart';
import 'package:working_app/pages/administrator_pages/adminstrator_custom_drawer.dart';

class ConstractionregistrationList extends HookConsumerWidget {
  ConstractionregistrationList({super.key});

  final Stream<QuerySnapshot> _constructionregistrationStream =
      FirebaseFirestore.instance.collection('工事登録').snapshots();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const appbarmodel(title: '工事登録申請一覧'),
      endDrawer: const AdminstratorCustomDrawer(),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: StreamBuilder<QuerySnapshot>(
            stream: _constructionregistrationStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<DocumentSnapshot> constractionregistrationsData =
                    snapshot.data!.docs;
                return ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    Map<String, dynamic> constractionregistrationData =
                        constractionregistrationsData[index].data()!
                            as Map<String, dynamic>;
                    return Expanded(
                      child: ListTile(
                        title: Text(
                            '工事名　${constractionregistrationData['工事名']}\n担当者　${constractionregistrationData['担当者名']}\n申請日　${constractionregistrationData['申請時間'].toDate().month}月${constractionregistrationData['申請時間'].toDate().day}日${constractionregistrationData['申請時間'].toDate().hour}時'),
                        onTap: () {},
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                  itemCount: constractionregistrationsData.length,
                );
              } else {
                return Center(
                  child: Text('未承認の申請はありません', style: textstyle.titlesize),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
