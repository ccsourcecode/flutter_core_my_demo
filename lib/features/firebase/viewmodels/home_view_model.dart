import '../constants/route_names.dart';
import '../locator.dart';
import '../models/post.dart';
import '../services/cloud_storage_service.dart';
import '../services/dialog_service.dart';
import '../services/firestore_service.dart';
import '../services/navigation_service.dart';
import '../viewmodels/base_model.dart';

class HomeViewModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final DialogService _dialogService = locator<DialogService>();
  final CloudStorageService _cloudStorageService =
      locator<CloudStorageService>();

  List<Post>? _posts;
  List<Post>? get posts => _posts;

  void listenToPosts() {
    setBusy(true);

    _firestoreService.listenToPostsRealTime().listen((postsData) {
      List<Post> updatedPosts = postsData;
      if (updatedPosts.isNotEmpty) {
        _posts = updatedPosts;
        notifyListeners();
      }

      setBusy(false);
    });
  }

  Future deletePost(int index) async {
    var dialogResponse = await _dialogService.showConfirmationDialog(
      title: 'Are you sure?',
      description: 'Do you really want to delete the post?',
      confirmationTitle: 'Yes',
      cancelTitle: 'No',
    );

    if (dialogResponse.confirmed) {
      var postToDelete = _posts![index];
      setBusy(true);
      await _firestoreService.deletePost(postToDelete.documentId!);
      // Delete the image after the post is deleted
      await _cloudStorageService.deleteImage(postToDelete.imageFileName!);
      setBusy(false);
    }
  }

  Future navigateToCreateView() async {
    await _navigationService.navigateTo(CreatePostViewRoute);
  }

  void editPost(int index) {
    _navigationService.navigateTo(CreatePostViewRoute,
        arguments: _posts![index]);
  }
}
