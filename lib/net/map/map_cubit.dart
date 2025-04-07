import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:rate_my_landlord/model/place/PlaceSearch.dart';
import 'package:rate_my_landlord/net/map/places_service.dart';
import 'package:geolocator/geolocator.dart';
part 'map_state.dart';


class MapCubit extends Cubit<MapState> {
  //final geoLocatorService = GeolocatorSerice();
  final placesService= PlacesService();
  //final geoLocatorService = GeolocatorSe();


  //alter this to take in a db reference in the constructor
  MapCubit() : super(MapState()) {
    setCurrentLocation();
  }
  void setCurrentLocation() async{
    //var c= await geoLocatorService.getCurrentLocation();
    //emit(state.copyWith(currentLocation: ));
  }
  void searchPlaces(String search) async{
    var searchResults= await placesService.getAutoComplete(search);
    print("here  ${searchResults.length}");
    emit(state.copyWith(list: searchResults));
  }


}