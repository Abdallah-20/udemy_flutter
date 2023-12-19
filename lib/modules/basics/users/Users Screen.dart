import 'package:flutter/material.dart';
import 'package:udemy_flutter/models/user/user_model.dart';


class UsersScreen extends StatelessWidget {
  List<UserModel> Users = [
    UserModel(iD: 1, name: "Abdallah ", phone: "01226969662"),
    UserModel(iD: 2, name: "Ahmed ", phone: "01226969662"),
    UserModel(iD: 3, name: "Mohamed ", phone: "01226969662"),
    UserModel(iD: 4, name: "Ali ", phone: "01226969662"),
    UserModel(iD: 5, name: "Ziyad ", phone: "01226969662"),
    UserModel(iD: 1, name: "Abdallah ", phone: "01226969662"),
    UserModel(iD: 2, name: "Ahmed ", phone: "01226969662"),
    UserModel(iD: 3, name: "Mohamed ", phone: "01226969662"),
    UserModel(iD: 4, name: "Ali ", phone: "01226969662"),
    UserModel(iD: 5, name: "Ziyad ", phone: "01226969662"),
    UserModel(iD: 1, name: "Abdallah ", phone: "01226969662"),
    UserModel(iD: 2, name: "Ahmed ", phone: "01226969662"),
    UserModel(iD: 3, name: "Mohamed ", phone: "01226969662"),
    UserModel(iD: 4, name: "Ali ", phone: "01226969662"),
    UserModel(iD: 5, name: "Ziyad ", phone: "01226969662"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Users',
          style: TextStyle(
            fontSize: 30,
            // color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) => buildUserItem(Users[index]),
          separatorBuilder: (context, index) => Padding(
                padding: const EdgeInsetsDirectional.only(
                  start: 12,
                ),
                child: Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.grey[300],
                ),
              ),
          itemCount: Users.length),
    );
  }

  Widget buildUserItem(UserModel user) => Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25.0,
              child: Text(
                "${user.iD}",
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                Text(
                  user.phone,
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
}
