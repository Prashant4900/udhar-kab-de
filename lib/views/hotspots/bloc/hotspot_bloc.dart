import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/models/hotspot_model.dart';
import 'package:mobile/repositories/hotspot_repository.dart';
import 'package:mobile/setup.dart';

part 'hotspot_event.dart';
part 'hotspot_state.dart';

class HotspotBloc extends Bloc<HotspotEvent, HotspotState> {
  HotspotBloc() : super(HotspotState.initial()) {
    on<CreateHotspotEvent>(_createHotspot);
    on<GetAllHotspotEvent>(_getAllHotspots);
    on<UpdateHotspotEvent>(_updateHotspot);
  }
  final hotspotRepository = getIt<HotspotRepository>();
  FutureOr<void> _createHotspot(
    CreateHotspotEvent event,
    Emitter<HotspotState> emit,
  ) async {
    emit(state.copyWith(status: HotspotStatus.loading));

    try {
      await hotspotRepository.createHotspot(event.hotspotModel);
      emit(state.copyWith(status: HotspotStatus.success));
    } catch (e) {
      final message = e.toString();
      emit(state.copyWith(status: HotspotStatus.failure, message: message));
    }
  }

  FutureOr<void> _getAllHotspots(
    GetAllHotspotEvent event,
    Emitter<HotspotState> emit,
  ) async {
    emit(state.copyWith(status: HotspotStatus.loading));

    try {
      final hotspots = await hotspotRepository.getHotspots();
      emit(state.copyWith(hotspots: hotspots, status: HotspotStatus.success));
    } catch (e) {
      final message = e.toString();
      emit(state.copyWith(status: HotspotStatus.failure, message: message));
    }
  }

  FutureOr<void> _updateHotspot(
    UpdateHotspotEvent event,
    Emitter<HotspotState> emit,
  ) async {
    emit(state.copyWith(status: HotspotStatus.loading));

    try {} catch (e) {
      final message = e.toString();
      emit(state.copyWith(status: HotspotStatus.failure, message: message));
    }
  }
}
