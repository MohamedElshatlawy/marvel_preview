import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marvel_preview/modules/characters/widgets/character_details_widgets.dart';
import 'package:marvel_preview/modules/characters/widgets/related_links.dart';
import 'package:marvel_preview/modules/characters/widgets/title_widget.dart';

import '../../models/character_model.dart';
import '../../providers/home_provider.dart';
import '../../utils/colors.dart';

class CharacterDetails extends ConsumerStatefulWidget {
  final Results character;

  const CharacterDetails({Key? key, required this.character}) : super(key: key);

  @override
  _CharacterDetailsState createState() => _CharacterDetailsState();
}

class _CharacterDetailsState extends ConsumerState<CharacterDetails> {
  @override
  void initState() {
    super.initState();
    ref.read(homeProvider).checkInternetConnection(context);
  }

  @override
  Widget build(BuildContext context) {
    final home = ref.watch(homeProvider);
    return home.internetConnection
        ? Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      '${widget.character.thumbnail!.path}/portrait_fantastic.${widget.character.thumbnail!.extension}',
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 17.0, sigmaY: 17.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: ColorsUtils.BLACK.withOpacity(0.3)),
                  ),
                ),
              ),
              Scaffold(
                backgroundColor: Colors.transparent,
                body: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        alignment: Alignment.topLeft,
                        children: [
                          SizedBox(
                            height: 275.h,
                            width: double.infinity,
                            child: Image.network(
                              '${widget.character.thumbnail!.path}/standard_xlarge.${widget.character.thumbnail!.extension}',
                              fit: BoxFit.fill,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 28.h, left: 10.w),
                            child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.arrow_back_ios,
                                color: ColorsUtils.WHITE,
                                size: 25,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 10.w, right: 10.w, top: 15.h, bottom: 25.h),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TitleWidget(
                                title: 'NAME',
                              ),
                              TitleWidget(
                                title: widget.character.name!.toUpperCase(),
                                details: true,
                              ),
                              if (widget.character.description != "" &&
                                  widget.character.description != null) ...[
                                SizedBox(
                                  height: 15.h,
                                ),
                                TitleWidget(
                                  title: 'DESCRIPTION',
                                ),
                                TitleWidget(
                                  title: '${widget.character.description}',
                                  details: true,
                                ),
                              ],
                              SizedBox(height: 25.h),
                              if (widget
                                  .character.comics!.items!.isNotEmpty) ...[
                                CharacterDetailsWidgets(
                                  title: 'COMICS',
                                  data: widget.character.comics!,
                                ),
                              ],
                              if (widget
                                  .character.series!.items!.isNotEmpty) ...[
                                CharacterDetailsWidgets(
                                  title: 'SERIES',
                                  data: widget.character.series!,
                                ),
                              ],
                              if (widget
                                  .character.stories!.items!.isNotEmpty) ...[
                                CharacterDetailsWidgets(
                                  title: 'STORIES',
                                  data: widget.character.stories!,
                                ),
                              ],
                              if (widget
                                  .character.events!.items!.isNotEmpty) ...[
                                CharacterDetailsWidgets(
                                  title: 'EVENTS',
                                  data: widget.character.events!,
                                ),
                              ],
                              if (widget.character.urls!.isNotEmpty) ...[
                                SizedBox(
                                  height: 5.h,
                                ),
                                TitleWidget(
                                  title: 'RELATED LINKS',
                                ),
                                ListView.builder(
                                  shrinkWrap: true,
                                  padding: EdgeInsets.symmetric(vertical: 10.h),
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return RelatedLinks(
                                      title:
                                          widget.character.urls![index].type!,
                                      link: widget.character.urls![index].url!,
                                    );
                                  },
                                  itemCount: widget.character.urls!.length,
                                ),
                              ]
                            ]),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        : Scaffold(
            backgroundColor: ColorsUtils.BLACK,
            appBar: AppBar(
              backgroundColor: ColorsUtils.BLACK,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: ColorsUtils.WHITE,
                  size: 25,
                ),
              ),
            ),
          );
  }
}
