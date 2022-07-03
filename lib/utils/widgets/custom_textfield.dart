import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../colors.dart';

// ignore: must_be_immutable
class CustomTextField extends StatefulWidget {
  String? lablel;
  String? initialValue;
  Widget? icon;
  Widget? sufficIcon;
  Color? filledColor;
  bool isMobile;
  bool centerText;
  TextEditingController? controller;
  String? errorMessage;
  bool hasPassword;
  bool isEmail;
  bool? passwordIdentical;
  bool isPhoneCode;
  bool isFinal;
  bool isEditable;
  bool isNotes;
  bool hasBorder;
  Color lableColor;
  Color textColor;
  Color hintTextColor;
  String? Function(String?)? validator;
  void Function(String?)? onFieldSubmitted;
  int? maxLength;
  String? hintText;
  void Function(String)? onChanged;
  CustomTextField({
    Key? key,
    this.icon,
    this.lablel,
    this.initialValue,
    this.filledColor,
    this.hasBorder = true,
    this.isEditable = true,
    this.isNotes = false,
    this.centerText = false,
    this.isFinal = false,
    this.isPhoneCode = false,
    this.isMobile = false,
    this.isEmail = false,
    this.passwordIdentical,
    this.hasPassword = false,
    this.lableColor = Colors.grey,
    this.textColor = Colors.black,
    this.hintTextColor = Colors.black,
    this.controller,
    this.sufficIcon,
    this.errorMessage,
    this.validator,
    this.onFieldSubmitted,
    this.maxLength,
    this.hintText,
    this.onChanged,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool showPassword = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onFieldSubmitted: widget.onFieldSubmitted,
      validator: widget.validator,
      controller: widget.controller,
      enabled: widget.isEditable,
      textInputAction: TextInputAction.next,
      maxLength: widget.maxLength,
      onChanged: widget.onChanged,
      style: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w500,
        color: widget.textColor,
      ),
      initialValue: widget.initialValue,
      obscureText: (widget.hasPassword) ? showPassword : widget.hasPassword,
      maxLines: (widget.isNotes) ? 3 : 1,
      textAlign: (widget.centerText) ? TextAlign.center : TextAlign.left,
      keyboardType: (widget.isEmail)
          ? TextInputType.emailAddress
          : (widget.isMobile)
              ? TextInputType.phone
              : TextInputType.text,
      decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
            color: widget.hintTextColor,
          ),
          counter: const SizedBox(),
          contentPadding: const EdgeInsets.all(5),
          enabledBorder: (!widget.hasBorder)
              ? InputBorder.none
              : OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: ColorsUtils.WHITE)),
          disabledBorder: (!widget.hasBorder)
              ? InputBorder.none
              : OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: ColorsUtils.WHITE)),
          border: (!widget.hasBorder)
              ? InputBorder.none
              : OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: ColorsUtils.WHITE)),
          focusedBorder: (!widget.hasBorder)
              ? InputBorder.none
              : OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: ColorsUtils.WHITE)),
          labelText: widget.lablel,
          labelStyle: TextStyle(color: widget.lableColor),
          prefixIcon: (!widget.isPhoneCode) ? widget.icon : const SizedBox(),
          fillColor: (widget.filledColor == null)
              ? Colors.transparent
              : widget.filledColor,
          filled: true,
          suffixIcon: (widget.hasPassword)
              ? InkWell(
                  onTap: () {
                    showPassword = !showPassword;
                    setState(() {});
                  },
                  child: (!showPassword)
                      ? const Icon(Icons.visibility)
                      : const Icon(Icons.visibility_off),
                )
              : widget.sufficIcon),
    );
  }
}
