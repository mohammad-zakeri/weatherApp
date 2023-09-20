part of 'bookmark_bloc.dart';

@immutable
abstract class BookmarkEvent {}

class GetAllCityEvent extends BookmarkEvent {}

class GetCityByNameEvent extends BookmarkEvent {
  GetCityByNameEvent(this.cityName);
  final String cityName;
}

class SaveCwEvent extends BookmarkEvent {
  SaveCwEvent(this.name);
  final String name;
}

class SaveCityInitialEvent extends BookmarkEvent {}

class DeleteCityEvent extends BookmarkEvent {
  DeleteCityEvent(this.name);
  final String name;
}