import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ipacking_app/src/shared/constants/colors_constans.dart';
import 'package:ipacking_app/src/shared/constants/text_style_constants.dart';

class AppButtonSuperSmall extends StatelessWidget {
  final String title;
  final Color? backgroundColor;
  final Color? disableColor;
  final Color? textColor;
  final IconData? icon;
  final bool isShowIcon;
  final VoidCallback? onPressed;

  const AppButtonSuperSmall(
      {Key? key,
      required this.title,
      this.backgroundColor,
      this.textColor,
      this.onPressed,
      this.disableColor,
      this.icon,
      this.isShowIcon = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            elevation: 0,
            padding: EdgeInsets.zero,
            side: BorderSide(width: 1, color: AppColors.borderColorLight),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ).copyWith(backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return backgroundColor ?? AppColors.buttonColorPrimary;
              } else if (states.contains(MaterialState.disabled)) {
                return disableColor ??
                    AppColors.buttonColorSecondary.withOpacity(0.2);
              }
              return backgroundColor ??
                  AppColors.buttonColorPrimary; // Use the component's default.
            },
          )),
          child: Stack(
            children: [
              isShowIcon == true
                  ? Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Icon(
                          icon,
                          size: 20,
                        ),
                      ),
                    )
                  : Container(),
              Center(
                child: Text(
                  title,
                  style: AppTextStyle.body1Bold.apply(color: textColor),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          )),
    );
  }
}
