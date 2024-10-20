part of 'board_cubit.dart';

@immutable
sealed class BoardState {}

final class BoardInitial extends BoardState {}
final class BoardLoading extends BoardState {}
final class BoardStart extends BoardState {}

final class BoardChangePlayer extends BoardState {}
final class BoardWin extends BoardState {}
final class BoardDraw extends BoardState {}
final class BoardReset extends BoardState {}
final class RestartBoard extends BoardState {}
