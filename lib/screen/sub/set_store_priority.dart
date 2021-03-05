import 'package:demo_kai_morning_210303/model/store_model.dart';
import 'package:demo_kai_morning_210303/network/store_network_func.dart';
import 'package:demo_kai_morning_210303/widgets/my_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SetStorePriority extends StatefulWidget {

  final List<String> stores; // 여기엔 storeKey들이 들어있다.

  SetStorePriority({this.stores});

  @override
  _SetStorePriorityState createState() => _SetStorePriorityState();
}

class _SetStorePriorityState extends State<SetStorePriority> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text('가게 우선순위'),
          ),
          Expanded(
            child: StreamProvider<List<StoreModel>>.value(
              value: storeNetwork.getStoresFromKeys(widget.stores),
              child: Consumer<List<StoreModel>>(
                builder: (context, stores, _){
                  if(stores == null){
                    return MyProgressIndicator();
                  }
                  else if (stores.isEmpty){
                    return Text('가게가 하나도 없네요!');
                  }
                  else{
                    return ListView.builder(
                      itemCount: widget.stores.length,
                      itemBuilder: (context, index){
                        return ListTile(
                          leading: Text('$index '),
                          title: Text('${stores[index].storeName}'),
                        );
                      },
                    );
                  }

                }
              ),
            ),
          )
        ],
      ),
    );
  }
}
