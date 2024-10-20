import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class Player{
  String? name;
   bool? isYou;
   String? imageUrl;
   String? uid;

  Player({ this.name,  this.isYou,  this.imageUrl,  this.uid});

  static Future<Player>  fromId(String id)async{
     Player player=Player();
    await FirebaseFirestore.instance.collection('Users').doc(id).get().then((value){
      print('player ${value.data()}');
      player.name=value.data()!['name']??'Name';
      player.imageUrl=value.data()!['img']??'';
      player.uid=value.data()!['uid']??id;
      player.isYou=FirebaseAuth.instance.currentUser!.uid==value.data()!['uid'];
    });

    return player;
  }
}