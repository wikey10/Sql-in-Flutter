import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DatabaseConnections{

  Future <Database> setDataBase() async{
    {
      var directory = await getApplicationDocumentsDirectory();
      var path = join(directory.path,'db_crud');
      var database = await openDatabase(path,version: 1,onCreate: _createDataBase);
      return database;
    }
  }

  Future <void> _createDataBase(Database database,int version) async{
    String sql = "CREATE TABLE users (id INTEGER PRIMARY KEY,name TEXT,contact TEXT,description TEXT);";
    await database.execute(sql);
  }

}