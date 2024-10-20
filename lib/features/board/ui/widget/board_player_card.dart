import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe/features/board/logic/board_cubit.dart';
import 'package:tic_tac_toe/features/room/data/player.dart';

class BoardPlayerCard extends StatelessWidget {
  final Player player;
  final String side;

  const BoardPlayerCard({super.key, 
    required this.player,
    required this.side,
  });

  @override
  Widget build(BuildContext context) {
    BoardCubit cubit=context.read<BoardCubit>();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Card(
          shape: RoundedRectangleBorder(
            side:cubit.currentPlayer!.uid==player.uid? const BorderSide(color: Colors.grey):const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 4,
          child: Container(
            padding: const EdgeInsets.all(16),
            width: 120,
            height: 200,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  backgroundImage: player.imageUrl==''? const AssetImage('assets/images/avatar.png'):NetworkImage(player.imageUrl!),
                  radius: 30,
                ),
                const SizedBox(height: 8),
                Text(
                  player.isYou!?'You':player.name!,
                  style: const TextStyle( fontSize: 14,),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  side,
                  style: const TextStyle(
                     // color: statusColor,
                      fontSize: 32),
                  textAlign: TextAlign.center,
                ),

              ],
            ),
          ),
        ),
        if(cubit.winner!=null)
          cubit.winner=='Draw!'?const Text('Draw'):cubit.winner==side?const Text('Winner'):const Text('Looser')
      ],
    );
  }
}
