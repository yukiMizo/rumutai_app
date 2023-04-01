import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

enum CategoryToGet { b1, g1, m1, b2, g2, m2 }

class DataToPass {
  final String gameDataId;
  final String? classNumber;
  final bool isReverse;
  final bool? isMyGame;

  DataToPass({
    required this.gameDataId,
    this.classNumber,
    this.isMyGame = false,
    this.isReverse = false,
  });
}

class GameData with ChangeNotifier {
  final firebase = FirebaseFirestore.instance;

  final Map _gameDataForResult = {};
  final Map _gameDataForSchedule = {};

  /* List l = [
    //1b
    "1b-a00",
    "1b-a01",
    "1b-a02",
    "1b-a03",
    "1b-a04",
    "1b-a05",

    "1b-b00",
    "1b-b01",
    "1b-b02",
    "1b-b03",
    "1b-b04",
    "1b-b05",
    "1b-b06",
    "1b-b07",
    "1b-b08",
    "1b-b09",

    "1b-f00",
    "1b-f01",
    "1b-f02",
    "1b-f03",

    "1b-l00",
    "1b-l01",
    "1b-l02",
    "1b-l03",
    "1b-l04",

    //1g
    "1g-a00",
    "1g-a01",
    "1g-a02",
    "1g-a03",
    "1g-a04",
    "1g-a05",
    "1g-a06",
    "1g-a07",
    "1g-a08",
    "1g-a09",

    "1g-b00",
    "1g-b01",
    "1g-b02",
    "1g-b03",
    "1g-b04",
    "1g-b05",
    "1g-b06",
    "1g-b07",
    "1g-b08",
    "1g-b09",
    "1g-b10",
    "1g-b11",
    "1g-b12",
    "1g-b13",
    "1g-b14",

    "1g-f00",
    "1g-f01",
    "1g-f02",
    "1g-f03",

    "1g-l00",
    "1g-l01",
    "1g-l02",
    "1g-l03",
    "1g-l04",
    "1g-l05",

    //1m
    "1m-a00",
    "1m-a01",
    "1m-a02",
    "1m-a03",
    "1m-a04",
    "1m-a05",
    "1m-a06",
    "1m-a07",
    "1m-a08",
    "1m-a09",

    "1m-b00",
    "1m-b01",
    "1m-b02",
    "1m-b03",
    "1m-b04",
    "1m-b05",
    "1m-b06",
    "1m-b07",
    "1m-b08",
    "1m-b09",

    "1m-f00",
    "1m-f01",
    "1m-f02",
    "1m-f03",

    "1m-l00",
    "1m-l01",
    "1m-l02",
    "1m-l03",
    "1m-l04",

    //2b
    "2b-a00",
    "2b-a01",
    "2b-a02",
    "2b-a03",
    "2b-a04",
    "2b-a05",

    "2b-b00",
    "2b-b01",
    "2b-b02",
    "2b-b03",
    "2b-b04",
    "2b-b05",

    "2b-f00",
    "2b-f01",
    "2b-f02",
    "2b-f03",

    "2b-l00",
    "2b-l01",
    "2b-l02",
    "2b-l03",

    //2g
    "2g-a00",
    "2g-a01",
    "2g-a02",
    "2g-a03",
    "2g-a04",
    "2g-a05",
    "2g-a06",
    "2g-a07",
    "2g-a08",
    "2g-a09",

    "2g-b00",
    "2g-b01",
    "2g-b02",
    "2g-b03",
    "2g-b04",
    "2g-b05",
    "2g-b06",
    "2g-b07",
    "2g-b08",
    "2g-b09",

    "2g-f00",
    "2g-f01",
    "2g-f02",
    "2g-f03",

    "2g-l00",
    "2g-l01",
    "2g-l02",
    "2g-l03",
    "2g-l04",

    //2m
    "2m-a00",
    "2m-a01",
    "2m-a02",
    "2m-a03",
    "2m-a04",
    "2m-a05",
    "2m-a06",
    "2m-a07",
    "2m-a08",
    "2m-a09",

    "2m-b00",
    "2m-b01",
    "2m-b02",
    "2m-b03",
    "2m-b04",
    "2m-b05",

    "2m-f00",
    "2m-f01",
    "2m-f02",
    "2m-f03",

    "2m-l00",
    "2m-l01",
    "2m-l02",
    "2m-l03",
    "2m-l04",
  ];*/
/*
  bool _leagueIsFilled(String gameId) {
    if (gameId[3] != "a" || gameId != "b") {
      return false;
    }
    bool leagueIsFilled = true;
    List<Map> leaguesToCheck = [
      _gameData[gameId.substring(0, 2)]["a"],
      _gameData[gameId.substring(0, 2)]["b"],
    ];
    for (var league in leaguesToCheck) {
      league.forEach((gameId, gameData) {
        if (gameData["gameStatus"] != "after") {
          leagueIsFilled = false;
        }
      });
    }
    return leagueIsFilled;
  }*/

