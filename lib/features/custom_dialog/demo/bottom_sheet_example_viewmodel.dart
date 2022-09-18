import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../locator.dart';
import '../model/bottom_sheet_type.dart';

class BottomSheetExampleViewModel extends BaseViewModel {
  final _bottomSheetService = locator<BottomSheetService>();
  bool? _confirmationResult;
  bool? get confirmationResult => _confirmationResult;

  Future showBasicBottomSheet() async {
    await _bottomSheetService.showBottomSheet(
      title: 'The basic bottom sheet',
      description:
          'Use this bottom sheet function to show something to the user. It\'s better than the standard alert dialog in terms of UI quality.',
    );
  }

  Future showConfirmationBottomSheet() async {
    var sheetResponse = await _bottomSheetService.showBottomSheet(
      title: 'Confirmation of Terms',
      description:
          'I want to use this sheet to confirm some information from you. Is it okay?',
      confirmButtonTitle: 'I confirm this action',
      cancelButtonTitle: 'I dont accept the terms above',
    );

    print('Confirmed: ${sheetResponse?.confirmed}');

    _confirmationResult = sheetResponse?.confirmed;
    notifyListeners();
  }

  Future showCustomBottomSheet() async {
    var sheetResponse = await _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.floating,
      title: 'This is a floating bottom sheet',
      description:
          'This sheet is a custom built bottom sheet UI that allows you to show it from any service or viewmodel.',
      mainButtonTitle: 'Awesome!',
      secondaryButtonTitle: 'This is cool',
    );

    print('confirmationResponse confirmed: ${sheetResponse?.confirmed}');
  }
}
