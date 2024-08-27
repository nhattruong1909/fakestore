import 'package:fakestore/core/constants/constant.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

class LocalDatabase {
  LocalDatabase();

  static Box? _box;
  Future<Box> get box async{
    if(_box != null && _box!.isOpen){
      return _box!;
    } else {
      final dir_path=await getApplicationDocumentsDirectory();
      Hive.init(dir_path.path);
      _box = await Hive.openBox(Constant.localCartBoxName);
      return _box!;
    }
  }
  
  Future<void> put(String key, dynamic value) async {
    final box = await this.box;
    box.clear();
    await box.put(key, value);
  }

  Future<dynamic> getAllValues() async{
    final box = await this.box;
    
    final values = box.values.toList();
    return values;
  }
  
}