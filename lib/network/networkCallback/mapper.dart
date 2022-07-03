// Handler for the network's response.
abstract class Mapper<T> {
  // factory Mapper(Mapper type, String data) {
  //   if (type is BaseMapper) {
  //     Map<String, dynamic> mappingData = json.decode(data);
  //     return type.fromJson(mappingData);
  //   } else if (type is ListMapper) {
  //     Iterable iterableData = json.decode(data);
  //     return type.fromJsonList(iterableData);
  //   }
  //   print("Couldn't parse");
  //   return null;
  // }
}

abstract class BaseMapper<T> implements Mapper {
  Mapper fromJson(Map<String, dynamic> json);
}

abstract class ListMapper<T> implements Mapper {
  Mapper fromJsonList(List<dynamic> json);
}
