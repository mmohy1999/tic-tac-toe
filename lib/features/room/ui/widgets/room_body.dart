import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe/core/helpers/bloc_observer.dart';
import 'package:tic_tac_toe/features/room/logic/room_cubit.dart';
import 'package:tic_tac_toe/features/room/ui/widgets/card_player.dart';

class RoomBody extends StatelessWidget {
  const RoomBody({super.key});

  @override
  Widget build(BuildContext context) {
    RoomCubit cubit=context.read<RoomCubit>();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Play With Private Room'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Enter Private Code And Join With Your Friend',
              style: TextStyle(
                color: Colors.black38,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: cubit.roomIdController,
                decoration: InputDecoration(
                  hintText: 'Enter Code Here',
                  hintStyle: const TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black26,
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () =>cubit.joinRoom(),
              child: const Text('Join Now',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 20),
            const Row(
              children: [
                Expanded(child: Divider(height: 2)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    'OR',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                ),
                Expanded(child: Divider(height: 2)),

              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black26,
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () =>cubit.createRoom(),
              child: const Text('Create Room',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }


}
