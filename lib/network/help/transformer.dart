import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_kai_morning_210303/constant/firestore_keys.dart';
import 'package:demo_kai_morning_210303/model/order_model.dart';
import 'package:demo_kai_morning_210303/model/user_model.dart';
import '../../model/rider_model.dart';


class Transformers {

  final toRider = StreamTransformer<DocumentSnapshot, RiderModel>.fromHandlers(
    handleData: (snapshot, sink) async {
      sink.add(RiderModel.fromSnapshot(snapshot));
    }
  );

  final toUser = StreamTransformer<DocumentSnapshot, UserModel>.fromHandlers(
      handleData: (snapshot, sink) async {
        sink.add(UserModel.fromSnapshot(snapshot));
      }
  );

  final toOrder = StreamTransformer<DocumentSnapshot, OrderModel>.fromHandlers(
      handleData: (snapshot, sink) async {
        sink.add(OrderModel.fromSnapshot(snapshot));
      }
  );

  final toReadyOrder = StreamTransformer<QuerySnapshot, List<OrderModel>>.fromHandlers(handleData: (snapshot, sink) async {
    List<OrderModel> orders = [];

    snapshot.docs.forEach((documentSnapshot) {
      if(documentSnapshot.data()[KEY_PROCESS] == KEY_READY)
        orders.add(OrderModel.fromSnapshot(documentSnapshot));
    });

    sink.add(orders);
  });

  final toDoingOrder = StreamTransformer<QuerySnapshot, List<OrderModel>>.fromHandlers(handleData: (snapshot, sink) async {
    List<OrderModel> orders = [];

    snapshot.docs.forEach((documentSnapshot) {
      if(documentSnapshot.data()[KEY_PROCESS] == KEY_DOING)
        orders.add(OrderModel.fromSnapshot(documentSnapshot));
    });

    sink.add(orders);
  });

  final toDoneOrder = StreamTransformer<QuerySnapshot, List<OrderModel>>.fromHandlers(handleData: (snapshot, sink) async {
    List<OrderModel> orders = [];

    snapshot.docs.forEach((documentSnapshot) {
      if(documentSnapshot.data()[KEY_PROCESS] == KEY_DONE)
        orders.add(OrderModel.fromSnapshot(documentSnapshot));
    });

    sink.add(orders);
  });
  final toUsers = StreamTransformer<QuerySnapshot, List<UserModel>>.fromHandlers(handleData: (snapshot, sink) async {
    List<UserModel> users = [];

    snapshot.docs.forEach((documentSnapshot) {
        users.add(UserModel.fromSnapshot(documentSnapshot));
    });

    sink.add(users);
  });

}