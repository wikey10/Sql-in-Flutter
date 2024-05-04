import 'package:flutter/material.dart';
import 'package:sqlapp/model/user.dart';
import 'package:sqlapp/pages/add_page.dart';
import 'package:sqlapp/pages/edit_page.dart';
import 'package:sqlapp/pages/view_user.dart';
import 'package:sqlapp/service/user_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

late List<User>  userlist = <User>[];
final userService = UserService();

getUserAllDetails()async{
  var users = await userService.readUser();
 userlist = <User>[];
  users.forEach((user){
   setState(() {
     var usermodel = User();
     usermodel.name = user['name'];
     usermodel.id   = user['id'];
     usermodel.contact = user['contact'];
     usermodel.description = user['description'];
     userlist.add(usermodel);
   });
  });
}

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserAllDetails();
  }

  showSuccessSnackBar(String message){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message,),));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SQL IN Flutter",style: TextStyle(
          color: Colors.white
        ),),
        backgroundColor: Colors.red,
      ),
      body: ListView.builder(
          itemCount: userlist.length,
          itemBuilder: (context,i){
            return Card(
              child: ListTile(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder:(context)=>ViewUser(user: userlist[i],)));
                },
                leading: const Icon(Icons.person),
                title: Text(userlist[i].name.toString(),style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black
                ),),
                subtitle: Text(userlist[i].contact.toString(),style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black
                ),),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    IconButton(onPressed: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>EditPage(user: userlist[i]))).then((data){
                        if(data!=null){
                          getUserAllDetails();
                          showSuccessSnackBar("User Details Updated Successfully");
                        }

                      } );
                    }, icon: const Icon(Icons.edit,color: Colors.green,)),
                    IconButton(onPressed: ()async{
                     _deleteFormDialog(context, userlist[i].id);
                    }, icon: const Icon(Icons.delete,color: Colors.red,)),
                  ],
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddPage())).then((data){
            if(data!=null){
              getUserAllDetails();
              showSuccessSnackBar("User Details added Successfully");
            }
            
          } );
        },
        child:const Icon(Icons.add),
      ),
    );
  }

_deleteFormDialog(BuildContext context, userId) {
  return showDialog(
      context: context,
      builder: (param) {
        return AlertDialog(
          title: const Text(
            'Are You Sure to Delete',
            style: TextStyle(color: Colors.teal, fontSize: 20),
          ),
          actions: [
            TextButton(
                style: TextButton.styleFrom(
                    foregroundColor: Colors.white, // foreground
                    backgroundColor: Colors.red),
                onPressed: ()  async{
                  var result=await userService.deleteUser(userId);
                  if (result != null) {
                    Navigator.pop(context);
                    getUserAllDetails();
                    showSuccessSnackBar(
                        'User Detail Deleted Success');
                  }
                },
                child: const Text('Delete')),
            TextButton(
                style: TextButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.teal),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Close'))
          ],
        );
      });
}
}
