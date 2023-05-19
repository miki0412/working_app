import 'package:flutter/material.dart';

class NavigationProvider extends ChangeNotifier{
  String currentPage = '';

  void NavigatePage(String page){
    currentPage = page;
    notifyListeners();
  }
}