import '../models/user_feedback.dart';
import '../services/firebase_service.dart';
import '../service_locator.dart';
import 'base_model.dart';

export '../enums/view_state.dart';

/// Contains logic for a list view with the general expected functionality.
class FeedbackViewModel extends BaseModel {
  final FirebaseService _firebaseService = locator<FirebaseService>();
  List<UserFeedback>? userFeedback;

  FeedbackViewModel() {
    _firebaseService.feedback.listen(_onFeedbackUpdated);
  }

  void markFeedbackAsRead({required String feedbackId}) {
    _firebaseService.markFeedbackAsRead(feedbackId: feedbackId);
  }

  void _onFeedbackUpdated(List<UserFeedback> feedback) {
    userFeedback = feedback;

    if (userFeedback == null) {
      setState(ViewState.Busy);
    } else {
      setState(userFeedback!.isEmpty
          ? ViewState.NoDataAvailable
          : ViewState.DataFetched);
    }
  }
}
