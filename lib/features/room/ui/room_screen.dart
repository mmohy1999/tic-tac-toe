import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe/core/helpers/constants.dart';
import 'package:tic_tac_toe/core/helpers/extensions.dart';
import 'package:tic_tac_toe/core/routing/routes.dart';
import 'package:tic_tac_toe/features/room/logic/room_cubit.dart';
import 'package:tic_tac_toe/features/room/ui/widgets/room_body.dart';
import 'package:tic_tac_toe/features/room/ui/widgets/room_dialog.dart';

class RoomScreen extends StatelessWidget {
    RoomScreen({super.key});
  late RoomCubit cubit;


  @override
  Widget build(BuildContext context) {
    cubit=context.read<RoomCubit>();
    return BlocListener<RoomCubit, RoomState>(
      listener: (context, state) {
        if(state is RoomCreated ||state is RoomJoin){
          roomDialog(context);
          cubit.subscribeToDocument();
        }else if(state is RoomStart){
          choiceMode='online';
          publicRoomId=cubit.roomId;
          context.pushNamedAndRemoveUntil(Routes.boardScreen,predicate: (route) => route.isFirst,);
        }
      },
      child: const RoomBody(),
    );
  }
  roomDialog(BuildContext context){
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return  Dialog(
          child:RoomDialog(cubit: cubit),
        );
      },
    );

  }

}
