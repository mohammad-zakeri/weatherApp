import 'package:equatable/equatable.dart';

abstract class DeleteCityStatus extends Equatable{}

class DeleteCityInitial extends DeleteCityStatus {
  @override
  List<Object?> get props => [];
}

class DeleteCityLoading extends DeleteCityStatus{
  @override
  List<Object?> get props => [];
}

class DeleteCityCompleted extends DeleteCityStatus{
  DeleteCityCompleted(this.name);

  final String name;

  @override
  List<Object?> get props => [name];
}

class DeleteCityError extends DeleteCityStatus{
  DeleteCityError(this.message);

  final String? message;

  @override
  List<Object?> get props => [message];
}