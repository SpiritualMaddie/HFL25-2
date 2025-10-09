class Connections {
  String? groupAffiliation;
  String? relatives;

  Connections({this.groupAffiliation, this.relatives});

  // Deserialization
  factory Connections.fromJson(Map<String, dynamic> json){

    return Connections(
        groupAffiliation : json["group-affiliation"],
        relatives : json["relatives"],
    );
  }

  // Serialization
  Map<String, dynamic> toJson() => {
    "group-affiliation": groupAffiliation,
    "relatives": relatives,
  };

  @override
  String toString() {
    return ("""
------------------------------------------------
Kontakter:
  Gruppanknyt.: $groupAffiliation
  Anhöriga:     $relatives
""");
  }
}