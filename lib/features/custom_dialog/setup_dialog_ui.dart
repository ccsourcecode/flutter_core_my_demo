import 'basic_dialog.dart';
import 'model/dialog_type.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'locator.dart';

void setupDialogUi() {
  var dialogService = locator<DialogService>();

  var builders = {
    DialogType.Basic: (context, dialogRequest, completer) => Dialog(
          child: BasicCustomDialog(
            dialogRequest: dialogRequest,
            onDialogTap: completer,
          ),
        ),
    DialogType.Form: (context, dialogRequest, completer) => Dialog(
          child: FormCustomDialog(
            dialogRequest: dialogRequest,
            onDialogTap: completer,
          ),
        )
  };

  dialogService.registerCustomDialogBuilders(builders);
}
