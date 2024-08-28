
import 'dart:core';

import 'package:hive_flutter/hive_flutter.dart';

class LocalDatabase {
  LocalDatabase._();
  static final LocalDatabase _instance = LocalDatabase._();
  factory LocalDatabase() => _instance;

  static Box? _box;
  Future<Box> get box async{
    if(_box != null && _box!.isOpen){
      return _box!;
    } else {

      await Hive.initFlutter();
      _box = await Hive.openBox('cartBox');
      return _box!;
    }
  }
  
  Future<void> add(List<dynamic> value) async {
    final box = await this.box;
    for(Map<String , dynamic> element in value){
    await box.add(element);
    }
  }

  Future<List<Map<String, dynamic>>> getAllValues() async{
    final box = await this.box;
    final values = box.values.toList();
    List<Map<String, dynamic>> finalValues = [];
    Map<String, dynamic> mapValue ={};
    for(Map<dynamic, dynamic>value in values){
      mapValue = convertMap(value);
      finalValues.add(mapValue);
    }
    return finalValues; 
  }

  Future<void> clear() async{
    final box = await this.box;
    await box.clear();
  }

  Future<void> close() async{
    final box = await this.box;
    await box.close();
  }

  Map<String, dynamic>  convertMap(Map<dynamic, dynamic> dynamicMap){
    final Map<String, dynamic> stringMap={};

    dynamicMap.forEach((key, value ){
      String stringKey = key as String;
      if(value is Map){
        stringMap[stringKey] = convertMap(value);
      } else if(value is List){
        stringMap[stringKey] = value.map((element) {
          if(element is Map){
            return convertMap(element);
          } else {
            return element;
          } 
        }).toList();
      } else {
        stringMap[stringKey] = value;
      }

    });
    return stringMap;
  }

  
}