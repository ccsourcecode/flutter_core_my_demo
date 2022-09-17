import 'package:core_example/features/design_system/ui_library.dart';
import 'package:flutter/material.dart';

class AutoCompleteListItem extends StatelessWidget {
  final String state, city;
  final Function? onTap;

  const AutoCompleteListItem(
      {Key? key, required this.state, required this.city, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: const Icon(
            Icons.near_me,
            color: kcMediumGreyColor,
          ),
          onTap: () => onTap!(),
          title: BoxText.subheading(city),
          subtitle: BoxText.caption(state),
        ),
        const Divider(
          indent: 50,
        )
      ],
    );
  }
}
