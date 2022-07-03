import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/colors.dart';
import 'clip_triangle.dart';

class CharacterWidget extends StatelessWidget {
  final String imageUrl;
  final String characterName;
  final bool internetConnection;
  final void Function()? onTap;
  const CharacterWidget(
      {Key? key,
      this.onTap,
      required this.internetConnection,
      required this.characterName,
      required this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          SizedBox(
            height: 165.h,
            width: double.infinity,
            child: internetConnection
                ? Image.network(
                    imageUrl,
                    fit: BoxFit.fill,
                  )
                : Image.file(
                    File(imageUrl),
                    fit: BoxFit.fill,
                  ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 15.h, left: 5.w),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Stack(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(horizontal: 30.w),
                      decoration: const BoxDecoration(
                        color: ColorsUtils.WHITE,
                      ),
                      height: 30.h,
                      width: 130.w,
                    ),
                    Positioned(
                      left: 10.w,
                      child: const Triangle(),
                    ),
                    Positioned(
                      right: 10.w,
                      child: Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.rotationX(math.pi),
                        child: const Triangle(),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 140,
                  child: Text(
                    characterName,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: ColorsUtils.BLACK, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
