import 'package:demo_kai_morning_210303/constant/size.dart';
import 'package:demo_kai_morning_210303/model/store_model.dart';
import 'package:demo_kai_morning_210303/network/store_network_func.dart';
import 'package:demo_kai_morning_210303/useful/search_engine.dart';
import 'package:demo_kai_morning_210303/widgets/my_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DaySelectDialog extends StatefulWidget {

  final Function selDay;

  DaySelectDialog({this.selDay});

  @override
  _DaySelectDialogState createState() => _DaySelectDialogState();
}

class _DaySelectDialogState extends State<DaySelectDialog> {

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text('날짜 선택'),
        content: SizedBox(
          height: 150.0,
          width: size.width * 0.6,
          child: Column(
            children: [
              InkWell(
                  onTap: (){
                    widget.selDay(DateTime(2021,3,8));
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('21년 3월 8일'),
                  )),
              InkWell(
                  onTap: (){
                    widget.selDay(DateTime(2021,3,9));
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('21년 3월 9일'),
                  )),
              InkWell(
                  onTap: (){
                    widget.selDay(DateTime(2021,3,10));
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('21년 3월 10일'),
                  )),
              Text('구현 필요!', style:TextStyle(color: Colors.red, fontWeight: FontWeight.bold))
            ],
          )
        ));
  }
}
