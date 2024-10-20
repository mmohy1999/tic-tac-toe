import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe/core/helpers/constants.dart';
import 'package:tic_tac_toe/core/helpers/extensions.dart';
import 'package:tic_tac_toe/core/routing/routes.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({super.key});
  final auth=FirebaseAuth.instance.currentUser;
   final auth2=FirebaseAuth.instance;

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black26,
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: () =>context.pushNamed(Routes.roomScreen),
                child: const Text('Room',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black26,
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: (){
                  context.pushNamed(Routes.boardScreen);
                  choiceMode='bot';
                },
                child: const Text('Local Single',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black26,
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: () {
                  context.pushNamed(Routes.boardScreen);
                  choiceMode='1 VS 1';
                },
                child: const Text('Local 1 VS 1',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
              ),
              const SizedBox(height: 10),

            ],
          ),
        ),
      ),
    );
  }
}
