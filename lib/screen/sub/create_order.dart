import 'package:demo_kai_morning_210303/constant/firestore_keys.dart';
import 'package:demo_kai_morning_210303/model/camera_state.dart';
import 'package:demo_kai_morning_210303/model/store_model.dart';
import 'package:demo_kai_morning_210303/model/user_model.dart';
import 'package:demo_kai_morning_210303/network/order_network_func.dart';
import 'package:demo_kai_morning_210303/network/store_network_func.dart';
import 'package:demo_kai_morning_210303/network/user_network_func.dart';
import 'file:///C:/Users/asdf/Desktop/test/demo_kai_morning_210303/lib/screen/show_store_list.dart';
import 'package:demo_kai_morning_210303/useful/generate_key.dart';
import 'package:demo_kai_morning_210303/useful/search_engine.dart';
import 'package:demo_kai_morning_210303/widgets/my_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../constant/size.dart';
import '../../model/firebase_auth_state.dart';
import 'dialog/create_order_day_dialog.dart';
import 'dialog/create_order_menu_dialog.dart';
import 'dialog/create_order_store_dialog.dart';
import 'dialog/create_order_time_dialog.dart';
import 'dialog/create_order_user_dialog.dart';

class CreateOrderScreen extends StatefulWidget {
  @override
  _CreateOrderScreenState createState() => _CreateOrderScreenState();
}

class _CreateOrderScreenState extends State<CreateOrderScreen> {
  DateTime _daySelect = DateTime.now();
  String _timeSelect = '';
  String _storeSelect = '';
  String _menuSelect = '';
  String _ordererSelect = '';
  String _destSelect = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListView(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.directions_car,
                    size: 50.0,
                  ),
                  Text(
                    '신규 주문 등록',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Text('날짜'),
              SizedBox(
                height: 5.0,
              ),
              InkWell(
                  onTap: () async {
                    await showDialog(
                      context: context,
                      builder: (context) {
                        return DaySelectDialog(selDay: (DateTime dateTime) {
                          setState(() {
                            _daySelect = dateTime;
                          });
                        });
                      },
                    );
                  },
                  child: _showContainer(
                      '${DateFormat('yyyy-MM-dd').format(_daySelect)}')),
              SizedBox(
                height: 10.0,
              ),
              Text('시간'),
              SizedBox(
                height: 5.0,
              ),
              InkWell(
                onTap: () async {
                  await showDialog(
                    context: context,
                    builder: (context) {
                      return TimeSelectDialog(
                        selTime: (String selectedTime) {
                          setState(() {
                            _timeSelect = selectedTime;
                          });
                        },
                      );
                    },
                  );
                },
                child: _showContainer(_timeSelect),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text('가게'),
              SizedBox(
                height: 5.0,
              ),
              InkWell(
                  onTap: () async {
                    await showDialog(
                      context: context,
                      builder: (context) {
                        return StoreSelectDialog(selItem: (String selItem) {
                          setState(() {
                            _storeSelect = selItem;
                          });
                        });
                      },
                    );
                  },
                  child: _showContainer(_storeSelect)),
              SizedBox(
                height: 10.0,
              ),
              Text('메뉴'),
              SizedBox(
                height: 5.0,
              ),
              InkWell(
                  onTap: () async {
                    await showDialog(
                      context: context,
                      builder: (context) {
                        return MenuSelectDialog(
                          selMenu: (String selectedMenu) {
                            setState(() {
                              _menuSelect = selectedMenu;
                            });
                          },
                        );
                      },
                    );
                  },
                  child: _showContainer(_menuSelect)),
              SizedBox(
                height: 10.0,
              ),
              Text('주문자 선택'),
              SizedBox(
                height: 5.0,
              ),
              InkWell(
                  onTap: () async {
                    await showDialog(
                      context: context,
                      builder: (context) {
                        return UserSelectDialog(
                          selUser: (String selectedUser,
                              {String defaultDest = ''}) {
                            setState(() {
                              _ordererSelect = selectedUser;
                              _destSelect = defaultDest;
                            });
                          },
                        );
                      },
                    );
                  },
                  child: _showContainer(_ordererSelect)),
              SizedBox(
                height: 10.0,
              ),
              Text('수령지 선택'),
              SizedBox(
                height: 5.0,
              ),
              InkWell(
                  onTap: () async {
                    await showDialog(
                      context: context,
                      builder: (context) {
                        TextEditingController _destController =
                            TextEditingController();

                        return AlertDialog(
                            title: Text('수령지 변경'),
                            content: TextField(
                              controller: _destController,
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
                                  _destSelect = _destController.text;
                                  Navigator.pop(context);
                                  setState(() {});
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
                      },
                    );
                  },
                  child: _showContainer(_destSelect)),
              SizedBox(
                height: 20.0,
              ),
              _submitButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Container _showContainer(String content) {
    return Container(
      height: 50.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        border: Border.all(width: 1.0, color: Colors.grey[300]),
        color: Colors.grey[100],
      ),
      child: Center(
          child: Text(
        content,
        style: TextStyle(color: Colors.black87),
      )),
    );
  }

  FlatButton _submitButton(BuildContext context) {
    return FlatButton(
      color: Colors.blue,
      onPressed: () async {
        showModalBottomSheet(
            context: context,
            builder: (_) {
              return MyProgressIndicator();
            },
            isDismissible: false,
            enableDrag: false);

        await orderNetwork.createNewOrder(
            orderKey: generateOrderKey(store: _storeSelect),
            store: _storeSelect,
            menu: _menuSelect,
            time: _timeSelect,
            dest: _destSelect,
            ordererKey: _ordererSelect,
            orderDay: _daySelect);

        Navigator.pop(context);

        Navigator.pop(context);
      },
      child: Text(
        '신규 주문 추가',
        style: TextStyle(color: Colors.white),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
    );
  }
}
