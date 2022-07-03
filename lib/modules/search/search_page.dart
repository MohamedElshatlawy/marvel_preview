import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marvel_preview/modules/search/widgets/search_widget.dart';

import '../../providers/home_provider.dart';
import '../../utils/colors.dart';
import '../../utils/widgets/custom_textfield.dart';
import '../characters/character_details.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  @override
  Widget build(BuildContext context) {
    final home = ref.watch(homeProvider);
    return Scaffold(
      backgroundColor: ColorsUtils.DARK_GRAY,
      appBar: AppBar(
        backgroundColor: ColorsUtils.BLACK,
        title: SizedBox(
            height: 40.h,
            child: CustomTextField(
              controller: home.searchController,
              onChanged: (value) => home.search(value: value),
              hintText: 'Search...',
              hintTextColor: ColorsUtils.LIGHT_GRAY,
              textColor: ColorsUtils.BLACK,
              filledColor: ColorsUtils.WHITE,
              icon: Icon(Icons.search,
                  size: 28.sp, color: ColorsUtils.LIGHT_GRAY),
            )),
        actions: [
          TextButton(
            onPressed: () {
              home.searchController.clear();
              home.searchResults = [];
              Navigator.pop(context);
            },
            child: const Text(
              'Cancel',
              style: TextStyle(
                color: ColorsUtils.RED,
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
          )
        ],
        automaticallyImplyLeading: false,
      ),
      body: home.searchResults.isNotEmpty
          ? ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return SearchWidget(
                  character: home.searchResults[index],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CharacterDetails(
                                character: home.searchResults[index],
                              )),
                    );
                  },
                );
              },
              itemCount: home.searchResults.length,
            )
          : const SizedBox(),
    );
  }
}
