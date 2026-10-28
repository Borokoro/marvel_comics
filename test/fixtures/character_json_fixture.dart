abstract class CharacterJsonFixture {
  static const int id = 1253;
  static const String name = "Lightning Lad";
  static const String imageUrl = "https://comicvine.gamespot.com/a/uploads/scale_medium/lld.jpg";
  static const String publisherName = "DC Comics";
  static const String deck = "Garth Ranzz is one of the founders of the Legion of Super-Heroes.";

  static Map<String, dynamic> minimal({int id = id}) {
    return {"id": id};
  }

  static Map<String, dynamic> full() {
    return {
      "id": id,
      "name": name,
      "deck": deck,
      "image": {"medium_url": imageUrl, "original_url": "https://comicvine.gamespot.com/a/uploads/original/lld.jpg"},
      "publisher": {"id": 10, "name": publisherName},
    };
  }
}
