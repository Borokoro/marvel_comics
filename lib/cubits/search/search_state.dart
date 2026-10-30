part of 'search_cubit.dart';

abstract class SearchState extends Equatable {
  final String query;

  const SearchState(this.query);

  @override
  List<Object?> get props => [query];
}

class SearchInitial extends SearchState {
  const SearchInitial() : super("");
}

class SearchLoading extends SearchState {
  const SearchLoading(super.query);
}

class SearchLoaded extends SearchState implements PaginatedStateInfinityScroll<Character> {
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

  const SearchLoaded({
    required String query,
    required this.items,
    required this.itemsCount,
    this.nextPage,
    this.isLoadingMore = false,
    this.hasLoadMoreError = false,
  }) : super(query);

  @override
  bool get hasReachedEnd => nextPage == null;

  @override
  SearchLoaded copyWith({
    List<Character>? items,
    int? Function()? nextPage,
    int? itemsCount,
    bool? isLoadingMore,
    bool? hasLoadMoreError,
  }) {
    return SearchLoaded(
      query: query,
      items: items ?? this.items,
      nextPage: nextPage != null ? nextPage() : this.nextPage,
      itemsCount: itemsCount ?? this.itemsCount,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasLoadMoreError: hasLoadMoreError ?? this.hasLoadMoreError,
    );
  }

  @override
  List<Object?> get props => [query, items, nextPage, itemsCount, isLoadingMore, hasLoadMoreError];
}

class SearchError extends SearchState {
  const SearchError(super.query);
}
