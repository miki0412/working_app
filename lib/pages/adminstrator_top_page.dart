import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:working_app/model.dart';
import 'package:working_app/pages/adminstrator_custom_drawer.dart';

class AdminstratorTopPage extends HookConsumerWidget {
  const AdminstratorTopPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const appbarmodel(
        title: 'トップページ（管理者）',
      ),
      endDrawer: const AdminstratorCustomDrawer(),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 10, right: 10, left: 10),
        ),
      ),
    );
  }
}
