import 'dart:io';

import '../locator.dart';
import '../models/post.dart';
import '../services/analytics_service.dart';
import '../services/cloud_storage_service.dart';
import '../services/dialog_service.dart';
import '../services/firestore_service.dart';
import '../services/navigation_service.dart';
import '../utils/image_selector.dart';
import '../viewmodels/base_model.dart';

class CreatePostViewModel extends BaseModel {
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final ImageSelector _imageSelector = locator<ImageSelector>();
  final CloudStorageService _cloudStorageService =
      locator<CloudStorageService>();
  final AnalyticsService _analyticsService = locator<AnalyticsService>();

  late File _selectedImage;
  File get selectedImage => _selectedImage;

  Post? _editingPost;

  bool get _editing => _editingPost != null;

  Future selectImage() async {
    var tempImage = await _imageSelector.selectImage();
    if (tempImage != null) {
      _selectedImage = File(tempImage.path);
      notifyListeners();
    }
  }

  Future addPost({required String title}) async {
    setBusy(true);

    CloudStorageResult? storageResult;

    if (!_editing) {
      storageResult = await _cloudStorageService.uploadImage(
        imageToUpload: _selectedImage,
        title: title,
      );
    }

    var result;

    if (!_editing) {
      result = await _firestoreService.addPost(Post(
        title: title,
        userId: currentUser!.id,
        imageUrl: storageResult?.imageUrl,
        imageFileName: storageResult?.imageFileName,
      ));

      await _analyticsService.logPostCreated(hasImage: _selectedImage != null);
    } else {
      result = await _firestoreService.updatePost(Post(
        title: title,
        userId: _editingPost!.userId,
        documentId: _editingPost?.documentId,
        imageUrl: _editingPost?.imageUrl,
        imageFileName: _editingPost?.imageFileName,
      ));
    }

    setBusy(false);

    if (result is String) {
      await _dialogService.showDialog(
        title: 'Cound not create post',
        description: result,
      );
    } else {
      await _dialogService.showDialog(
        title: 'Post successfully Added',
        description: 'Your post has been created',
      );
    }

    _navigationService.pop();
  }

  void setEdittingPost(Post edittingPost) {
    _editingPost = edittingPost;
  }
}
