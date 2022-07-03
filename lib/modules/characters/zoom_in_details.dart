import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marvel_preview/modules/characters/widgets/single_character_details_widgets.dart';

import '../../models/character_model.dart';
import '../../providers/character_details_provider.dart';
import '../../utils/colors.dart';

class ZoomInDetails extends ConsumerStatefulWidget {
  final int initialPage;
  final CommonData data;
  const ZoomInDetails({Key? key, required this.data, required this.initialPage})
      : super(key: key);

  @override
  _ZoomInDetailsState createState() => _ZoomInDetailsState();
}

class _ZoomInDetailsState extends ConsumerState<ZoomInDetails> {
  @override
  void initState() {
    super.initState();
    ref.read(characterDetailsProvider).changeIndex(index: widget.initialPage);
  }

  @override
  Widget build(BuildContext context) {
    final characterDetails = ref.watch(characterDetailsProvider);

    return Scaffold(
      backgroundColor: ColorsUtils.DARK_GRAY,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: ColorsUtils.DARK_GRAY,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.close, size: 28.sp, color: ColorsUtils.WHITE),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: MediaQuery.of(context).size.height - 190.h,
                enableInfiniteScroll: false,
                disableCenter: true,
                viewportFraction: 0.85,
                initialPage: widget.initialPage,
                onPageChanged: (index, reason) {
                  characterDetails.changeIndex(index: index);
                },
              ),
              items: List.generate(widget.data.items!.length, (index) {
                return SingleCharacterDetailsWidgets(
                  index: index,
                  data: widget.data,
                  zoomIn: true,
                );
              }),
            ),
            Text(
              '${characterDetails.indicatorIndex + 1}/${widget.data.items!.length}',
              style: const TextStyle(
                  color: ColorsUtils.LIGHT_GRAY,
                  fontWeight: FontWeight.w500,
                  fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}

// class ZoomInDetails extends StatelessWidget {
//   final int initialPage;
//   final CommonData data;
//   const ZoomInDetails({Key? key, required this.data, required this.initialPage})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: ColorsUtils.DARK_GRAY,
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         backgroundColor: ColorsUtils.DARK_GRAY,
//         elevation: 0,
//         actions: [
//           IconButton(
//             icon: Icon(Icons.close, size: 28.sp, color: ColorsUtils.WHITE),
//             onPressed: () {
//               Navigator.pop(context);
//             },
//           )
//         ],
//       ),
//       body: Center(
//         child: Column(
//           children: [
//             CarouselSlider(
//               options: CarouselOptions(
//                 height: MediaQuery.of(context).size.height - 190.h,
//                 enableInfiniteScroll: false,
//                 disableCenter: true,
//                 viewportFraction: 0.85,
//                 initialPage: initialPage,
//                 onPageChanged: (index, reason) {
//                   controller.indicatorIndex.value = index;
//                 },
//               ),
//               items: List.generate(data.items!.length, (index) {
//                 return SingleCharacterDetailsWidgets(
//                   index: index,
//                   data: data,
//                   zoomIn: true,
//                 );
//               }),
//             ),
//             Text(
//               '${widget.index + 1}/${data.items!.length}',
//               style: const TextStyle(
//                   color: ColorsUtils.LIGHT_GRAY,
//                   fontWeight: FontWeight.w500,
//                   fontSize: 18),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
