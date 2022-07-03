import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marvel_preview/modules/home_page/widgets/character_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../dataBase/dataBase_client.dart';
import '../../providers/home_provider.dart';
import '../../utils/colors.dart';
import '../characters/character_details.dart';
import '../search/search_page.dart';

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  @override
  void initState() {
    super.initState();
    ref.read(homeProvider).checkInternetConnection(context);
  }

  @override
  Widget build(BuildContext context) {
    final home = ref.watch(homeProvider);

    return Scaffold(
      backgroundColor: ColorsUtils.BLACK,
      appBar: AppBar(
        backgroundColor: ColorsUtils.BLACK,
        title: Image.asset('assets/icn-nav-marvel.png', scale: 2),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search, size: 28.sp, color: ColorsUtils.RED),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchPage(),
                ),
              );
            },
          )
        ],
      ),
      body: home.isLoading == true
          ? const Center(
              child: CircularProgressIndicator(
                color: ColorsUtils.RED,
              ),
            )
          : SmartRefresher(
              controller: home.refreshController,
              enablePullUp: true,
              onRefresh: () => home.onRefresh(context),
              onLoading: () => home.onLoading(context),
              child: home.error!.response != null
                  ? Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Center(
                        child: Text(
                          '${home.error!.response!.message}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: ColorsUtils.RED,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.zero,
                      itemBuilder: (BuildContext context, int index) {
                        return CharacterWidget(
                          internetConnection: home.internetConnection,
                          imageUrl: home.internetConnection == false &&
                                  DataBaseClient.allCharacters.isNotEmpty
                              ? DataBaseClient.allCharacters[index]['imagePath']
                              : '${home.allCharacters[index].thumbnail!.path}/landscape_xlarge.${home.allCharacters[index].thumbnail!.extension}',
                          characterName: home.internetConnection == false &&
                                  DataBaseClient.allCharacters.isNotEmpty
                              ? DataBaseClient.allCharacters[index]
                                  ['characterName']
                              : home.allCharacters[index].name!,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CharacterDetails(
                                        character: home.allCharacters[index],
                                      )),
                            );
                          },
                        );
                      },
                      itemCount: home.internetConnection == false &&
                              DataBaseClient.allCharacters.isNotEmpty
                          ? DataBaseClient.allCharacters.length
                          : home.allCharacters.length),
            ),
    );
  }
}
