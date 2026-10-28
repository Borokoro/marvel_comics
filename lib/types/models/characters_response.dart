import 'package:equatable/equatable.dart';
import 'package:super_heroes/types/models/character.dart';

class CharactersResponse extends Equatable {
  final List<Character> results;
  final int numberOfTotalResults;

  const CharactersResponse({required this.results, required this.numberOfTotalResults});

  factory CharactersResponse.fromJson(Map<String, dynamic> json) {
    return CharactersResponse(
      results: (json["results"] as List<dynamic>? ?? [])
          .map((dynamic character) => Character.fromJson(character as Map<String, dynamic>))
          .toList(),
      numberOfTotalResults: json["number_of_total_results"] as int? ?? 0,
    );
  }

  @override
  List<Object?> get props => [results, numberOfTotalResults];
}
