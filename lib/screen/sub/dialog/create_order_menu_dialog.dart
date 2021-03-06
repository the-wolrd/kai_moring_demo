import 'package:demo_kai_morning_210303/constant/size.dart';
import 'package:demo_kai_morning_210303/model/store_model.dart';
import 'package:demo_kai_morning_210303/network/store_network_func.dart';
import 'package:demo_kai_morning_210303/useful/search_engine.dart';
import 'package:demo_kai_morning_210303/widgets/my_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuSelectDialog extends StatefulWidget {

  final Function selMenu;
  final Function nextFunc;

  MenuSelectDialog({this.selMenu, this.nextFunc});

  @override
  _MenuSelectDialogState createState() => _MenuSelectDialogState();
}

class _MenuSelectDialogState extends State<MenuSelectDialog> {

  TextEditingController _menuController = TextEditingController();

  @override
  void dispose() {
    _menuController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text('메뉴 선정(임시)'),
        content: TextField(
          controller: _menuController,
        ),
        actions: [
          FlatButton(
            child: Text(
              '선택',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {
              widget.selMenu(_menuController.text);
              Navigator.pop(context);
              widget.nextFunc();
            },
          ),
          FlatButton(
            child: Text('취소',
                style: TextStyle(color: Colors.black87)),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ]);
  }
}
