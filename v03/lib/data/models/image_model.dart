class ImageModel {
  String url;

  ImageModel({required this.url});

  // Deserialization
  factory ImageModel.fromJson(Map<String, dynamic> json){
    List<String> missingFields = [];

    if(json["url"] == null) missingFields.add("url");

    if(missingFields.isNotEmpty){
        throw FormatException("Missing required fields: ${missingFields.join(", ")}");
    }
    return ImageModel(
        url : json["url"],
    );
  }

  // Serialization
  Map<String, dynamic> toJson() => {
    "url": url,
  };
}