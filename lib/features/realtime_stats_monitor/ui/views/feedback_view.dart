import 'package:flutter/material.dart';
import '../../scoped_models/feedback_view_model.dart';
import '../../ui/shared/font_styles.dart';
import '../../ui/shared/ui_reducers.dart';
import '../../ui/views/base_view.dart';
import '../../ui/widgets/feedback_item.dart';
import '../../ui/widgets/watcher_toolbar.dart';

class FeedbackView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<FeedbackViewModel>(
        builder: (context, childe, model) => Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            body: Column(
              children: <Widget>[
                const WatcherToolbar(title: 'FEEDBACK', showBackButton: true),
                SizedBox(
                    height: screenHeight(context, decreasedBy: toolbarHeight),
                    child: _getBodyUi(context, model)),
              ],
            )));
  }

  Widget _getBodyUi(BuildContext context, FeedbackViewModel model) {
    switch (model.state) {
      case ViewState.Busy:
        return _getLoadingUi(context);
      case ViewState.NoDataAvailable:
        return _noDataUi(context, model);
      case ViewState.Error:
        return _errorUi(context, model);
      case ViewState.DataFetched:
      default:
        return _getListUi(model);
    }
  }

  Widget _getListUi(FeedbackViewModel model) {
    return ListView.builder(
        itemCount: model.userFeedback!.length,
        itemBuilder: (context, itemIndex) {
          var feedbackItem = model.userFeedback![itemIndex];
          return FeedbackItem(
              feedbackItem: feedbackItem,
              onOpened: (feedbackId) {
                model.markFeedbackAsRead(feedbackId: feedbackId);
              });
        });
  }

  Widget _getLoadingUi(BuildContext context) {
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        CircularProgressIndicator(
            valueColor:
                AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)),
        const Text('Fetching data ...')
      ],
    ));
  }

  Widget _noDataUi(BuildContext context, FeedbackViewModel model) {
    return _getCenteredViewMessage(context, "No data available yet", model);
  }

  Widget _errorUi(BuildContext context, FeedbackViewModel model) {
    return _getCenteredViewMessage(
        context, "Error retrieving your data. Tap to try again", model,
        error: true);
  }

  Widget _getCenteredViewMessage(
      BuildContext context, String message, FeedbackViewModel model,
      {bool error = false}) {
    return Center(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  message,
                  style: viewErrorTitle,
                  textAlign: TextAlign.center,
                ),
                error
                    ? const Icon(
                        // WWrap in gesture detector and call you refresh future here
                        Icons.refresh,
                        color: Colors.white,
                        size: 45.0,
                      )
                    : Container()
              ],
            )));
  }
}
