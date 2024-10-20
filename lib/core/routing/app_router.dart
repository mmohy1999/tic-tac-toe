import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe/features/board/logic/board_cubit.dart';
import 'package:tic_tac_toe/features/board/ui/board_screen.dart';
import 'package:tic_tac_toe/features/home/ui/home_screen.dart';
import 'package:tic_tac_toe/features/room/logic/room_cubit.dart';
import 'package:tic_tac_toe/features/room/ui/room_screen.dart';

import '../../features/login/logic/login_cubit.dart';
import '../../features/login/ui/login_screen.dart';
import '../di/dependency_injection.dart';
import 'routes.dart';

class AppRouter {

  Route? generateRoute(RouteSettings settings) {

    switch (settings.name) {

      case Routes.loginScreen:
        return MaterialPageRoute(builder: (context) =>
            BlocProvider(
              create: (context) => getIt<LoginCubit>(),
              child: const LoginScreen(),
            ),);
      case Routes.homeScreen:
        return MaterialPageRoute(builder: (_) =>  HomeScreen(),);

      case Routes.boardScreen:
        return MaterialPageRoute(builder: (context) =>
            BlocProvider(
              create: (context) => getIt<BoardCubit>(),
              child: const BoardScreen(),
            ),);
      case Routes.roomScreen:
        return MaterialPageRoute(builder: (context) =>
            BlocProvider(
              create: (context) => getIt<RoomCubit>(),
              child:  RoomScreen(),
            ),);
      default:
        return MaterialPageRoute(
            builder: (_) =>
                Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                )
        );
    }
  }
}