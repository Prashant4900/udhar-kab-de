import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/models/hotspots/hotspot_request_model.dart';
import 'package:mobile/models/hotspots/hotspot_response_model.dart';
import 'package:mobile/repositories/hotspot_repository.dart';
import 'package:mobile/setup.dart';

part 'hotspot_event.dart';
part 'hotspot_state.dart';

class HotspotBloc extends Bloc<HotspotEvent, HotspotState> {
  HotspotBloc() : super(HotspotState.initial()) {
    on<CreateHotspotEvent>(_createHotspot);
    on<GetAllHotspotEvent>(_getAllHotspots);
    on<UpdateHotspotEvent>(_updateHotspot);
    on<DeleteHotspotEvent>(_deleteHotspot);
  }

  final hotspotRepository = getIt<HotspotRepository>();

  FutureOr<void> _createHotspot(
    CreateHotspotEvent event,
    Emitter<HotspotState> emit,
  ) async {
    emit(state.copyWith(status: HotspotStatus.loading));

    try {
      final result = await hotspotRepository.createHotspot(event.hotspotModel);

      if (result != null) {
        final newHotspotList = await hotspotRepository.getHotspots();

        emit(
          state.copyWith(
            status: HotspotStatus.success,
            hotspots: newHotspotList,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: HotspotStatus.success,
            hotspots: state.hotspots,
          ),
        );
      }
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

    try {
      final result = await hotspotRepository.updateHotspot(event.hotspotModel);
      if (result != null) {
        final newHotspotList = await hotspotRepository.getHotspots();
        log(newHotspotList.toString());
        emit(
          state.copyWith(
            status: HotspotStatus.success,
            hotspots: newHotspotList,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: HotspotStatus.success,
            hotspots: state.hotspots,
          ),
        );
      }
    } catch (e) {
      final message = e.toString();
      emit(state.copyWith(status: HotspotStatus.failure, message: message));
    }
  }

  FutureOr<void> _deleteHotspot(
    DeleteHotspotEvent event,
    Emitter<HotspotState> emit,
  ) async {
    emit(state.copyWith(status: HotspotStatus.loading));
    try {
      await hotspotRepository.deleteHotspots(event.hotspotModel);
      final hotspots = await hotspotRepository.getHotspots();
      emit(state.copyWith(hotspots: hotspots, status: HotspotStatus.success));
    } catch (e) {
      final message = e.toString();
      emit(state.copyWith(status: HotspotStatus.failure, message: message));
    }
  }
}
