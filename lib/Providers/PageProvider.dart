import 'package:flutter/widgets.dart';

class PageProvider extends ChangeNotifier {
  int _currentPage = 0;
  int get currentPage => _currentPage;
  void setPage(int page) {
    _currentPage = page;
  }
}
