import 'package:bloc/bloc.dart';
import 'package:bus_seat_layout/core/error/failures.dart';
import 'package:bus_seat_layout/domain/usecases/get_bus_layout.dart';
import 'package:equatable/equatable.dart';


part 'bus_layout_event.dart';
part 'bus_layout_state.dart';

class BusLayoutBloc extends Bloc<BusLayoutEvent, BusLayoutState> {
  final GetBusLayout getBusLayout;

  BusLayoutBloc({required this.getBusLayout}) : super(BusLayoutInitial()) {
    on<LoadBusLayoutFromApi1>(_onLoadBusLayoutFromApi1);
    on<LoadBusLayoutFromApi2>(_onLoadBusLayoutFromApi2);
  }

  Future<void> _onLoadBusLayoutFromApi1(
    LoadBusLayoutFromApi1 event,
    Emitter<BusLayoutState> emit,
  ) async {
    emit(BusLayoutLoading());
    try {
      final busLayout = await getBusLayout.fromApi1();
      emit(BusLayoutLoaded(data: busLayout.data));
    } on Failure catch (failure) {
      emit(BusLayoutError(message: failure.toUserMessage()));
    }
  }

  Future<void> _onLoadBusLayoutFromApi2(
    LoadBusLayoutFromApi2 event,
    Emitter<BusLayoutState> emit,
  ) async {
    emit(BusLayoutLoading());
    try {
      final busLayout = await getBusLayout.fromApi2();
      emit(BusLayoutLoaded(data: busLayout.data));
    } on Failure catch (failure) {
      emit(BusLayoutError(message: failure.toUserMessage()));
    }
  }
}