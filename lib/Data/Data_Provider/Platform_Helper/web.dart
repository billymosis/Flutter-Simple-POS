import 'package:moor/moor.dart';
import 'package:moor/moor_web.dart';
import 'package:project_pos/Data/Data_Provider/database.dart';

SharedDatabase constructDb({bool logStatements = false}) {
  final db = LazyDatabase(() async {
    return WebDatabase('app', logStatements: false);
  });
  return SharedDatabase(db);
}
