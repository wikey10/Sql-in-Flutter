import 'package:flutter/material.dart';
import 'package:sqlapp/model/user.dart';
import 'package:sqlapp/service/user_service.dart';

class EditPage extends StatefulWidget {
  final User user;
  const EditPage({super.key, required this.user});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {

  var name_controller = TextEditingController();
  var contact_controller = TextEditingController();
  var description_controller = TextEditingController();

  final userService= UserService ();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      name_controller.text = widget.user.name??"";
      contact_controller.text = widget.user.contact??"";
      description_controller.text = widget.user.description??"";
    });
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text("Edit New User"),
      ),
      body: SingleChildScrollView(
        padding:  const EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment:CrossAxisAlignment.start,
            children: [
              const Text("Edit New User",style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold
              ),),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: name_controller,
                decoration:  const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter Name",
                    labelText: "Name"
                ),
                validator: (value){
                  if(value!.isEmpty){
                    return "Name required";
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: contact_controller,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter Contact",
                    labelText: "Contact"
                ),
                validator: (value){
                  if(value!.isEmpty){
                    return "Contact required";
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: description_controller,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter Description",
                    labelText: "Description"
                ),
                validator: (value){
                  if(value!.isEmpty){
                    return "Description required";
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Row(

                children: [
                  TextButton(
                      style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.green
                      ),
                      onPressed: ()async{
                        if(_formKey.currentState!.validate()){
                          var _users = User();
                          _users.id = widget.user.id;
                          _users.name = name_controller.text;
                          _users.contact = contact_controller.text;
                          _users.description = description_controller.text;
                          var result = await userService.updateUser(_users);
                          print("result_+++$result");
                          Navigator.pop(context,result);
                        }
                      }, child: const Text("Update Details")),
                  const SizedBox(
                    width: 10,
                  ),
                  TextButton(
                      style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.red
                      ),
                      onPressed: (){
                        name_controller.clear();
                        contact_controller.clear();
                        description_controller.clear();
                      }, child: const Text("Delete Details")),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
