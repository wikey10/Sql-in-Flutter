import 'package:sqflite/sqflite.dart';
import 'package:sqlapp/database/database_connection.dart';


class Repository{

  late DatabaseConnections databaseConnections;

  Repository(){
    databaseConnections = DatabaseConnections();
  }

  static Database? databases;

  Future <Database?> get database async{
    if(databases!=null){
      return databases;
    }
    else{
      databases = await databaseConnections.setDataBase();
      return databases;
    }
  }

  //INSERT USER
 insertData(table,data) async{
    var connection = await database;
    return await connection?.insert(table, data);
 }

 //READ ALL USER

  readData(table) async{
    var connection = await database;
    return await connection?.query(table);
  }

  //Read specific record by id
  readDatabyID(table,userID) async{
    var connection = await database;
    return await connection?.query(table,where: 'id=?',whereArgs: [userID]);
  }

  //Update Data
  updateData(table,data) async{
    var connection = await database;
    return await connection?.update(table,data,where: 'id=?',whereArgs: [data['id']]);
  }

  //Delete Data
  deleteDatabyID(table,userID) async{
    var connection = await database;
    return await connection?.rawDelete("delete from $table where id=$userID");
  }




}