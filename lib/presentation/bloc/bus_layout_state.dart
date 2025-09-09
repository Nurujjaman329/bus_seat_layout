part of 'bus_layout_bloc.dart';

abstract class BusLayoutState extends Equatable {
  const BusLayoutState();

  @override
  List<Object> get props => [];
}

class BusLayoutInitial extends BusLayoutState {}

class BusLayoutLoading extends BusLayoutState {}

class BusLayoutLoaded extends BusLayoutState {
  final List<dynamic> data;

  const BusLayoutLoaded({required this.data});

  @override
  List<Object> get props => [data];
}

class BusLayoutError extends BusLayoutState {
  final String message;

  const BusLayoutError({required this.message});

  @override
  List<Object> get props => [message];
}