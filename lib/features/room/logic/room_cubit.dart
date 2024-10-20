

import 'dart:async';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe/features/room/data/player.dart';

part 'room_state.dart';

class RoomCubit extends Cubit<RoomState> {
  RoomCubit() : super(RoomInitial());
  final User user= FirebaseAuth.instance.currentUser!;
  final FirebaseFirestore firestore=FirebaseFirestore.instance;
  StreamSubscription<DocumentSnapshot>? _subscription;
  TextEditingController roomIdController=TextEditingController();
  late String roomId;
   Player? playerX,playerO;

   @override
  Future<void> close() {
    _subscription!.cancel();
    roomIdController.dispose();
    return super.close();
  }
  void createRoom()async{
    roomId= Timestamp.now().millisecondsSinceEpoch.toString();
   await firestore.collection('Rooms').doc(roomId).set({
      'playerX':user.uid,
      'playerO':'',
      'currentTurn':user.uid,
     'game_status':'waiting',
      'game_board':["", "", "",
                   "", "", "",
                   "", "", ""]
    });
   playerX=Player(name: user.displayName!, isYou: true, imageUrl: '', uid: user.uid);
    emit(RoomCreated());
  }
  void startGame()async{
    await firestore.collection('Rooms').doc(roomId).update({
      'game_status':'playing'
    });
    emit(RoomStart());
  }
  void subscribeToDocument() {
    _subscription = firestore
        .collection('Rooms')
        .doc(roomId)
        .snapshots()
        .listen((snapshot) async {
      if (snapshot.exists) {
        if(user.uid==snapshot.data()!['playerX']){
        if(snapshot.data()!["playerO"]!=''){
         await firestore.collection('Users').doc(snapshot.data()!['playerO']).get().then((value) async {
            playerO=await Player.fromId(snapshot.data()!['playerO']);
          },);
        emit(UserJoined());
        }
      }else{
          if(snapshot.data()!["game_status"]=='playing'){
            emit(RoomStart());
          }
        }
      }
    });
  }
  void joinRoom()async{
    String textRoomId=roomIdController.text;
    if(textRoomId!=''&&await isRoomExitAndNotFull(textRoomId)) {
     await firestore.collection('Rooms').doc(textRoomId).update({
      'playerO':user.uid
    });
     playerO=Player(name: user.displayName!, isYou: true, imageUrl: '', uid: user.uid);
     await getPlayer(textRoomId);
     roomId=textRoomId;
     emit(RoomJoin());
    }else{
      print('Room is not exit or full');
    }


  }
  Future<bool> isRoomExitAndNotFull(String roomId)async{
    bool flag=false;
   await firestore.collection('Rooms').doc(roomId).get().then((value) {
     if(value.exists&&value.data()!['playerO']==''){
       flag=true;
     }
    },);
    return flag;
  }

   getPlayer(String roomId) async {
    await firestore.collection('Rooms').doc(roomId).get().then((value) async {
      if(playerX==null){
        playerX=await Player.fromId(value.data()!['playerX']);
      }else{
        playerO=await Player.fromId(value.data()!['playerO']);
      }
    },);

  }

}
