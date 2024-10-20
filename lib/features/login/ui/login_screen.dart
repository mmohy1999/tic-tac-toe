import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe/core/helpers/extensions.dart';
import 'package:tic_tac_toe/core/routing/routes.dart';
import 'package:tic_tac_toe/features/login/logic/login_cubit.dart';
import 'package:tic_tac_toe/features/login/ui/widgets/body.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoginCubit,LoginState>(listener: (context, state) {
        if(state is CompleteLogin){
          context.pushNamedAndRemoveUntil(Routes.homeScreen, predicate: (route) => false,);
        }
      },child: const Body(),),
    );
  }
}
