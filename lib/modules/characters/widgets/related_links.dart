import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/colors.dart';

class RelatedLinks extends StatelessWidget {
  final String title;
  final String link;
  const RelatedLinks({Key? key, required this.title, required this.link})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        primary: Colors.transparent,
      ),
      onPressed: () async {
        print('link:$link');
        await launchUrl(Uri.parse(link));
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${title[0].toUpperCase()}${title.substring(1).toLowerCase()}',
            style: const TextStyle(
              color: ColorsUtils.WHITE,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios,
            color: ColorsUtils.WHITE,
            size: 18,
          ),
        ],
      ),
    );
  }
}
