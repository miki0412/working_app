import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:working_app/style.dart';
import 'package:working_app/pages/employee_pages/custom_drawer.dart';
import 'package:working_app/pages/employee_pages/dialyreport_page.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class TopPage extends HookConsumerWidget {
  TopPage({super.key});

  double temperature = 0;
  int humidity = 0;
  final NumberFormat num = NumberFormat('#.#');
  final DateFormat date = DateFormat('yyyy年MM月dd日');
  final DateFormat time = DateFormat('HH:mm:ss');
  
  final weatherProvider = FutureProvider((ref) async{
    var apiKey = '';
    var city = 'Myoko';
    var lang = 'ja';
    var url = Uri.parse('http://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&lang=$lang');
    var response = await http.get(url);

    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      var weather = data['weather'][0];
      var main = data['main'];

      return {
        'weatherDescription' : weather['description'],
        'temperature' : main['temp'],
        'humidity' : main['humidity'],
      };
    }else{
      throw Exception('リクエストが失敗しました。ステータスコード${response.statusCode}');
    }
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weathers = ref.watch(weatherProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('トップページ',style: Textstyle.titlesize),
        backgroundColor: ColorModel.green,
      ),
      endDrawer: CustomDrawer(),
      body: SingleChildScrollView(child:Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                '山田太郎　ログイン日時${date.format(DateTime.now())}${time.format(DateTime.now())}'),
            Row(children:[const Text('今日の天気　'),
            weathers.when(
              loading: () => const CircularProgressIndicator(),
              error: (error,stackTrack) => const Text('読み取りに失敗しました'),
              data: (data) => Row(
                children: [
                  Text('天気 : ${data['weatherDescription']}'),
                  Text(' 温度 : ${num.format(data['temperature']-273.15)}℃'),
                  Text(' 湿度 : ${num.format(data['humidity'])}％'),
                ],
              ),
            ),],),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 150, bottom: 50),
              child: Column(
                children: [
                  Text(
                    date.format(DateTime.now()),
                    style: const TextStyle(fontSize: 40),
                  ),
                  Text(
                    time.format(DateTime.now()),
                    style: const TextStyle(fontSize: 40),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child:ElevatedButton(
                  onPressed: () {},
                  child: const Text('出勤'),
                ),),
                const SizedBox(width: 40),
                Expanded(child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('退勤'),
                ),),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DialyreportPage()));
                },
                child: const Text('日報入力ページへ'),
              ),
            ),
          ],
        ),
      ),),
    );
  }
}
