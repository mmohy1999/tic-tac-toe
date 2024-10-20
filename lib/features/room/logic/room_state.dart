part of 'room_cubit.dart';

@immutable
sealed class RoomState {}

final class RoomInitial extends RoomState {}
final class RoomCreated extends RoomState {}
final class RoomJoin extends RoomState {}
final class UserJoined extends RoomState {}
final class RoomStart extends RoomState {}

