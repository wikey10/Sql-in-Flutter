import 'package:sqlapp/database/repository.dart';
import 'package:sqlapp/model/user.dart';

class UserService{

  late Repository repository;

  UserService(){
    repository =Repository();
  }

  //SAVEUSER

  saveUser(User user) async{
    return await repository.insertData("users", user.userMap());
  }

  //READ ALL USER
  readUser() async{
    return await repository.readData("users");
  }

  //UpdateUser
  updateUser(User user) async{
    return await repository.updateData("users", user.userMap());
  }

  //DeleteUser
  deleteUser(int id) async{
    return await repository.deleteDatabyID('users',  id);
  }

}