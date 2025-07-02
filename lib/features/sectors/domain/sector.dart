

class Sector {
  final String code;

  final String name;

  Sector({required this.code, required this.name});

  factory Sector.fromJSON(Map<String,dynamic> data){
    return Sector(code: data['code'], name: data['name']);
  }
}