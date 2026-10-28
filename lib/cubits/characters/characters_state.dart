part of 'characters_cubit.dart';

abstract class CharactersState extends Equatable {
  const CharactersState();

  @override
  List<Object?> get props => [];
}

class CharactersInitial extends CharactersState {
  const CharactersInitial();
}

class CharactersLoading extends CharactersState {
  const CharactersLoading();
}

class CharactersLoaded extends CharactersState implements PaginatedStateInfinityScroll<Character> {
  @override
  final List<Character> items;
  @override
  final int? nextPage;
  @override
  final int itemsCount;
  @override
  final bool isLoadingMore;
  @override
  final bool hasLoadMoreError;

  const CharactersLoaded({
    required this.items,
    required this.itemsCount,
    this.nextPage,
    this.isLoadingMore = false,
    this.hasLoadMoreError = false,
  });

  @override
  bool get hasReachedEnd => nextPage == null;

  @override
  CharactersLoaded copyWith({
    List<Character>? items,
    int? Function()? nextPage,
    int? itemsCount,
    bool? isLoadingMore,
    bool? hasLoadMoreError,
  }) {
    return CharactersLoaded(
      items: items ?? this.items,
      nextPage: nextPage != null ? nextPage() : this.nextPage,
      itemsCount: itemsCount ?? this.itemsCount,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasLoadMoreError: hasLoadMoreError ?? this.hasLoadMoreError,
    );
  }

  @override
  List<Object?> get props => [items, nextPage, itemsCount, isLoadingMore, hasLoadMoreError];
}

class CharactersError extends CharactersState {
  const CharactersError();
}
