
//TODO - Vilka värden tror ni är optionals? eller är inga det? Kanske bra o skriva ner hela Json till en fil i projektet? Borde ta max 60 - 90 min

class HeroModel {

    int heroId;
    int intelligence;
    int strength;
    int speed;
    int durability;
    int power;
    int combat;
    
    String name;
    String? fullName;
    String? alterEgos;
    String placeOfBirth;
    String firstAppearance;
    String publisher;
    String alignment;
    String gender;
    String race;
    String? eyeColor;
    String? hairColor;
    String? occupation;
    String? base;
    String? groupAffiliation;
    String? relatives;
    String url;

    List<String>? aliases = [];
    List<String> weight = [];
    List<String> height = [];

    HeroModel({
        this.heroId = 0,
        required this.name,
        required this.intelligence,
        required this.strength,
        required this.speed,
        required this.durability,
        required this.power,
        required this.combat,
        required this.placeOfBirth,
        required this.firstAppearance,
        required this.publisher,
        required this.alignment,
        required this.gender,
        required this.race,
        required this.url,
        required this.height,
        required this.weight,
        this.fullName,
        this.alterEgos,
        this.eyeColor,
        this.hairColor,
        this.occupation,
        this.base,
        this.groupAffiliation,
        this.relatives,
        this.aliases
    });

    // Nested structures on json file
    // powerstats
    // biography
    // appearance
    // work
    // connections
    // image

    // TODO Serialization
    // Map<String, dynamic> toJson() => {
    //     "hero-id" : heroId,
    //     "name" : name
    // };

    // TODO Deserialization
    factory HeroModel.fromJson(Map<String, dynamic> json){
        List<String> missingFields = [];

        if(json["hero-id"] == null) missingFields.add("hero-id");
        if(json["name"] == null) missingFields.add("name");
        if(json["intelligence"] == null) missingFields.add("intelligence");
        if(json["strength"] == null) missingFields.add("strength");
        if(json["speed"] == null) missingFields.add("speed");
        if(json["durability"] == null) missingFields.add("durability");
        if(json["power"] == null) missingFields.add("power");
        if(json["combat"] == null) missingFields.add("combat");
        if(json["place-of-birth"] == null) missingFields.add("place-of-birth");
        if(json["first-appearance"] == null) missingFields.add("first-appearance");
        if(json["publisher"] == null) missingFields.add("publisher");
        if(json["alignment"] == null) missingFields.add("alignment");
        if(json["gender"] == null) missingFields.add("gender");
        if(json["race"] == null) missingFields.add("race");
        if(json["height"] == null) missingFields.add("height");
        if(json["weight"] == null) missingFields.add("weight");
        if(json["url"] == null) missingFields.add("url");

        if(missingFields.isNotEmpty){
            throw FormatException("Missing required fields: ${missingFields.join(", ")}");
        }

        return HeroModel(
            heroId : json["hero-id"],
            name : json["name"],
            intelligence : json["intelligence"],
            strength : json["strength"],
            speed : json["speed"],
            durability : json["durability"],
            power : json["power"],
            combat : json["combat"],
            placeOfBirth : json["place-of-birth"],
            firstAppearance : json["first-appearance"],
            publisher : json["publisher"],
            alignment : json["alignment"],
            gender : json["gender"],
            race : json["race"],
            height : json["height"],
            weight : json["weight"],
            url : json["url"],
            fullName : json["full-name"],
            alterEgos : json["alter-egos"],
            eyeColor : json["eye-color"],
            hairColor : json["hair-color"],
            occupation : json["occupation"],
            base : json["base"],
            groupAffiliation : json["group-affiliation"],
            relatives : json["relatives"],
            aliases : json["aliases"]
        );
    }
    

    @override
  String toString() {
    return ("""
=====================================================
Id:     $heroId
Namn:   $name
------------------------------------------------
Krafter:
  Intelligens:  $intelligence
  Styrka:       $strength
  Snabbhet:     $speed
  Hållbarhet:   $durability
  Kraft:        $power
  Stridsvärde:  $combat
------------------------------------------------
Biografi:
  Fullt namn:   $fullName
  Alter egon:   $alterEgos
  Alias:        $aliases
  Födelseplats: $placeOfBirth
  Debut:        $firstAppearance
  Utgivare:     $publisher
  Moral:        $alignment
------------------------------------------------
Utseende:
  Kön:          $gender
  Ras:          $race
  Längd:        $height
  Vikt:         $weight
  Ögonfärg:     $eyeColor
  Hårdfärg:     $hairColor
------------------------------------------------
Arbete:
  Yrke:         $occupation
  Bas:          $base
------------------------------------------------
Kontakter:
  Gruppanknyt.: $groupAffiliation
  Anhöriga:     $relatives
=====================================================
""");
  }
}