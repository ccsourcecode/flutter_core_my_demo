import '../constants/ui_constants.dart';
import 'package:flutter/widgets.dart';

class HomeViewModel extends ChangeNotifier {
  static const int ItemRequestThreshold = 15;

  late List<String> _items;
  List<String> get items => _items;

  int _currentPage = 0;

  HomeViewModel() {
    _items = List<String>.generate(15, (index) => 'Title $index');
  }

  Future handleItemCreated(int index) async {
    var itemPosition = index + 1;
    // determine if we have to request new data
    // ensure the items are requested when the last item in the list is constructed
    var requestMoreData =
        itemPosition % ItemRequestThreshold == 0 && itemPosition != 0;
    // determine which page of results we're requesting
    var pageToRequest = itemPosition ~/ ItemRequestThreshold;
    // ensure we don't request the same data twice
    // pageToRequest is bigger than the current page =>
    // ensure that we won't do a request for something that's already been requested
    if (requestMoreData && pageToRequest > _currentPage) {
      print('handleItemCreated | pageToRequest: $pageToRequest');
      _currentPage = pageToRequest;
      _showLoadingIndicator();

      await Future.delayed(const Duration(seconds: 5));
      var newFetchedItems = List<String>.generate(
          15, (index) => 'Title page:$_currentPage item: $index');
      _items.addAll(newFetchedItems);

      _removeLoadingIndicator();
    }
  }

  void _showLoadingIndicator() {
    // add temp row
    _items.add(LoadingIndicatorTitle);
    notifyListeners();
  }

  void _removeLoadingIndicator() {
    // remove temp row
    _items.remove(LoadingIndicatorTitle);
    notifyListeners();
  }
}
