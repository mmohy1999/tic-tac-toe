import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe/features/board/logic/board_cubit.dart';

import 'winning_line_painter.dart';

class Board extends StatefulWidget {
  const Board({super.key});

  @override
  State<Board> createState() => _BoardState();
}

class _BoardState extends State<Board> {
  late BoardCubit cubit;

  @override
  void initState() {
    cubit = context.read<BoardCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: 400,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: BlocBuilder<BoardCubit, BoardState>(
        builder: (context, state) {
          return Stack(
            alignment: Alignment.center,
            children: [
              GridView.builder(
                itemCount: 9,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => cubit.handleTap(index),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          cubit.board[index],
                          style: const TextStyle(
                              fontSize: 36, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  );
                },
              ),
              if (cubit.winningLine != null) _buildWinningLine(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildWinningLine() {
    return CustomPaint(
      painter: WinningLinePainter(cubit.winningLine!),
      size: const Size(400, 400),
    );
  }
}
