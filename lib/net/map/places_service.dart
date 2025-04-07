
import '../../model/place/PlaceSearch.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
class PlacesService{
  final key= "KEY";
  Future<List<PlaceSearch>> getAutoComplete(String search) async{
      var url='https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$search&types=geocode&key=$key';
      var response= await http.get(Uri.parse(url));
      print("here2");
      print(response.body);
      var json= convert.jsonDecode(response.body);
      var jsonResults= json['predictions'] as List;
      return jsonResults.map((place) => PlaceSearch.fromJson(place)).toList();
  }
}
