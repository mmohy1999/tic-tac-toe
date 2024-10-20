import 'package:flutter/material.dart';
import 'package:tic_tac_toe/features/room/data/player.dart';

class PlayerCard extends StatelessWidget {

  final Player? player;

   const PlayerCard({super.key,
   required this.player
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: player==null||player!.imageUrl==''? const AssetImage('assets/images/avatar.png'):NetworkImage(player!.imageUrl!),
        ),
        const SizedBox(height: 10),
        Text(
          player==null?"name":player!.name!,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 5),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            player!=null&&player!.isYou==true?'You':'Your Opponent',
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}