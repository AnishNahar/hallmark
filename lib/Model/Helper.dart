import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hallmarkcardgenerator/Model/InputFields.dart';
import 'package:hallmarkcardgenerator/objectbox.g.dart';
//import 'package:intl/intl.dart';
import 'package:objectbox/objectbox.dart';

class ViewModel {
  Store store;
  Box<InputField> box;
  Box<ItemName> box_item_name;
  //late final Stream<Query<InputField>> _queryStream;

  ViewModel(Store storeArg) {
    this.store=storeArg;
    this.box = Box<InputField>(storeArg);
    this.box_item_name=Box<ItemName>(storeArg);
    print('ViewModel Constructor opened');
  }

  void addCard(InputField obj) {
    int a = box.put(obj);
    print(a);
  }
  void updateCard(InputField obj) {
    int a = box.put(obj,mode: PutMode.update);
    print(a);
  }
  void removeCard(InputField obj) => box.remove(obj.id);

  void removeManyCard(List<int> args){
    box.removeMany(args);
  }

  List<InputField> allItem() {
    return box.getAll();
  }

  List<ItemName> all_Item_Name(){
    return box_item_name.getAll();
  }
  void addItemName(ItemName itmname){
    int i=box_item_name.put(itmname);
    print(i);
  }
  void removeItemName(ItemName itm){
    box_item_name.remove(itm.id);
  }

  void dispose() {
    store.close();
    print('Store closed');
  }
}
