part of 'hotspot_bloc.dart';

enum HotspotStatus { initial, loading, success, failure }

class HotspotState extends Equatable {
  const HotspotState({this.message, this.status, this.hotspots});

  factory HotspotState.initial() =>
      const HotspotState(status: HotspotStatus.initial);

  final String? message;
  final HotspotStatus? status;
  final List<HotspotModel>? hotspots;

  HotspotState copyWith({
    String? message,
    HotspotStatus? status,
    List<HotspotModel>? hotspots,
  }) {
    return HotspotState(
      message: message ?? this.message,
      status: status ?? this.status,
      hotspots: hotspots ?? this.hotspots,
    );
  }

  @override
  List<Object?> get props => [message, status, hotspots];
}
