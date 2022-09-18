import 'dart:async';

import 'package:flutter/material.dart';
import '../../models/user_feedback.dart';
import '../../ui/shared/app_colors.dart';

import 'feedback_label.dart';

class FeedbackItem extends StatefulWidget {
  final Function(String) onOpened;

  const FeedbackItem({
    required this.feedbackItem,
    required this.onOpened,
  });

  final UserFeedback feedbackItem;

  @override
  _FeedbackItemState createState() => _FeedbackItemState();
}

class _FeedbackItemState extends State<FeedbackItem> {
  double _height = 70.0;
  bool _showDetails = false;

  static const double descriptionPadding = 15.0;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeIn,
      width: double.infinity,
      height: _height,
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0), color: darkGrey),
      child: Row(
        children: <Widget>[_detailsSection, _notificationSection],
      ),
    );
  }

  Widget get _detailsSection => Expanded(
          child: GestureDetector(
        onTap: () {
          setState(() {
            if (!_showDetails) {
              _height = 190;
            } else {
              _height = 70.0;
            }
          });

          Timer.periodic(const Duration(milliseconds: 150), (timer) {
            timer.cancel();

            widget.onOpened(widget.feedbackItem.id);

            setState(() {
              _showDetails = !_showDetails;
            });
          });
        },
        child: Container(
          color: darkGrey,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(widget.feedbackItem.title,
                  maxLines: 1,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              _showDetails
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: descriptionPadding),
                      child: Text(widget.feedbackItem.details),
                    )
                  : Container(),
              Expanded(
                  child: Align(
                      alignment: Alignment.bottomLeft,
                      child: FeedbackLabel(type: widget.feedbackItem.type)))
            ],
          ),
        ),
      ));

  Widget get _notificationSection => SizedBox(
      width: 50.0,
      child: Column(children: <Widget>[
        !widget.feedbackItem.read
            ? Container(
                width: 20,
                height: 20,
                decoration: const ShapeDecoration(
                    shape: CircleBorder(), color: primaryColor))
            : Container(),
        const Expanded(
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Text('Today',
                    style: TextStyle(
                        color: lightGrey,
                        fontWeight: FontWeight.bold,
                        fontSize: 9.0))))
      ]));
}
