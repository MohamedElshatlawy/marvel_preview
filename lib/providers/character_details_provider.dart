import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/character_details_model.dart';
import '../repository/home_repository.dart';

final characterDetailsProvider =
    ChangeNotifierProvider<CharacterDetailsProvider>(
        (ref) => CharacterDetailsProvider());

class CharacterDetailsProvider extends ChangeNotifier {
  CharacterDetailsModel? characterDetails = CharacterDetailsModel();
  var indicatorIndex = 0;

  void notify() {
    notifyListeners();
  }

  Future<dynamic> getCharacterDetail({
    required String endPoint,
  }) async {
    var response =
        await HomeRepository().getCharactersDetailsRequest(endPoint: endPoint);
    if (response['status'] == "Ok") {
      characterDetails = CharacterDetailsModel.fromJson(response);
      return characterDetails;
    } else {
      return;
    }
  }

  void changeIndex({required int index}) {
    indicatorIndex = index;
    notify();
  }
}
