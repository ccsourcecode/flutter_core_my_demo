import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/post.dart';
import '../models/user.dart';
import 'package:flutter/services.dart';

class FirestoreService {
  final CollectionReference _usersCollectionReference =
      FirebaseFirestore.instance.collection('users');

  final CollectionReference _postsCollectionReference =
      FirebaseFirestore.instance.collection('posts');

  final StreamController<List<Post>> _postsController =
      StreamController<List<Post>>.broadcast();

  Future createUser(User user) async {
    try {
      await _usersCollectionReference.doc(user.id).set(user.toJson());
    } catch (e) {
      // TODO: Find or create a way to repeat error handling without so much repeated code
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }

  Future getUser(String? uid) async {
    try {
      var userData = await _usersCollectionReference.doc(uid).get();
      return User.fromData(userData.data as Map<String, dynamic>);
    } catch (e) {
      // TODO: Find or create a way to repeat error handling without so much repeated code
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }

  Future addPost(Post post) async {
    try {
      await _postsCollectionReference.add(post.toMap());
    } catch (e) {
      // TODO: Find or create a way to repeat error handling without so much repeated code
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }

  Future getPostsOnceOff() async {
    try {
      // Get docs from collection reference
      var postDocumentSnapshot = await _postsCollectionReference.get();
      if (postDocumentSnapshot.docs.isNotEmpty) {
        // Get data from docs and convert map to List
        return postDocumentSnapshot.docs
            .map((snapshot) => Post.fromMap(
                snapshot.data() as Map<String, dynamic>, snapshot.id))
            .where((mappedItem) => mappedItem?.title != null)
            .toList();
      }
    } catch (e) {
      // TODO: Find or create a way to repeat error handling without so much repeated code
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }

  Stream listenToPostsRealTime() {
    // Register the handler for when the posts data changes
    _postsCollectionReference.snapshots().listen((postsSnapshot) {
      if (postsSnapshot.docs.isNotEmpty) {
        var posts = postsSnapshot.docs
            .map((snapshot) => Post.fromMap(
                snapshot.data() as Map<String, dynamic>, snapshot.id))
            .where((mappedItem) => mappedItem?.title != null)
            .toList() as List<Post>;

        // Add the posts onto the controller
        _postsController.add(posts);
      }
    });

    return _postsController.stream;
  }

  Future deletePost(String documentId) async {
    await _postsCollectionReference.doc(documentId).delete();
  }

  Future updatePost(Post post) async {
    try {
      await _postsCollectionReference.doc(post.documentId).update(post.toMap());
    } catch (e) {
      // TODO: Find or create a way to repeat error handling without so much repeated code
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }
}
