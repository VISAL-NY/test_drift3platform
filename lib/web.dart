import 'package:drift/web.dart';
import 'package:test_drift/database.dart';


MyDatabase constructDb(){
 var db=WebDatabase('mydb.db');
 print('=====.db==>$db');
 return MyDatabase(db);


}
