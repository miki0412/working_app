import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:working_app/pages/employee_pages/custom_drawer.dart';
import 'package:working_app/style.dart';

class PaymentRecordPage extends HookConsumerWidget {
  PaymentRecordPage({super.key});

  final TextEditingController vendor = TextEditingController();
  final TextEditingController budget = TextEditingController();

  void addbudgetdata() async {
    await FirebaseFirestore.instance.collection('予算').doc().set({
      '業者名': vendor.text,
      '予算': budget.text,
    });
  }

  final Stream<QuerySnapshot> _budgetStream =
      FirebaseFirestore.instance.collection('予算').snapshots();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('支払調書', style: Textstyle.titlesize),
        backgroundColor: ColorModel.green,
      ),
      endDrawer: CustomDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('予算入力フォーム'),
                  content: SizedBox(
                    height: 250,
                    child: Column(
                      children: [
                        TextField(
                          controller: vendor,
                          decoration: const InputDecoration(
                            hintText: '業者名',
                          ),
                        ),
                        TextField(
                          controller: budget,
                          inputFormatters: [MoneyInputFormatter()],
                          decoration: const InputDecoration(hintText: '予算'),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              addbudgetdata();
                              vendor.clear();
                              budget.clear();
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('登録しました'),
                                  backgroundColor: Colors.blue,
                                ),
                              );
                            },
                            child: const Text('追加')),
                      ],
                    ),
                  ),
                );
              });
        },
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
          child:Column(
          children: [
            Row(
              children: [
                Text('工事名', style: Textstyle.titlesize),
                const SizedBox(width: 39),
                Text('A様邸新築工事', style: Textstyle.titlesize),
              ],
            ),
            Row(
              children: [
                Text('担当者', style: Textstyle.titlesize),
                const SizedBox(width: 39),
                Text('妙高花子', style: Textstyle.titlesize),
              ],
            ),
            Row(
              children: [
                Text('請負金額', style: Textstyle.titlesize),
                const SizedBox(width: 20),
                Text('¥45,000,000', style: Textstyle.titlesize),
              ],
            ),
            Row(
              children: [
                Text('実行予算', style: Textstyle.titlesize),
                const SizedBox(width: 20),
                Text('¥38,000,000', style: Textstyle.titlesize),
              ],
            ),
            StreamBuilder<QuerySnapshot>(
              stream: _budgetStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Text('データ取得中にエラーが発生しました');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                List<DocumentSnapshot> budgetData = snapshot.data!.docs;
                return SizedBox(width:double.infinity,child:DataTable(
                  columns: const [
                    DataColumn(label: Text('業者名')),
                    DataColumn(label: Text('予算')),
                    DataColumn(label: Text('')),
                  ],
                  rows: budgetData.asMap().entries.map((entry) {
                    final index = entry.key;
                    final document = entry.value;
                    final data = document.data();
                    final color =
                        index % 2 == 0 ? Colors.grey[200]! : Colors.white;

                    return DataRow(
                        color: MaterialStateColor.resolveWith(
                            (Set<MaterialState> states) {
                          return color;
                        }),
                        cells: [
                          DataCell(Text(
                              (data as Map<String, dynamic>)['業者名'] ?? '')),
                          DataCell(
                              Text((data as Map<String, dynamic>)['予算'] ?? '')),
                          DataCell(
                            IconButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('本当に削除しますか？'),
                                        actions: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: ElevatedButton(
                                                    onPressed: () async {
                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection('予算')
                                                          .doc(budgetData[index]
                                                              .id)
                                                          .delete();
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text('はい')),
                                              ),
                                              const SizedBox(width: 10),
                                              Expanded(
                                                  child: ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text('いいえ')))
                                            ],
                                          )
                                        ],
                                      );
                                    });
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Color(0xFFD3D3D3),
                              ),
                            ),
                          ),
                        ]);
                  }).toList(),
                ),);
              },
            ),
          ],
          ),),
      ),
    );
  }
}
