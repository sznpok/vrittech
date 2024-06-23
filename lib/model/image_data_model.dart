class ImageData {
  final int id;
  final String base64Image;

  const ImageData({
    required this.id,
    required this.base64Image,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'base64Image': base64Image,
      };

  // Create an ImageData object from a Map (used for retrieval)
  factory ImageData.fromMap(Map<String, dynamic> map) => ImageData(
        id: map['id'],
        base64Image: map['base64Image'],
      );
}
