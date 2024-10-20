import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe/features/board/logic/board_cubit.dart';
import 'package:tic_tac_toe/features/board/ui/widget/board_player_card.dart';
import 'board.dart';

class BoardBody extends StatelessWidget {
  const BoardBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<BoardCubit>();
    return Scaffold(
      appBar: AppBar(
        title: Text(cubit.mode),
        centerTitle: true,
      ),
      body: BlocBuilder<BoardCubit, BoardState>(
        builder: (context, state) {
          if(state is BoardLoading) {
            return const Center(child: CircularProgressIndicator(),);
          }
          return  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BoardPlayerCard(player:cubit.playerX!, side: 'X',),
                  const SizedBox(width: 20,),
                  BoardPlayerCard(player:cubit.playerO!, side: 'O',)
                ],
              ),
              const SizedBox(height: 20),
              const Board(),
             if(cubit.winner!=null||(cubit.mode=='bot'||cubit.mode=='1vs1')||(cubit.mode=='online'&&cubit.playerX!.uid==cubit.user.uid))
             Expanded(child:  ElevatedButton(
               onPressed: cubit.handelResetGame,
               child: const Text('Restart Game'),
             ),)
             
            ],
          );

        },
      ),
    );
  }
}
