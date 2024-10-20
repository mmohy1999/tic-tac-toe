import 'package:flutter/material.dart';
import 'package:tic_tac_toe/features/board/ui/widget/board_body.dart';


class BoardScreen extends StatefulWidget {
  const BoardScreen({super.key});

  @override
  _BoardScreenState createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen> {



  @override
  Widget build(BuildContext context) {
    return const BoardBody();
  }




}

