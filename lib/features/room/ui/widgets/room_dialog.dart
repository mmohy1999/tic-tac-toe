import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe/features/room/logic/room_cubit.dart';

import '../../data/player.dart';
import 'card_player.dart';

class RoomDialog extends StatelessWidget {
  final RoomCubit cubit;

  const RoomDialog({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(value: cubit, child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 20),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(

            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              const Text(
                'Generated Room Code',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        cubit.roomId,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.copy, color: Colors.white),
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: cubit.roomId));
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Share This Private Code With Your Friends & Ask Them To Join The Game',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,

                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),
        BlocBuilder<RoomCubit, RoomState>(
          buildWhen: (previous, current) => current is UserJoined,
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                PlayerCard(
                  player: cubit.playerX,
                ),
                PlayerCard(
                  player: cubit.playerO,
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 30),
        if(cubit.playerX!.isYou!)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black26,
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () => cubit.startGame(),
              child: const Text('Start Game', style: TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
        if(cubit.playerX!.isYou!)
          const SizedBox(height: 20,)
      ],
    ),);
  }
}
