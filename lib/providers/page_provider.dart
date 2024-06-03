import 'package:flutter_riverpod/flutter_riverpod.dart';

class PageNotifier extends StateNotifier<int> {
  int row;
  PageNotifier({required this.row}) : super(0);

  void setPage(int page) => state = page;
}

final pageNotifierProvider =
    StateNotifierProvider.family<PageNotifier, int, int>((ref, row) {
  final fn = PageNotifier(row: row);
  return fn;
});
