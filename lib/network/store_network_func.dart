import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_kai_morning_210303/model/store_model.dart';
import 'package:demo_kai_morning_210303/model/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constant/firestore_keys.dart';
import '../model/rider_model.dart';
import 'help/transformer.dart';

class StoreNetwork with Transformers {

  // @required List<String> storeItem 이건 뺀다. 처음 등록할때는 메뉴 추가 ㄴㄴㄴ
  Future<void> createNewStore(
      {@required String storeKey, @required String storeName, @required String storePhone, @required double lat, @required double lon}) async {
    final DocumentReference storeRef = FirebaseFirestore.instance.collection(
        COLLECTION_HOME).doc(DOCUMENT_ASSET).collection(COLLECTION_STORES).doc(
        storeKey);

    DocumentSnapshot snapshot = await storeRef.get();

    if (!snapshot.exists) {
      return await storeRef.set(StoreModel.getMapForCreateStore(
          storeKey: storeKey,
          storeName: storeName,
          storePhone: storePhone,
          storeItem: [],
          // 처음엔 빈 아이템들
          lat: lat,
          lon: lon
      ));
    }
  }

  Stream<List<StoreModel>> getStores() {
    return FirebaseFirestore.instance.collection(COLLECTION_HOME).doc(DOCUMENT_ASSET).collection(COLLECTION_STORES)
        .snapshots()
        .transform(toStores);
  }

  Stream<List<StoreModel>> getStoresFromKeys(List<String> keys) {

    final toStoresFromKeys = StreamTransformer<QuerySnapshot, List<StoreModel>>.fromHandlers(handleData: (snapshot, sink) async {
      List<StoreModel> stores = [];

      keys.forEach((element) async {
        DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection(COLLECTION_HOME).doc(DOCUMENT_ASSET).collection(COLLECTION_STORES).doc(element).get();
        stores.add(StoreModel.fromSnapshot(snapshot));
      });

      sink.add(stores);
    });

    return FirebaseFirestore.instance.collection(COLLECTION_HOME).doc(DOCUMENT_ASSET).collection(COLLECTION_STORES)
        .snapshots()
        .transform(toStoresFromKeys);
  }

}

StoreNetwork storeNetwork = StoreNetwork();