import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../models/character_model.dart';
import '../../../providers/character_details_provider.dart';
import '../../../utils/colors.dart';
import '../zoom_in_details.dart';

class SingleCharacterDetailsWidgets extends ConsumerStatefulWidget {
  final int index;
  final CommonData data;
  final bool zoomIn;

  SingleCharacterDetailsWidgets({
    Key? key,
    required this.index,
    required this.data,
    required this.zoomIn,
  }) : super(key: key);

  @override
  _SingleCharacterDetailsWidgetsState createState() =>
      _SingleCharacterDetailsWidgetsState();
}

class _SingleCharacterDetailsWidgetsState
    extends ConsumerState<SingleCharacterDetailsWidgets> {
  @override
  Widget build(BuildContext context) {
    final characterDetails = ref.watch(characterDetailsProvider);

    return FutureBuilder<dynamic>(
      future: characterDetails.getCharacterDetail(
        endPoint: widget.data.items![widget.index].resourceURI!,
      ),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Padding(
              padding: EdgeInsets.only(
                right: 8.w,
              ),
              child: SizedBox(
                height: 100.h,
                width: 85.w,
                child: Center(
                    child: CircularProgressIndicator(
                  color: widget.zoomIn ? ColorsUtils.RED : ColorsUtils.BLACK,
                )),
              ),
            );
          default:
            if (snapshot.hasError) {
              return Padding(
                padding: EdgeInsets.only(
                  right: 8.w,
                ),
                child: SizedBox(
                  height: 100.h,
                  width: 85.w,
                  child: const Center(
                      child: Icon(
                    Icons.error,
                    color: ColorsUtils.RED,
                  )),
                ),
              );
            } else {
              return Padding(
                padding: widget.zoomIn
                    ? EdgeInsets.symmetric(horizontal: 10.w)
                    : EdgeInsets.only(
                        right: 8.w,
                      ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    primary: Colors.transparent,
                    padding: EdgeInsets.zero,
                  ),
                  onPressed: widget.zoomIn
                      ? null
                      : () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ZoomInDetails(
                                initialPage: widget.index,
                                data: widget.data,
                              ),
                            ),
                          );
                        },
                  child: Container(
                    color: widget.zoomIn
                        ? ColorsUtils.DARK_GRAY
                        : Colors.transparent,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: widget.zoomIn
                              ? MediaQuery.of(context).size.height - 300.h
                              : 100.h,
                          width: widget.zoomIn
                              ? MediaQuery.of(context).size.width - 18.w
                              : 95.w,
                          child:
                              snapshot.data!.data!.results!.first.thumbnail !=
                                      null
                                  ? Image.network(
                                      '${snapshot.data!.data!.results!.first.thumbnail!.path}/standard_xlarge.${snapshot.data!.data!.results!.first.thumbnail!.extension}',
                                      fit: BoxFit.fill,
                                    )
                                  : Image.asset(
                                      'assets/icn-nav-marvel.png',
                                      fit: BoxFit.fill,
                                    ),
                        ),
                        if (widget.zoomIn) ...[
                          SizedBox(height: 18.h),
                        ],
                        SizedBox(
                          width: widget.zoomIn
                              ? MediaQuery.of(context).size.width - 18.w
                              : 85.w,
                          child: Text(
                            '${snapshot.data!.data!.results!.first.title}',
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: ColorsUtils.WHITE,
                                fontWeight: widget.zoomIn
                                    ? FontWeight.w500
                                    : FontWeight.bold,
                                fontSize: widget.zoomIn ? 18 : 10),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
        }
      },
    );
  }
}
