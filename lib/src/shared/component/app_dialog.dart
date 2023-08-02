

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../injection_container.dart';
import '../blocs_app/bloc/authentication_bloc.dart';
import '../constants/colors_constans.dart';
import '../constants/enums_constants.dart';
import '../constants/text_style_constants.dart';


Future<dynamic> showSimpleDialogApp(BuildContext context, Widget child) {
  return showDialog(
    barrierDismissible: true,
    context: context,
    builder: (_) => Padding(
      padding: const EdgeInsets.all(8.0),
      child: Dialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(0),
        child: Container(
          child: child,
        ),
      ),
    ),
  );
}


Future<dynamic> showErrDialogApp({
  required BuildContext context,
  required String title,
  required String content,
  String? deleteActionText,
  required String defaultActionText,
  VoidCallback? onPressed,
}) {
  return showDialog(
    useRootNavigator: true,
    barrierDismissible: false,
    context: context,
    builder: (_) => BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
      return CupertinoAlertDialog(
        title: Text(
          title,
          style: AppTextStyle.body1Bold,
        ),
        content: Text(
          content,
          style: AppTextStyle.caption2,
          textAlign: TextAlign.center,
        ),
        actions: [
          CupertinoDialogAction(
            child: Text(
              defaultActionText,
              style: AppTextStyle.body1Medium
                  .copyWith(color: AppColors.selectedColor),
            ),
            onPressed: () {

              if (state.status == AuthenticationStatus.errAuthenticated) {
                getIt<AuthenticationBloc>()
                    .add(AuthenticationLogoutRequested());
              } else {
                Navigator.of(context).pop(true);
              }
            },
          ),
          if (deleteActionText != null)
            CupertinoDialogAction(
              onPressed: onPressed,
              child: Text(
                deleteActionText,
                style: AppTextStyle.body1Bold
                    .copyWith(color: AppColors.selectedColor),
              ),
            ),
        ],
      );
    }),
  );
}

Future<dynamic> showDialogApp({
  required BuildContext context,
  required String title,
  required String content,
  String? deleteActionText,
  required String defaultActionText,
  VoidCallback? onDeletePressed,
  VoidCallback? onDefaultPressed,
}) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (_) => CupertinoAlertDialog(
      title: Text(
        title,
        style: AppTextStyle.body1Bold,
      ),
      content: Text(
        content,
        style: AppTextStyle.caption2,
        textAlign: TextAlign.center,
      ),
      actions: [
        CupertinoDialogAction(
          onPressed: onDefaultPressed,
          child: Text(
            defaultActionText,
            style: AppTextStyle.body1Medium
                .copyWith(color: AppColors.selectedColor),
          ),
        ),
        if (deleteActionText != null)
          CupertinoDialogAction(
            onPressed: onDeletePressed,
            child: Text(
              deleteActionText,
              style: AppTextStyle.body1Bold
                  .copyWith(color: AppColors.selectedColor),
            ),
          ),
      ],
    ),
  );
}
