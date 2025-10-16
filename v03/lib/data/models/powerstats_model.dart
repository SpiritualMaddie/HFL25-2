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
        intelligence : int.parse(json["intelligence"]),
        strength : int.parse(json["strength"]),
        speed : int.parse(json["speed"]),
        durability : int.parse(json["durability"]),
        power : int.parse(json["power"]),
        combat : int.parse(json["combat"])
    );
  }

  // Serialization
  Map<String, dynamic> toJson() => {
    "intelligence": intelligence.toString(),
    "strength": strength.toString(),
    "speed": speed.toString(),
    "durability": durability.toString(),
    "power": power.toString(),
    "combat": combat.toString(),
  };

  @override
  String toString() {
    return ("""
------------------------------------------------
Krafter:
------------------------------------------------
  Intelligens:  $intelligence
  Styrka:       $strength
  Snabbhet:     $speed
  Hållbarhet:   $durability
  Kraft:        $power
  Stridsvärde:  $combat
""");
  }
}