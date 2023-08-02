import 'package:dartz/dartz.dart' as Dartz;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/colors_constans.dart';
import '../constants/dimens_constants.dart';
import '../constants/icons_constants.dart';
import '../constants/text_style_constants.dart';
import '../utils/valid_text_field.dart';

class CommonInputTextFormField extends StatefulWidget {
  final String hint;
  final String? prefixIconPath;
  final String? suffixIconPath;
  final String? labelText;
  final TextInputType keyboardType;
  final GestureTapCallback? onSuffixIconTap;
  final GestureTapCallback? onPrefixIconTap;
  final TextInputAction textInputAction;
  final ValueChanged<String>? onChanged;
  final OnValidate? onValidate;
  final TextEditingController controller;
  final bool? isReadOnly;
  final double? borderRadius;
  final FocusNode? focusNode;
  final EdgeInsetsGeometry? contentPadding;
  final List<TextInputFormatter>? inputFormat;

  const CommonInputTextFormField(
      {Key? key,
      required this.hint,
      this.prefixIconPath,
      this.suffixIconPath,
      this.labelText,
      this.keyboardType = TextInputType.text,
      this.onSuffixIconTap,
      this.onPrefixIconTap,
      required this.textInputAction,
      this.onChanged,
      this.onValidate,
      required this.controller,
      this.isReadOnly,
      this.borderRadius,
      this.focusNode,
      this.inputFormat,
      this.contentPadding})
      : super(key: key);

  @override
  State<CommonInputTextFormField> createState() =>
      _CommonInputTextFormFieldState();
}

class _CommonInputTextFormFieldState extends State<CommonInputTextFormField> {
  String? errorMessage;
  bool isReadOnly = false;
  bool isShowSuffixIcon = false;

  @override
  void initState() {
    if (widget.isReadOnly != null) {
      isReadOnly = widget.isReadOnly!;
    }
    widget.controller.addListener(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final GestureDetector? prefixIcon;
    if (widget.suffixIconPath != null) {
      prefixIcon = GestureDetector(
          onTap: widget.onSuffixIconTap,
          child: SizedBox(
              height: AppDimens.buttonSize,
              child: SvgPicture.asset(
                widget.suffixIconPath!,
                fit: BoxFit.scaleDown,
              )));
    } else {
      prefixIcon = null;
    }
    final Widget? suffixIcon;
    if (widget.prefixIconPath != null) {
      suffixIcon = GestureDetector(
          onTap: widget.onPrefixIconTap,
          child: SizedBox(
              height: AppDimens.buttonSize,
              child: SvgPicture.asset(
                widget.prefixIconPath!,
                fit: BoxFit.scaleDown,
              )));
    } else {
      suffixIcon = isShowSuffixIcon
          ? Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                widget.controller.text != ''
                    ? GestureDetector(
                        onTap: () {
                          setState(() {
                            widget.controller.clear();
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
            )
          : null;
    }
    return Focus(
      onFocusChange: (hasFocus) {
        if (hasFocus) {
          isShowSuffixIcon = true;
        } else {
          isShowSuffixIcon = false;
        }
        setState(() {});
      },
      child: TextFormField(
        autocorrect: false,
        inputFormatters: widget.inputFormat,
        validator: (value) {
          if (widget.onValidate != null && value != null) {
            return widget.onValidate!(value)
                .fold((l) => l.errorMessage, (r) => null);
          }
          return null;
        },
        style:
            AppTextStyle.placeHolder.apply(color: AppColors.textColorPrimary),
        autovalidateMode: AutovalidateMode.disabled,
        readOnly: isReadOnly,
        focusNode: widget.focusNode,
        decoration: InputDecoration(
            hintStyle: AppTextStyle.placeHolder
                .apply(color: AppColors.textColorSecondary),
            contentPadding: widget.contentPadding ??
                const EdgeInsets.all(AppDimensPadding.contentPadding),
            suffixIcon: !isReadOnly ? suffixIcon : null,
            prefixIcon: prefixIcon,
            labelStyle: AppTextStyle.placeHolder
                .apply(color: AppColors.textColorSecondary),
            errorText: errorMessage,
            errorStyle: AppTextStyle.caption2.apply(color: AppColors.errColor),
            errorMaxLines: AppDimensOther.maxLineErrorText,
            hintText: widget.hint,
            labelText: widget.labelText,
            border: OutlineInputBorder(
              borderRadius: widget.borderRadius != null
                  ? BorderRadius.circular(widget.borderRadius ?? 0)
                  : BorderRadius.circular(AppDimensPadding.contentPadding.sp),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: AppColors.inputColorFocused, width: 1.5),
              borderRadius: widget.borderRadius != null
                  ? BorderRadius.circular(widget.borderRadius ?? 0)
                  : BorderRadius.circular(AppDimensPadding.contentPadding.sp),
            )),
        controller: widget.controller,
        textInputAction: widget.textInputAction,
        keyboardType: widget.keyboardType,
        onChanged: (value) {
          if (widget.onChanged != null) {
            widget.onChanged!(value);
          }
          if (widget.keyboardType != TextInputType.emailAddress) {
            validate(value);
          }
        },
      ),
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
