part of 'hotspot_bloc.dart';

sealed class HotspotEvent extends Equatable {
  const HotspotEvent();

  @override
  List<Object> get props => [];
}

final class CreateHotspotEvent extends HotspotEvent {
  const CreateHotspotEvent({required this.hotspotModel});
  final HotspotRequestModel hotspotModel;
  @override
  List<Object> get props => [super.props, hotspotModel];
}

final class GetAllHotspotEvent extends HotspotEvent {}

final class UpdateHotspotEvent extends HotspotEvent {
  const UpdateHotspotEvent({required this.hotspotModel});
  final HotspotRequestModel hotspotModel;
  @override
  List<Object> get props => [super.props, hotspotModel];
}

final class DeleteHotspotEvent extends HotspotEvent {
  const DeleteHotspotEvent({required this.hotspotModel});
  final HotspotRequestModel hotspotModel;
  @override
  List<Object> get props => [super.props, hotspotModel];
}
