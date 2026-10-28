import 'package:equatable/equatable.dart';

class PaginatedResponse<T> extends Equatable {
  static const int firstPage = 1;

  final List<T> data;
  final int? nextPage;
  final int itemsCount;

  const PaginatedResponse({required this.data, required this.itemsCount, this.nextPage});

  static int getOffset({required int page, required int pageSize}) => (page - firstPage) * pageSize;

  static int? getNextPage({required int page, required int loadedItemsCount, required int itemsCount}) {
    return loadedItemsCount < itemsCount ? page + 1 : null;
  }

  @override
  List<Object?> get props => [data, nextPage, itemsCount];
}
