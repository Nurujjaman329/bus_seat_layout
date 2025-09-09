part of 'bus_layout_bloc.dart';

abstract class BusLayoutEvent extends Equatable {
  const BusLayoutEvent();

  @override
  List<Object> get props => [];
}

class LoadBusLayoutFromApi1 extends BusLayoutEvent {}

class LoadBusLayoutFromApi2 extends BusLayoutEvent {}