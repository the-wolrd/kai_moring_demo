import 'package:demo_kai_morning_210303/model/order_model.dart';
import 'package:demo_kai_morning_210303/model/user_model.dart';
import 'package:demo_kai_morning_210303/network/order_network_func.dart';
import 'package:demo_kai_morning_210303/network/user_network_func.dart';
import 'package:demo_kai_morning_210303/widgets/my_progress_indicator.dart';
import 'package:demo_kai_morning_210303/widgets/order_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShowUserList extends StatefulWidget {
  @override
  _ShowUserListState createState() => _ShowUserListState();
}

class _ShowUserListState extends State<ShowUserList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamProvider<List<UserModel>>.value(
        value: userNetwork.getUsers(),
        child: Consumer<List<UserModel>>(
          builder: (context, users, _){
            if(users == null){
              return MyProgressIndicator();
            }
            else if (users.isEmpty){
              return Text('사용자가 없습니다.');
            }
            else{
              return ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index){
                  return InkWell(
                    onTap: () async {
                      String result = await showDialog(
                        context: context,
                        barrierDismissible: false, // user must tap button!
                        builder: (BuildContext context) {
                          TextEditingController _aa = TextEditingController();
                          _aa.text = users[index].userNickname;
                          return AlertDialog(
                            title: Text('AlertDialog Demo'),
                            content: TextField(
                              controller: _aa,
                            ),
                            actions: <Widget>[
                              FlatButton(
                                child: Text('OK'),
                                onPressed: () {
                                  Navigator.pop(context, _aa.text);
                                },
                              ),
                              FlatButton(
                                child: Text('Cancel'),
                                onPressed: () {
                                  Navigator.pop(context, users[index].userNickname);
                                },
                              ),
                            ],
                          );
                        },
                      );
                      await userNetwork.updateUserNik(userNickName: result, userKey: users[index].userKey);
                    },
                    child: Column(
                      children: [
                        Text(
                          users[index].userNickname
                        ),
                        Text(
                          users[index].userDest
                        ),
                        Text(
                          users[index].userPhone
                        ),
                        Divider(thickness: 3),
                      ],
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
