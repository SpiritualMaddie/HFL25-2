class PowerstatsModel {
  int intelligence;
  int strength;
  int speed;
  int durability;
  int power;
  int combat;

  PowerstatsModel({
    required this.intelligence,
    required this.strength,
    required this.speed,
    required this.durability,
    required this.power,
    required this.combat
  });

  // Deserialization
  factory PowerstatsModel.fromJson(Map<String, dynamic> json){
    List<String> missingFields = [];

    if(json["intelligence"] == null) missingFields.add("intelligence");
    if(json["strength"] == null) missingFields.add("strength");
    if(json["speed"] == null) missingFields.add("speed");
    if(json["durability"] == null) missingFields.add("durability");
    if(json["power"] == null) missingFields.add("power");
    if(json["combat"] == null) missingFields.add("combat");

    if(missingFields.isNotEmpty){
        throw FormatException("Missing required fields: ${missingFields.join(", ")}");
    }

    return PowerstatsModel(
        intelligence : json["intelligence"],
        strength : json["strength"],
        speed : json["speed"],
        durability : json["durability"],
        power : json["power"],
        combat : json["combat"]
    );
  }

  // Serialization
  Map<String, dynamic> toJson() => {
    "intelligence": intelligence,
    "strength": strength,
    "speed": speed,
    "durability": durability,
    "power": power,
    "combat": combat,
  };

  @override
  String toString() {
    return ("""
------------------------------------------------
Krafter:
  Intelligens:  $intelligence
  Styrka:       $strength
  Snabbhet:     $speed
  Hållbarhet:   $durability
  Kraft:        $power
  Stridsvärde:  $combat
""");
  }
}