
import 'package:get_it/get_it.dart';
import 'package:tic_tac_toe/features/board/logic/board_cubit.dart';
import 'package:tic_tac_toe/features/room/logic/room_cubit.dart';

import '../../features/login/logic/login_cubit.dart';


final getIt=GetIt.instance;
Future<void> setupGetIt() async{

  // login
  getIt.registerFactory<LoginCubit>(() => LoginCubit());
  // Board
  getIt.registerFactory<BoardCubit>(() => BoardCubit());
  // room
  getIt.registerFactory<RoomCubit>(() => RoomCubit());

}