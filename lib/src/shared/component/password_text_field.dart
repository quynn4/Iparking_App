import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dartz/dartz.dart' as Dartz;

import '../constants/colors_constans.dart';
import '../constants/dimens_constants.dart';
import '../constants/icons_constants.dart';
import '../constants/text_style_constants.dart';
import '../utils/valid_text_field.dart';


class CommonPasswordTextFormField extends StatefulWidget {
  final String hint;
  final String? prefixIconPath;
  final String? suffixIconPath;
  final String? labelText;
  final TextInputType keyboardType;
  final bool isVisiblePassword;
  final GestureTapCallback? onSuffixIconTap;
  final GestureTapCallback? onPrefixIconTap;
  final TextInputAction textInputAction;
  final ValueChanged<String>? onChanged;
  final OnValidate? onValidate;
  final TextEditingController controller;
  final String? errorMessage;

  const CommonPasswordTextFormField(
      {Key? key,
      required this.hint,
      this.prefixIconPath,
      this.labelText,
      this.keyboardType = TextInputType.visiblePassword,
      this.isVisiblePassword = true,
      this.onPrefixIconTap,
      this.textInputAction = TextInputAction.done,
      this.onChanged,
      this.onValidate,
      required this.controller,
      this.errorMessage,
      this.suffixIconPath,
      this.onSuffixIconTap})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CommonPasswordTextFormFieldState();
  }
}

class _CommonPasswordTextFormFieldState
    extends State<CommonPasswordTextFormField> {
  String? hint;
  String? prefixIconPath;
  String? labelText;
  TextInputType? keyboardType;
  bool isVisiblePassword = true;
  GestureTapCallback? onPrefixIconTap;
  GestureTapCallback? onSuffixIconTap;
  String? suffixIconPath;
  TextInputAction? textInputAction;
  ValueChanged<String>? onChanged;
  OnValidate? onValidate;
  TextEditingController? controller;
  String? errorMessage;

  @override
  void initState() {
    hint = widget.hint;
    prefixIconPath = widget.prefixIconPath;
    labelText = widget.labelText;
    keyboardType = widget.keyboardType;
    isVisiblePassword = widget.isVisiblePassword;
    onPrefixIconTap = widget.onPrefixIconTap;
    textInputAction = widget.textInputAction;
    onValidate = widget.onValidate;
    onChanged = widget.onChanged;
    controller = widget.controller;
    errorMessage = widget.errorMessage;
    suffixIconPath = widget.suffixIconPath;
    onSuffixIconTap = widget.onSuffixIconTap;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final GestureDetector? prefixIcon;
    if (suffixIconPath != null) {
      prefixIcon = GestureDetector(
          onTap: onSuffixIconTap,
          child: SizedBox(
              height: AppDimens.buttonSize,
              child: SvgPicture.asset(
                suffixIconPath!,
                fit: BoxFit.scaleDown,
              )));
    } else {
      prefixIcon = null;
    }
    final Widget suffixIcon;
    if (prefixIconPath != null) {
      suffixIcon = GestureDetector(
          onTap: onPrefixIconTap,
          child: SizedBox(
              height: AppDimens.buttonSize,
              child: SvgPicture.asset(
                prefixIconPath!,
                fit: BoxFit.scaleDown,
              )));
    } else {
      suffixIcon = Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround, // added line
        children: [
          controller!.text.isNotEmpty
              ? IconButton(
                  icon: Icon(
                    isVisiblePassword ? Icons.visibility : Icons.visibility_off,
                    color: AppColors.textColorDisabled,
                  ),
                  onPressed: () {
                    setState(() {
                      isVisiblePassword = !isVisiblePassword;
                    });
                  },
                )
              : Container(),
          controller!.text.isNotEmpty
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      controller!.clear();
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                        right: AppDimensPadding.contentPadding.w),
                    child: SizedBox(
                        height: AppDimens.buttonSize,
                        child: SvgPicture.asset(
                          AppIcons.iconClose,
                          fit: BoxFit.scaleDown,
                        )),
                  ))
              : Container(),
        ],
      );
    }
    return TextFormField(
      validator: (value) {
        if (onValidate != null && value != null) {
          return onValidate!(value).fold((l) => l.errorMessage, (r) => null);
        }
        return null;
      },
      style: AppTextStyle.placeHolder.apply(color: AppColors.textColorPrimary),
      autovalidateMode: AutovalidateMode.disabled,
      decoration: InputDecoration(
          hintStyle: AppTextStyle.placeHolder
              .apply(color: AppColors.textColorSecondary),
          contentPadding: const EdgeInsets.all(AppDimensPadding.contentPadding),
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          labelStyle: AppTextStyle.placeHolder
              .apply(color: AppColors.textColorSecondary),
          errorText: errorMessage,
          errorStyle: AppTextStyle.caption2.apply(color: AppColors.errColor),
          errorMaxLines: AppDimensOther.maxLineErrorText,
          hintText: hint,
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(AppDimensPadding.contentPadding.sp),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: AppColors.inputColorFocused, width: 1.5),
            borderRadius:
                BorderRadius.circular(AppDimensPadding.contentPadding.sp),
          )),
      controller: controller,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      obscureText: !isVisiblePassword,
      onChanged: (value) {
        if (onChanged != null) {
          onChanged!(value);
        }
        // validate(value);
      },
    );
  }

  void validate(String value) {
    Dartz.Either<Invalid, Valid> result = getValidateResult(value);
    setState(() {
      errorMessage =
          result.fold((invalid) => invalid.errorMessage, (valid) => null);
    });
  }

  Dartz.Either<Invalid, Valid> getValidateResult(String value) {
    if (widget.onValidate != null) {
      return widget.onValidate!(value);
    }
    return Dartz.Right(Valid());
  }
}
