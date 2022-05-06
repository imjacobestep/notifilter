import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'dart:math';

class Utility{

  static Image imgFromString(String str){
    return Image.memory(
      base64Decode(str),
      fit: BoxFit.fill,
    );
  }

  static Uint8List dataFromString(String str){
    return base64Decode(str);
  }

  static String imgToString(Uint8List data){
    return base64Encode(data);
  }

}

int boolToInt(bool b){
  if(b){
    return 1;
  }else{
    return 0;
  }
}

bool intToBool(int n){
  if(n == 1){
    return true;
  }else{
    return false;
  }
}

int randomInt(){
  var random = Random();
  return random.nextInt(200000000);
}

class Photo{
  int id;
  String photo_name;

  Photo(this.id, this.photo_name);

  Map<String, dynamic> toMap(){
    var map = <String, dynamic>{
      'id': id,
      'photo_name': photo_name,
    };
    return map;
  }

  Photo.fromMap(Map<String, dynamic> map){
    id = map['id'];
    photo_name = map['photo_name'];
  }

}