import '../constants/ui_constants.dart';
import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  final String title;
  const ListItem({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 16,
              color: Colors.grey[400]!,
            ),
          ],
          borderRadius: BorderRadius.circular(5)),
      alignment: Alignment.center,
      child: title == LoadingIndicatorTitle
          ? const CircularProgressIndicator()
          : Text(title),
    );
  }
}
