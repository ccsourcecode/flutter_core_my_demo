import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'bottom_sheet_example_viewmodel.dart';

class BottomSheetExampleView extends StatelessWidget {
  const BottomSheetExampleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BottomSheetExampleViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                child: const Text('Show Basic BottomSheet'),
                onPressed: () => model.showBasicBottomSheet(),
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                child: const Text('Show Confirmation BottomSheet'),
                onPressed: () => model.showConfirmationBottomSheet(),
              ),
              Text('Confirmation result: ${model.confirmationResult}'),
              const SizedBox(height: 25),
              ElevatedButton(
                child: const Text('Show Custom BottomSheet'),
                onPressed: () => model.showCustomBottomSheet(),
              ),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => BottomSheetExampleViewModel(),
    );
  }
}
