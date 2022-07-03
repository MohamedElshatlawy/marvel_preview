import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:marvel_preview/utils/colors.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../dataBase/dataBase_client.dart';
import '../models/character_model.dart' as character;
import '../models/error_model.dart';
import '../modules/characters/widgets/title_widget.dart';
import '../repository/home_repository.dart';

final homeProvider =
    ChangeNotifierProvider<HomeProvider>((ref) => HomeProvider());

class HomeProvider extends ChangeNotifier {
  var isLoading = false;
  var internetConnection = true;
  var offset = 0;
  int total = 0;
  int currentCount = 0;
  character.CharacterModel? characters = character.CharacterModel();
  ErrorModel? error = ErrorModel();
  List<character.Results> allCharacters = [];
  List<character.Results> searchResults = [];

  RefreshController refreshController = RefreshController(initialRefresh: true);
  TextEditingController searchController = TextEditingController();
  void notify() {
    notifyListeners();
  }

  Future<bool> checkInternetConnection(BuildContext context) async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        DataBaseClient.createDataBase();
        internetConnection = true;
      }
      return true;
    } on SocketException catch (_) {
      internetConnection = false;
      notify();
      showInternetConnectionAlertDialog(context);
      return false;
    }
  }

  Future<bool> getCharacters({bool isRefresh = false}) async {
    if (isRefresh) {
      offset = 0;
    } else {
      if (total != 0 && currentCount >= total) {
        refreshController.loadNoData();
        return false;
      }
    }
    try {
      isLoading = true;
      var response =
          await HomeRepository().getCharactersRequest(offset: offset, limit: 6);
      if (response['status'] == "Ok") {
        characters = character.CharacterModel.fromJson(response);
        if (isRefresh) {
          allCharacters = characters!.data!.results!;
          currentCount = characters!.data!.count!;

          insertInDataBase(result: characters!.data!.results!, isRefresh: true);
        } else {
          allCharacters.addAll(characters!.data!.results!);
          currentCount += characters!.data!.count!;
          insertInDataBase(result: characters!.data!.results!);
        }
        offset++;
        total = characters!.data!.total!;
        isLoading = false;
        notify();
        return true;
      } else {
        error = ErrorModel.fromJson(response);
        isLoading = false;
        notify();
        return false;
      }
    } catch (e, s) {
      print("Error in getCharacters => $e");
      print("Error in getCharacters => $s");
      isLoading = false;
      notify();
      return false;
    }
  }

  void onRefresh(BuildContext context) async {
    final next = await checkInternetConnection(context);
    if (next) {
      final result = await getCharacters(isRefresh: true);
      if (result) {
        refreshController.refreshCompleted();
      } else {
        refreshController.refreshFailed();
      }
    } else {
      refreshController.refreshFailed();
    }
  }

  void onLoading(BuildContext context) async {
    final next = await checkInternetConnection(context);
    if (next) {
      final result = await getCharacters();
      if (result) {
        refreshController.loadComplete();
      } else {
        refreshController.loadFailed();
      }
    } else {
      refreshController.loadFailed();
    }
  }

  void search({required String value}) {
    searchResults = allCharacters
        .where((element) =>
            element.name!.toLowerCase().contains(value.toLowerCase()))
        .toSet()
        .toList();
    notify();
  }

  Future<String> urlToFile({required String imageUrl}) async {
    var rng = Random();
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    File file = File('$tempPath${rng.nextInt(100)}.png');
    http.Response response = await http.get(
      Uri.parse(imageUrl),
    );
    await file.writeAsBytes(response.bodyBytes);
    return file.path;
  }

  insertInDataBase(
      {required List<character.Results> result, bool isRefresh = false}) async {
    if (isRefresh && DataBaseClient.allCharacters.isNotEmpty) {
      await DataBaseClient.deleteAll();
    }
    result.forEach((element) async {
      final String imagePath = await urlToFile(
          imageUrl:
              '${element.thumbnail!.path}/landscape_xlarge.${element.thumbnail!.extension}');
      await DataBaseClient.insertInDataBase(
          imagePath: imagePath, characterName: element.name!);
    });
  }

  showInternetConnectionAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const Icon(Icons.rotate_left, color: ColorsUtils.RED, size: 25),
          SizedBox(width: 20.w),
          TitleWidget(
            title: 'No Internet Connection',
          ),
        ],
      ),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
