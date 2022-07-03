import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marvel_preview/modules/characters/widgets/single_character_details_widgets.dart';
import 'package:marvel_preview/modules/characters/widgets/title_widget.dart';

import '../../../models/character_model.dart';

class CharacterDetailsWidgets extends StatelessWidget {
  final String title;
  final CommonData data;

  const CharacterDetailsWidgets({
    Key? key,
    required this.title,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 5.h, bottom: 8.h),
          child: TitleWidget(
            title: title,
          ),
        ),
        SizedBox(
          height: 140.h,
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: List.generate(data.items!.length, (index) {
              return SingleCharacterDetailsWidgets(
                index: index,
                data: data,
                zoomIn: false,
              );
            }),
          ),
        )
      ],
    );
  }
}
