import 'package:demo_kai_morning_210303/constant/size.dart';
import 'package:demo_kai_morning_210303/model/store_model.dart';
import 'package:demo_kai_morning_210303/network/store_network_func.dart';
import 'package:demo_kai_morning_210303/useful/search_engine.dart';
import 'package:demo_kai_morning_210303/widgets/my_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShowStoreDialog extends StatefulWidget {

  final Function updateItem;
  final StoreModel storeModel;

  ShowStoreDialog({this.updateItem, this.storeModel});

  @override
  _ShowStoreDialogState createState() => _ShowStoreDialogState();
}

class _ShowStoreDialogState extends State<ShowStoreDialog> {
  TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text('${widget.storeModel.storeName}'),
        content: SizedBox(
          height: size.height * 0.6,
          width: size.width * 0.6,
          child: Column(
            children: [
              Text('${widget.storeModel.storePhone}'),
              Text('${widget.storeModel.lat}'),
              Text('${widget.storeModel.lon}'),
              Text('${widget.storeModel.storeItem}'),
            ],
          )
        ),
    actions: [
      FlatButton(
        onPressed: (){
          Navigator.pop(context);
        },
        child: Text('업데이트', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),),
    ),
      FlatButton(
        onPressed: (){
          Navigator.pop(context);
        },
        child: Text('취소'),
      ),

      ],
    );
  }
}
