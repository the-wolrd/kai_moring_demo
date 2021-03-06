import 'package:demo_kai_morning_210303/constant/size.dart';
import 'package:demo_kai_morning_210303/model/store_model.dart';
import 'package:demo_kai_morning_210303/network/store_network_func.dart';
import 'package:demo_kai_morning_210303/widgets/my_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SetStorePriority extends StatefulWidget {

  final List<dynamic> initKeys;

  SetStorePriority({this.initKeys});

  @override
  _SetStorePriorityState createState() => _SetStorePriorityState();
}

class _SetStorePriorityState extends State<SetStorePriority> {
  List<dynamic> keys = [];

  @override
  void initState() {
    keys = widget.initKeys;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text('가게 우선순위'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: keys.length,
                itemBuilder: (context, index) {
                  return StreamProvider<StoreModel>.value(
                      value:
                      storeNetwork.getStoreFromKey(keys[index]),
                      child: Consumer<StoreModel>(
                          builder: (context, store, _) {
                            if (store == null) {
                              return MyProgressIndicator();
                            } else {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text('${index + 1}'),
                                    ),
                                    SizedBox(
                                      width:150.0,
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text('${store.storeName}'),
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        InkWell(
                                          child: Icon(Icons.arrow_drop_up, size: 30.0, color: (index == 0)? Colors.grey[300]: Colors.black,),

                                        ),
                                        InkWell(
                                          child: Icon(Icons.arrow_drop_down, size: 30.0, color: (index == keys.length - 1)? Colors.grey[300]: Colors.black),

                                        )
                                      ],
                                    )
                                  ],
                                ),
                              );
                            }
                          }));
                },
              )
            )
          ],
        ),
      ),
    );
  }
}
