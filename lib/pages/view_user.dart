import 'package:flutter/material.dart';
import 'package:sqlapp/model/user.dart';

class ViewUser extends StatefulWidget {
  final User user;
  ViewUser({Key? key,required this.user}): super(key: key);



  @override
  State<ViewUser> createState() => _ViewUserState();
}

class _ViewUserState extends State<ViewUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:   AppBar(
        backgroundColor: Colors.red,
        title: Text("View User"),
      ),
      body: Column(

        children: [
          Container(
            padding:  EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Full Details",style: TextStyle(
                    color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),),
                const SizedBox(
                  height: 20,
                ),
                Row(

                  children: [
                    const Text("Name:",style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      fontWeight: FontWeight.w600
                    ),),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(widget.user.name ??"".toString(),style: const TextStyle(
                      color: Colors.black,
                        fontSize: 18
                    ),),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(

                  children: [
                    const Text("Contact:",style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600
                    ),),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(widget.user.contact ??"".toString(),style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18
                    ),),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                 Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Description",style: TextStyle(
                color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600
                ),),
                    Text(widget.user.description ??"".toString(),style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18
                    ),),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
