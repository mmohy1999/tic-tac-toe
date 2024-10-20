import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe/core/helpers/constants.dart';
import 'package:tic_tac_toe/features/room/data/player.dart';

part 'board_state.dart';

class BoardCubit extends Cubit<BoardState> {
  BoardCubit() : super(BoardInitial()){
  initGameMode();
  }
   String mode= choiceMode;
   String? roomId;
  List<String> board = List.filled(9, '');
  String currentChar = 'X';
  Player? currentPlayer;
  Player? playerX,playerO;
  String? winner;
  List<int>? winningLine;
  late FirebaseFirestore firestore;
  late User user;
  StreamSubscription<DocumentSnapshot>? _subscription;

  initGameMode(){
    if(mode=='online'){
      roomId=publicRoomId;
      initOnline();
    }else if(mode=='bot'){
      initBot();
    }else{
      init1VS1();
    }
  }
  initOnline()async{
    emit(BoardLoading());
    firestore=FirebaseFirestore.instance;
    user=FirebaseAuth.instance.currentUser!;
    await getPlayers();
    currentPlayer=playerX;
    emit(BoardStart());
    streamBoard();
  }
  init1VS1(){
    playerX= Player(name: 'player 1',imageUrl: '',isYou: true,uid: '1');
    playerO= Player(name: 'player 2',imageUrl: '',isYou: false,uid: '2');
    currentPlayer=playerX;
    emit(BoardStart());
  }
  initBot(){
    playerX= Player(name: 'player 1',imageUrl: '',isYou: true,uid: '1');
    playerO= Player(name: 'Bot',imageUrl: 'https://e7.pngegg.com/pngimages/713/975/png-clipart-chatbot-robot-internet-bot-artificial-intelligence-icon-robot-electronics-rectangle.png',isYou: false,uid: '2');
    currentPlayer=playerX;
    emit(BoardStart());
  }
  @override
  Future<void> close() {
    _subscription!.cancel();
    return super.close();
  }
  streamBoard(){
    _subscription= firestore
        .collection('Rooms')
        .doc(roomId)
        .snapshots()
        .listen((snapshot) async {
      print('Board Stream data:${snapshot.data()}');
      if (snapshot.exists) {
        if(currentPlayer!.uid!=user.uid){
          board=[];
         for(var value in snapshot.data()!['game_board']){
            if(value==null||value==''){
              board.add('');
            }else{
              board.add(value);
            }
          }
          emit(RestartBoard());
          if (_checkWinner(currentChar)) {
            winner = currentChar ;
            emit(BoardWin());
          } else if (!board.contains('')) {
            winner = 'Draw!';
            emit(BoardDraw());
          }
        }

        if(snapshot.data()!['currentTurn']==snapshot.data()!['playerX']){
          currentPlayer=playerX;
          currentChar='X';
        }else{
          currentPlayer=playerO;
          currentChar='O';

        }
        if(snapshot.data()!['game_status']=='reset'){
          _resetGame();
          _handelGameStateInFirebase('Playing');
        }
      }
    });
  }


  updateOnFirebase(){
    firestore
        .collection('Rooms')
        .doc(roomId).update({
      'game_board':board,
      'currentTurn':currentPlayer!.uid,
    });
  }



  handleTap(int index) {
  if(mode=='1 VS 1'){
    _handel1Vs1Tap(index);
  }else if(mode=='bot'){
    _handelSingleTap(index);
  }else{
    _handelOnlineTap(index);
  }
  }
  _handel1Vs1Tap(int index){
    if (board[index] == '' && winner == null) {
      board[index] = currentChar;
      if (_checkWinner(currentChar)) {
        winner = currentChar ;
        emit(BoardWin());
      } else if (!board.contains('')) {
        winner = 'Draw!';
        emit(BoardDraw());
      } else {
        currentChar = currentChar == 'X' ? 'O' : 'X';
        currentPlayer= currentChar=='X'? playerX:playerO;

        emit(BoardChangePlayer());
      }
    }
  }
  _handelSingleTap(int index){
    if (board[index] == '' && winner == null) {
      board[index] = currentChar;
      if (_checkWinner(currentChar)) {
        winner = currentChar;
        emit(BoardWin());
      } else if (!board.contains('')) {
        winner = 'Draw!';
        emit(BoardDraw());
      } else {
        currentChar = currentChar == 'X' ? 'O' : 'X';
        currentPlayer= currentChar=='X'? playerX:playerO;
        if(currentChar=='O'){
          _botMove();
        }
        emit(BoardChangePlayer());
      }
    }
  }
  _handelOnlineTap(int index){
    if (board[index] == '' && winner == null&&currentPlayer!.uid==user.uid) {
      board[index]= currentChar;
      if (_checkWinner(currentChar)) {
        winner = currentChar ;
        updateOnFirebase();
        emit(BoardWin());
      } else if (!board.contains('')) {
        updateOnFirebase();
        winner = 'Draw!';
        emit(BoardDraw());
      } else {
        currentChar = currentChar == 'X' ? 'O' : 'X';
        currentPlayer= currentChar=='X'? playerX:playerO;
        updateOnFirebase();
        emit(BoardChangePlayer());
      }
    }
  }

  getPlayers() async {
    await firestore.collection('Rooms').doc(roomId).get().then((value) async {
      if(value.exists){
        playerX=await Player.fromId(value.data()!['playerX']);
        playerO=await Player.fromId(value.data()!['playerO']);
      }
    },);
  }

  bool _checkWinner(String player) {
    const winningCombinations = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var combo in winningCombinations) {
      if (board[combo[0]] == player &&
          board[combo[1]] == player &&
          board[combo[2]] == player) {
        winningLine = combo;
        return true;
      }
    }
    return false;
  }

  _resetGame() {
    board = List.filled(9, '');
    currentChar = 'X';
    winner = null;
    winningLine = null;
    currentPlayer=playerX;
    emit(BoardReset());
  }
  handelResetGame(){
    if(mode=='online'){
      _resetGame();
      _handelGameStateInFirebase('reset');

    }else{
      _resetGame();
    }
  }
  _handelGameStateInFirebase(String gameState){
    firestore
        .collection('Rooms')
        .doc(roomId).update({
      'game_board':board,
      'currentTurn':currentPlayer!.uid,
      'game_status':gameState
    });
  }

   _botMove() {
    Future.delayed(const Duration(milliseconds: 200), () {
      List<int> availableMoves = [];
      for (int i = 0; i < board.length; i++) {
        if (board[i] == '') {
          availableMoves.add(i);
        }
      }
      if (availableMoves.isNotEmpty) {
        int randomIndex = availableMoves[Random().nextInt(availableMoves.length)];
        handleTap(randomIndex);
      }
    });
  }
}
