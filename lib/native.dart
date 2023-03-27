import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:test_drift/database.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

MyDatabase constructDb(){
  final db=LazyDatabase(()async{
    final dbFolder=await getApplicationDocumentsDirectory();
    final file =File(p.join(dbFolder.path,'mydb.db'));
    print('=====file==>$file');
    return NativeDatabase(file);
  });
  return MyDatabase(db);
}