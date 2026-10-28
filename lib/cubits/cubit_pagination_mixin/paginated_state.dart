abstract class PaginatedState<V> {
  List<V> get items;
  int? get nextPage;
  int get itemsCount;

  bool get hasReachedEnd => nextPage == null;
}

abstract class PaginatedStateInfinityScroll<V> extends PaginatedState<V> {
  bool get isLoadingMore;
  bool get hasLoadMoreError;

  PaginatedStateInfinityScroll<V> copyWith({
    List<V>? items,
    int? Function()? nextPage,
    int? itemsCount,
    bool? isLoadingMore,
    bool? hasLoadMoreError,
  });
}
