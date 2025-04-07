
enum Type{tenant,landlord,address}
abstract class ParentRecord {

  late final Type type;
  String getID();
  int getRating();
  String getName();
  String getType();

}


