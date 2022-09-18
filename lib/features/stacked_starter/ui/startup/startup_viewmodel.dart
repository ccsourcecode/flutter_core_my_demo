import '../../app/app.locator.dart';
import '../../app/app.logger.dart';

import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/app.router.dart';

class StartUpViewModel extends BaseViewModel {
  final log = getLogger('StartUpViewModel');

  final _navigationService = locator<NavigationService>();

  void doSomething() {
    _navigationService.navigateTo(Routes.secondView);
  }
}
