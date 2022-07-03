import 'package:flutter/material.dart';

import '../../../utils/colors.dart';

class TitleWidget extends StatelessWidget {
  final String title;
  bool? details;
  TextAlign? textAlign;
  TitleWidget({Key? key, required this.title, this.details, this.textAlign})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: textAlign ?? TextAlign.start,
      style: TextStyle(
        color: details == null ? ColorsUtils.RED : ColorsUtils.WHITE,
        fontWeight: FontWeight.bold,
        fontSize: details == null ? 15 : 20,
      ),
    );
  }
}
