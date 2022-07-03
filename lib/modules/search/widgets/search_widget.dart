import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../models/character_model.dart';
import '../../../utils/colors.dart';

class SearchWidget extends StatelessWidget {
  final Results character;
  final void Function()? onTap;
  const SearchWidget({Key? key, required this.character, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        primary: Colors.transparent,
        padding: EdgeInsets.zero,
      ),
      onPressed: onTap,
      child: Column(
        children: [
          Container(
            height: 80.h,
            color: ColorsUtils.GRAY,
            child: Row(
              children: [
                SizedBox(
                  width: 90.w,
                  height: 80.h,
                  child: Image.network(
                      '${character.thumbnail!.path}/landscape_xlarge.${character.thumbnail!.extension}',
                      fit: BoxFit.fill),
                ),
                SizedBox(width: 15.w),
                Text(
                  '${character.name}',
                  style: const TextStyle(
                    color: ColorsUtils.WHITE,
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: ColorsUtils.LIGHT_GRAY.withOpacity(0.3),
            thickness: 0.9,
            height: 0,
          ),
        ],
      ),
    );
  }
}
