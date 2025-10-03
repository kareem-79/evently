import 'package:flutter/material.dart';
import '../resources/colors_manager.dart';

class UiUtils {
  static void showLoadingDialog(
    BuildContext context, {
    bool isDisable = false,
  }) {
    showDialog(
      barrierDismissible: isDisable,
      context: context,
      builder: (context) => PopScope(
        canPop: isDisable,
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 6,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [CircularProgressIndicator()],
          ),
        ),
      ),
    );
  }

  static void hideDialog(BuildContext context) {
    Navigator.pop(context);
  }

  static void showMassage(BuildContext context, String massage) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        content: Text(massage, style: Theme.of(context).textTheme.titleSmall,textAlign: TextAlign.center,),
      ),
    );
  }
}
