import 'package:drift/drift.dart';
import 'package:test_drift/table.dart';
part 'database.g.dart';



@DriftDatabase(
  tables: [
    Employee
  ]
)
class MyDatabase extends _$MyDatabase{
  MyDatabase(QueryExecutor e):super(e);

  @override
  int get schemaVersion=>1;
}