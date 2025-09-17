import 'package:flutter/material.dart';
import 'item.dart';

class ItemProvider extends ChangeNotifier {
  final List<Item> itemList = [];

  void add(Item item){
    itemList.add(item);
    notifyListeners();
  }
}