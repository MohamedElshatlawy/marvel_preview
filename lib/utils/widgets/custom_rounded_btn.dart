import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomRoundedButton extends StatelessWidget {
  String? text;
  Function? pressed;
  Color? backgroundColor;
  Color? textColor;
  Color? borderColor;
  Icon? icon;
  double? elevation;
  bool? home;
  CustomRoundedButton({
    Key? key,
    this.pressed,
    this.text,
    this.backgroundColor,
    this.borderColor,
    this.icon,
    this.textColor,
    this.elevation,
    this.home,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      // width: ScreenUtil().screenWidth,
      child: RaisedButton(
        elevation: elevation!,
        shape: RoundedRectangleBorder(
            borderRadius: home == true
                ? const BorderRadius.only(
                    bottomLeft: Radius.circular(80),
                    topLeft: Radius.circular(80),
                    topRight: Radius.circular(80),
                  )
                : BorderRadius.circular(15),
            side: BorderSide(color: borderColor!)),
        color: backgroundColor,
        onPressed: pressed as void Function()? ?? () {},
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              (icon == null)
                  ? const SizedBox()
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        icon!,
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
              FittedBox(
                fit: BoxFit.fill,
                child: Text(
                  text!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.w800,
                      fontSize: ScreenUtil().setSp(15)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
