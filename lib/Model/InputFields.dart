import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class InputField {
  int id;
  String name;
  String item_name;
  double grosswt;
  double netwt;
  String purity;
  String remark;
  int certificate_no;
  Uint8List img;
  String huid;
  InputField(
      {this.id,
      @required this.name,
      @required this.item_name,
      @required this.grosswt,
      @required this.netwt,
      @required this.purity,
      this.remark,
      @required this.certificate_no,
      this.img,
      this.huid});
  String tostring(){
    String ls='${this.id} ,${this.certificate_no} , ${this.name}';
    return ls;
  }
}

@Entity()
class ItemName{
  int id;
  String item_name;
  ItemName({this.id,@required this.item_name,});
}
