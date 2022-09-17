import '../../models/post.dart';
import '../shared/ui_helpers.dart';
import '../widgets/input_field.dart';
import '../../viewmodels/create_post_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class CreatePostView extends StatelessWidget {
  final titleController = TextEditingController();
  final Post editingPost;
  CreatePostView({Key? key, required this.editingPost}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CreatePostViewModel>.reactive(
      viewModelBuilder: () => CreatePostViewModel(),
      onModelReady: (model) {
        // update the text in the controller
        titleController.text = editingPost.title ?? '';

        model.setEdittingPost(editingPost);
      },
      builder: (context, model, child) => Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (!model.busy) {
                model.addPost(title: titleController.text);
              }
            },
            backgroundColor:
                !model.busy ? Theme.of(context).primaryColor : Colors.grey[600],
            child: !model.busy
                ? const Icon(Icons.add)
                : const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                verticalSpace(40),
                const Text(
                  'Create Post',
                  style: TextStyle(fontSize: 26),
                ),
                verticalSpaceMedium,
                InputField(
                  placeholder: 'Title',
                  controller: titleController,
                ),
                verticalSpaceMedium,
                const Text('Post Image'),
                verticalSpaceSmall,
                GestureDetector(
                  // When we tap we call selectImage
                  onTap: () => model.selectImage(),
                  child: Container(
                    height: 250,
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10)),
                    alignment: Alignment.center,
                    // If the selected image is null we show "Tap to add post image"
                    child: model.selectedImage == null
                        ? Text(
                            'Tap to add post image',
                            style: TextStyle(color: Colors.grey[400]),
                          )
                        // If we have a selected image we want to show it
                        : Image.file(model.selectedImage),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
