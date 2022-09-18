import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../custom_dialog/locator.dart';
import '../logger/log_printer.dart';

class LottieAppModel extends BaseViewModel {
  final log = getLogger('LottieAppModel');
  final _navigationService = locator<NavigationService>();
  bool _animationComplete = false;
  String? _destinationRoute;
  dynamic _destinationArguments;

  Future initialise() async {
    // start up loading config here
    // await _database.initialise();
    // await _userService.initialise();

    if ('_userService.currentAddress' != null) {
      await _replaceWith(route: 'homeView');
    } else {
      await _replaceWith(route: 'welcomeView');
    }
  }

  Future _replaceWith({String? route, dynamic arguments}) async {
    // If logic finishes first we want to store the route and arguments that we wanted
    // to navigate to when the animation completes.
    var hasDestinationRoute = _destinationRoute != null;
    var hasDestinationArguments = _destinationArguments != null;

    // Set the route only if we don't have a route
    if (!hasDestinationRoute) {
      _destinationRoute = route;
    }

    // set the arguments only if we don't have arguments
    if (!hasDestinationArguments) {
      _destinationArguments = arguments;
    }

    // navigate only if the animation is complete
    if (_animationComplete && _destinationRoute != null) {
      await _navigationService.replaceWith(
        _destinationRoute!,
        arguments: _destinationArguments,
      );
    }
  }

  Future indicateAnimationComplete() async {
    _animationComplete = true;
    await _replaceWith();
  }
}
