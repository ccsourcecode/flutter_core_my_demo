import 'package:core_example/features/design_system/ui_library.dart';
import 'package:flutter/material.dart';

import 'ui_helpers.dart';

class ExampleView extends StatelessWidget {
  const ExampleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
        children: [
          const BoxText.headingOne('Design System'),
          verticalSpaceSmall,
          const Divider(),
          verticalSpaceSmall,
          ...buttonWidgets,
          ...textWidgets,
          ...inputFields,
          ...autoCompleteListItem
        ],
      ),
    );
  }

  List<Widget> get autoCompleteListItem =>
      [const AutoCompleteListItem(state: 'state', city: 'city')];

  List<Widget> get textWidgets => [
        const BoxText.headline('Text Styles'),
        verticalSpaceMedium,
        const BoxText.headingOne('Heading One'),
        verticalSpaceMedium,
        const BoxText.headingTwo('Heading Two'),
        verticalSpaceMedium,
        const BoxText.headingThree('Heading Three'),
        verticalSpaceMedium,
        const BoxText.headline('Headline'),
        verticalSpaceMedium,
        const BoxText.subheading('This will be a sub heading to the headling'),
        verticalSpaceMedium,
        BoxText.body('Body Text that will be used for the general body'),
        verticalSpaceMedium,
        const BoxText.caption(
            'This will be the caption usually for smaller details'),
        verticalSpaceMedium,
      ];

  List<Widget> get buttonWidgets => [
        const BoxText.headline('Buttons'),
        verticalSpaceMedium,
        BoxText.body('Normal'),
        verticalSpaceSmall,
        const BoxButton(
          title: 'SIGN IN',
        ),
        verticalSpaceSmall,
        BoxText.body('Disabled'),
        verticalSpaceSmall,
        const BoxButton(
          title: 'SIGN IN',
          disabled: true,
        ),
        verticalSpaceSmall,
        BoxText.body('Busy'),
        verticalSpaceSmall,
        const BoxButton(
          title: 'SIGN IN',
          busy: true,
        ),
        verticalSpaceSmall,
        BoxText.body('Outline'),
        verticalSpaceSmall,
        const BoxButton.outline(
          title: 'Select location',
          leading: Icon(
            Icons.send,
            color: kcPrimaryColor,
          ),
        ),
        verticalSpaceMedium,
      ];

  List<Widget> get inputFields => [
        const BoxText.headline('Input Field'),
        verticalSpaceSmall,
        BoxText.body('Normal'),
        verticalSpaceSmall,
        BoxInputField(
          controller: TextEditingController(),
          placeholder: 'Enter Password',
        ),
        verticalSpaceSmall,
        BoxText.body('Leading Icon'),
        verticalSpaceSmall,
        BoxInputField(
          controller: TextEditingController(),
          leading: const Icon(Icons.reset_tv),
          placeholder: 'Enter TV Code',
        ),
        verticalSpaceSmall,
        BoxText.body('Trailing Icon'),
        verticalSpaceSmall,
        BoxInputField(
          controller: TextEditingController(),
          trailing: const Icon(Icons.clear_outlined),
          placeholder: 'Search for things',
        ),
      ];
}
