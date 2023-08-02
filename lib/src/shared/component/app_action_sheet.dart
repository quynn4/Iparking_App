
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ipacking_app/src/shared/config/routes/routes.dart';
import 'package:ipacking_app/src/shared/constants/colors_constans.dart';
import 'package:ipacking_app/src/shared/constants/text_style_constants.dart';


import '../../../generated/l10n.dart';

showActionSheetApp(BuildContext context,
    {String? message, List<Widget>? actions}) async {
  return await showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
            message: message != null
                ? Text(
                    message,
                    style: AppTextStyle.tabTextMedium.copyWith(fontSize: 14.sp),
                  )
                : null,
            actions: actions,
            cancelButton: CupertinoActionSheetAction(
              onPressed: () {
                Routes.instance.pop();
              },
              child: Text(
                S.current.lbl_cancel,
                style: AppTextStyle.heading2Bold
                    .apply(color: AppColors.systemBlueLight)
                    .copyWith(fontSize: 16.sp),
              ),
            ),
          ));
}
