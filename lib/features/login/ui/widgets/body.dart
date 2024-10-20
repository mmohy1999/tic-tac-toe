import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:tic_tac_toe/features/login/logic/login_cubit.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    LoginCubit cubit=context.read<LoginCubit>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Social Login',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Make a login using social network accounts',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 30),
          OutlinedButton.icon(
            icon: const Icon(Icons.facebook,color: Colors.blue,),
            label: const Text('Sign in with Facebook'),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.blue),

              minimumSize: const Size(double.infinity, 50),
            ),
            onPressed: () => cubit.signInWithFacebook(),
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
          Container(
            decoration:  BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: const GradientBoxBorder(gradient: LinearGradient(colors: [
                Color(0xFFFF3D00), // اللون الأول
                Color(0xFFFFC107), // اللون الثاني
                Color(0xFF4CAF50), // اللون الثالث
                Color(0xFF1976D2), // اللون الرابع
              ])),
            ),
            child: OutlinedButton.icon(
              icon: SvgPicture.asset('assets/icons/google.svg',width: 32,height: 32,),
              label:  const Text(
                'Sign in with Google',
                style: TextStyle(color:  Color(0xFFFF3D00)),
              ),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                side:BorderSide.none ,
              ),
              onPressed: () => cubit.signInWithGoogle(),
            ),
          ),
        ],
      ),
    );
  }
}