  Object? getGameDataForResult({required CategoryToGet categoryToGet}) {
    switch (categoryToGet) {
      case CategoryToGet.b1:
        return _gameDataForResult["1b"];
      case CategoryToGet.g1:
        return _gameDataForResult["1g"];
      case CategoryToGet.m1:
        return _gameDataForResult["1m"];
      case CategoryToGet.b2:
        return _gameDataForResult["2b"];
      case CategoryToGet.g2:
        return _gameDataForResult["2g"];
      case CategoryToGet.m2:
        return _gameDataForResult["2m"];
    }
  }

  Object? getGameDataForSchedule({required String classNumber}) {
    return _gameDataForSchedule[classNumber];
  }

  Future updateData(
      {required String doc,
      required Map<String, Object> newData,
      required Map teams,
      bool setMerge = false}) async {
    try {
      if (!setMerge) {
        await FirebaseFirestore.instance
            .collection('gameData')
            .doc(doc)
            .update(newData);
      } else {
        await FirebaseFirestore.instance
            .collection('gameData')
            .doc(doc)
            .set(newData, SetOptions(merge: true));
      }
    } catch (e) {
      return;
    }

    //デバイスのデータも更新
    newData.forEach((key, data) {
      final String category = doc.substring(0, 2);
      final String gender = doc[1];
      final String smallCategory = doc[3];
      if (!setMerge) {
        if (_gameDataForResult[category] != null) {
          _gameDataForResult[category][smallCategory][doc]
              .update(key, (_) => data);
        }
        if (_gameDataForSchedule[teams["0"]] != null) {
          _gameDataForSchedule[teams["0"]][gender][doc]
              .update(key, (_) => data);
        }
        if (_gameDataForSchedule[teams["1"]] != null) {
          _gameDataForSchedule[teams["1"]][gender][doc]
              .update(key, (_) => data);
        }
      } else {
        (data as Map).forEach((k, d) {
          if (_gameDataForResult[category] != null) {
            _gameDataForResult[category][smallCategory][doc]["team"]
                .update(k, (_) => d);
          }
          if (_gameDataForSchedule[teams["0"]] != null) {
            _gameDataForSchedule[teams["0"]][gender][doc]["team"]
                .update(k, (_) => d);
          }
          if (_gameDataForSchedule[teams["1"]] != null) {
            _gameDataForSchedule[teams["1"]][gender][doc]["team"]
                .update(k, (_) => d);
          }
        });
      }
    });
    notifyListeners();
  }

  Future loadGameDataForSchedule({required String classNumber}) async {
    await FirebaseFirestore.instance
        .collection("classGameDataToRead")
        .doc(classNumber)
        .get()
        .then((DocumentSnapshot doc) {
      _gameDataForSchedule[classNumber] = doc.data() as Map;
    });
  }

  Future loadGameDataForResult({required CategoryToGet categoryToGet}) async {
    late String docId;
    switch (categoryToGet) {
      case CategoryToGet.b1:
        docId = "1b";
        break;
      case CategoryToGet.g1:
        docId = "1g";
        break;
      case CategoryToGet.m1:
        docId = "1m";
        break;
      case CategoryToGet.b2:
        docId = "2b";
        break;
      case CategoryToGet.g2:
        docId = "2g";
        break;
      case CategoryToGet.m2:
        docId = "2m";
        break;
    }
    await FirebaseFirestore.instance
        .collection("gameDataToRead")
        .doc(docId)
        .get()
        .then((DocumentSnapshot doc) {
      _gameDataForResult[docId] = doc.data() as Map;
      //_gameData[docId] = doc.data() as Map<String, dynamic>;
    });
  }

  /*Future loadGameData2({required String collection}) async {
    //final data = await firebase.collection(collection).get();

    l.forEach((gameid) async {
      await firebase.collection(collection).doc(gameid).set({
        "team": {"0": "101", "1": "102"},
        "score": [0, 0],
        "referee": ["審判A", "審判B", "審判C", ""],
        "place": "鯱光館",
        "gameId": gameid as String,
        "gameStatus": "before",
        "startTime": {"date": "1", "hour": "13", "minute": "00"},
        "extraTime": "",
        "rumutaiStaff": "スタッフ",
        "scoreDetail": {
          "0": [0, 0],
          "1": [0, 0],
          "2": [0, 0],
        }
      });
    });
/*
    for (var gameData in data.docs) {
      _gameData[gameData.id] = {
        "team": gameData["team"] ?? ["No Data", "No Data"],
        "score": gameData["score"] ?? ["No Data", "No Data"],
        "referee": gameData["referee"] ?? ["No Data"],
        "place": gameData["place"] ?? "No Data",
        "startTime":
            gameData["startTime"] ?? {"date": "", "hour": "", "minute": ""},
      };
    }*/
  }*/
}
