import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_heroes/cubits/cubit_pagination_mixin/paginated_state.dart';
import 'package:super_heroes/services/pagination/paginated_response.dart';

mixin PaginationMixin<V, S, P extends PaginatedStateInfinityScroll<V>> on BlocBase<S> {
  Future<PaginatedResponse<V>> Function(int page) get fetch;

  int get pageSize;

  Object getItemId(V item);

  Future<PaginatedResponse<V>> fetchFirstPage() => fetch(PaginatedResponse.firstPage);

  Future<void> loadMore() async {
    final S currentState = state;
    if (currentState is! P || currentState.hasReachedEnd || currentState.isLoadingMore) return;
    emit(currentState.copyWith(isLoadingMore: true, hasLoadMoreError: false) as S);
    try {
      final PaginatedResponse<V> response = await fetch(currentState.items.length ~/ pageSize + PaginatedResponse.firstPage);
      final S latestState = state;
      if (isClosed || latestState is! P) return;
      emit(latestState.copyWith(
        items: _mergeItems(latestState.items, response.data),
        nextPage: () => response.nextPage,
        itemsCount: response.itemsCount,
        isLoadingMore: false,
      ) as S);
    } catch (_) {
      final S latestState = state;
      if (isClosed || latestState is! P) return;
      emit(latestState.copyWith(isLoadingMore: false, hasLoadMoreError: true) as S);
    }
  }

  Future<void> refreshContent() async {
    if (state is! P) return;
    final PaginatedResponse<V> response = await fetchFirstPage();
    final S latestState = state;
    if (isClosed || latestState is! P) return;
    emit(latestState.copyWith(
      items: response.data,
      nextPage: () => response.nextPage,
      itemsCount: response.itemsCount,
      isLoadingMore: false,
      hasLoadMoreError: false,
    ) as S);
  }

  List<V> _mergeItems(List<V> currentItems, List<V> newItems) {
    final Set<Object> currentIds = currentItems.map(getItemId).toSet();
    return [...currentItems, ...newItems.where((V item) => !currentIds.contains(getItemId(item)))];
  }
}
