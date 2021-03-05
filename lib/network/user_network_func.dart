import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_kai_morning_210303/model/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constant/firestore_keys.dart';
import '../model/rider_model.dart';
import 'help/transformer.dart';



class UserNetwork with Transformers {

  Future<void> createNewUser({@required String userKey, @required String userNickName, @required String userDest, @required String userPhone}) async {
    final DocumentReference userRef = FirebaseFirestore.instance.collection(COLLECTION_HOME).doc(DOCUMENT_ADMIN).collection(COLLECTION_USERS).doc(userKey);

    DocumentSnapshot snapshot = await userRef.get();

    if(!snapshot.exists){
    return await userRef.set(UserModel.getMapForCreateUser(userKey: userKey, userNickname: userNickName, userDest: userDest, userPhone: userPhone));
    }
  }
}

UserNetwork userNetwork = UserNetwork();