import 'package:equatable/equatable.dart';
import 'package:super_heroes/utils/string_utils.dart';

class Character extends Equatable {
  final int id;
  final String name;
  final String? imageUrl;
  final String? publisherName;
  final String? deck;

  const Character({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.publisherName,
    required this.deck,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic>? image = json["image"] as Map<String, dynamic>?;
    final Map<String, dynamic>? publisher = json["publisher"] as Map<String, dynamic>?;
    return Character(
      id: json["id"] as int,
      name: json["name"] as String? ?? "",
      imageUrl: image?["medium_url"] as String?,
      publisherName: publisher?["name"] as String?,
      deck: StringUtils.trimOrNullIfBlank(json["deck"] as String?),
    );
  }

  @override
  List<Object?> get props => [id, name, imageUrl, publisherName, deck];
}
