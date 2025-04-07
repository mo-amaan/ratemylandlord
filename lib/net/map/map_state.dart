part of 'map_cubit.dart';


enum HSStatus {loading, loaded, failure}
class MapState extends Equatable {

  final List<PlaceSearch> list;
  final HSStatus status;
  Position? currentLocation;

  MapState({
    this.status = HSStatus.loading,
    this.list = const<PlaceSearch> [],
    this.currentLocation = null,
  });


  MapState copyWith( {
    HSStatus? status,
    List<PlaceSearch>? list,
    currentLocation,
  })
  {
    return MapState(
        currentLocation: currentLocation ?? this.currentLocation,
        status: status ?? this.status,
        list : list ?? this.list
    );
  }

  @override
  List<Object> get props => [status, list];

  @override
  bool? get stringify => true;
}