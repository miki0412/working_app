import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:working_app/model.dart';
import 'package:working_app/pages/employee_pages/custom_drawer.dart';

class ConstructionRegistrationPage extends HookConsumerWidget {
  ConstructionRegistrationPage({super.key});

  void constructionadd() async{
    await FirebaseFirestore.instance.collection('工事登録').doc().set({
      '工事名':constructionname.text,
      '工事場所':adress.text,
      '開始':start.text,
      '完了':end.text,
      '担当者名':name.text,
      '契約金額':moneyformat.format(int.parse(contractamount.text),),
      '実行予算':moneyformat.format(int.parse(budget.text),),
      '申請時間':DateTime.now(),
    });
  }

  final TextEditingController constructionname = TextEditingController();
  final TextEditingController adress = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController start = TextEditingController();
  final TextEditingController end = TextEditingController();
  final TextEditingController contractamount = TextEditingController();
  final TextEditingController budget = TextEditingController();

  final moneyformat = NumberFormat('#,###');


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final widthsize = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      appBar: const appbarmodel(title: '工事登録ページ'),
      endDrawer: const CustomDrawer(),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('・工事が発生したら必ず登録をおこなって下さい'),
              const Text('・部長が決済後一覧へ登録され選択可能になります'),
              Text('（注意事項）\n金額等確定していなくても稼働した場合は必ず登録し、金額が確定次第一覧より編集して下さい',style: TextStyle(color: ColorModel.red),),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                width: widthsize,
                decoration: BoxDecoration(
                  border: Border.all(color: ColorModel.primary),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextFormField(
                  controller: constructionname,
                  decoration: const InputDecoration(
                      hintText: '工事名を入力して下さい',
                  ),
                ),),
              sizebox,
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                width: widthsize,
                decoration: BoxDecoration(
                  border: Border.all(color: ColorModel.primary),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextFormField(
                  controller: adress,
                  decoration: const InputDecoration(
                    hintText: '工事場所を入力して下さい',
                  ),
                ),),
              sizebox,
              Row(
                children:[
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    width: 180,
                    decoration: BoxDecoration(
                      border: Border.all(color: ColorModel.primary),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextFormField(
                      controller: start,
                      decoration: const InputDecoration(
                        hintText: '開始日 年/月/日',
                      ),
                    ),),
                  const SizedBox(width: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    width: 180,
                    decoration: BoxDecoration(
                      border: Border.all(color: ColorModel.primary),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextFormField(
                      controller: end,
                      decoration: const InputDecoration(
                        hintText: '完了日 年/月/日',
                      ),
                    ),),
                ],
              ),
              sizebox,
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                width: widthsize,
                decoration: BoxDecoration(
                  border: Border.all(color: ColorModel.primary),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextFormField(
                  controller: name,
                  decoration: const InputDecoration(
                    hintText: '担当者名を入力して下さい',
                  ),
                ),),
              sizebox,
              Row(
                children: [
                  const Text('¥',style: TextStyle(fontSize: 20),),
                  Expanded(child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    width: widthsize,
                    decoration: BoxDecoration(
                      border: Border.all(color: ColorModel.primary),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextFormField(
                      controller: contractamount,
                      decoration: const InputDecoration(
                        hintText: '契約金額を入力して下さい',
                      ),
                    ),),),
                ],
              ),
              sizebox,
              Row(
                children: [
                  const Text('¥',style: TextStyle(fontSize: 20),),
                  Expanded(child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    width: widthsize,
                    decoration: BoxDecoration(
                      border: Border.all(color: ColorModel.primary),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextFormField(
                      controller: budget,
                      decoration: const InputDecoration(
                        hintText: '実行予算を入力して下さい',
                      ),
                    ),),),
                ],
              ),
              sizebox,
              SizedBox(
                width: widthsize,
                child:ElevatedButton(
                  onPressed: (){constructionadd();},
                  child: const Text('追加'),
              ),),
            ],
          ),
        ),
      ),
    );
  }
}

SizedBox sizebox = const SizedBox(height: 20);