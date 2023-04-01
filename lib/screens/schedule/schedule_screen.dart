import 'package:flutter/material.dart';

import '../../widgets/schedule_widget.dart';

import 'package:provider/provider.dart';

import '../../providers/game_data.dart';
import '../../widgets/main_pop_up_menu.dart';

class ScheduleScreen extends StatefulWidget {
  static const routeName = "/schedule-detail-screen";

  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  bool _isInit = true;
  bool _isLoading = false;
  late Map _gameData;

  Future _loadData(String classNumber) async {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      await Provider.of<GameData>(context, listen: false)
          .loadGameDataForSchedule(classNumber: classNumber);
      setState(() {
        _isLoading = false;
      });
      _isInit = false;
    }
  }

  Widget _dividerWithText(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          SizedBox(
              width: 40,
              child: Divider(
                thickness: 1,
                color: Colors.brown.shade800,
              )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: Text(
              text,
              style: TextStyle(
                color: Colors.brown.shade800,
              ),
            ),
          ),
          Expanded(
            child: Divider(
              thickness: 1,
              color: Colors.brown.shade800,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _scheduleList({
    required String classNumber,
    required Map? gameData,
  }) {
    if (gameData == null) {
      return [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text(
            "試合なし",
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 20,
              color: Colors.brown.shade900,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ];
    }

    List<Widget> scheduleList = [];
    List day1sortedGameData = [];
    List day2sortedGameData = [];
    gameData.forEach((gameId, data) {
      if (data["startTime"]["date"] == "1") {
        day1sortedGameData.add({
          "createdAt": DateTime(
            2023,
            3,
            15,
            int.parse(data["startTime"]["hour"]),
            int.parse(data["startTime"]["minute"]),
          ),
          "data": data
        });
      } else if (data["startTime"]["date"] == "2") {
        day2sortedGameData.add({
          "createdAt": DateTime(
            2023,
            3,
            16,
            int.parse(data["startTime"]["hour"]),
            int.parse(data["startTime"]["minute"]),
          ),
          "data": data
        });
      }
    });

    if (day1sortedGameData.isEmpty && day2sortedGameData.isEmpty) {
      return [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text(
            "試合なし",
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 20,
              color: Colors.brown.shade900,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ];
    }
    day1sortedGameData.sort((a, b) => a['createdAt'].compareTo(b['createdAt']));
    day2sortedGameData.sort((a, b) => a['createdAt'].compareTo(b['createdAt']));

    scheduleList.add(
      Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        child: Text(
          "※タップで詳細を確認できます。",
          textAlign: TextAlign.start,
          style: TextStyle(
            color: Colors.brown.shade700,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    );
    scheduleList.add(_dividerWithText("1日目"));
    for (var element in day1sortedGameData) {
      bool isReverse = false;
      if (classNumber != element["data"]["team"]["0"]) {
        isReverse = true;
      }
      scheduleList.add(ScheduleWidget(
        gameData: element["data"],
        classNumber: classNumber,
        isReverse: isReverse,
      ));
    }

    scheduleList.add(_dividerWithText("2日目"));
    for (var element in day2sortedGameData) {
      bool isReverse = false;
      if (classNumber != element["data"]["team"]["0"]) {
        isReverse = true;
      }
      scheduleList.add(ScheduleWidget(
        gameData: element["data"],
        classNumber: classNumber,
        isReverse: isReverse,
      ));
    }

    return scheduleList;
  }

  @override
  Widget build(BuildContext context) {
    final String classNumber =
        ModalRoute.of(context)!.settings.arguments as String;
    _loadData(classNumber);

//    Provider.of<GameData>(context, listen: false)
    //      .loadGameData2(collection: "gameData");

    if (!_isLoading) {
      _gameData = Provider.of<GameData>(context)
          .getGameDataForSchedule(classNumber: classNumber) as Map;
    }

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("$classNumber　スケジュール"),
          actions: const [MainPopUpMenu()],
          bottom: TabBar(indicatorColor: Colors.white, tabs: [
            const Tab(text: "フットサル"),
            Tab(text: classNumber[0] == "1" ? "バスケット" : "ドッチビー"),
            const Tab(text: "バレー"),
          ]),
        ),
        backgroundColor: Colors.grey.shade100,
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : TabBarView(
                children: [
                  Scrollbar(
                    child: SingleChildScrollView(
                      child: Column(
                        children: _scheduleList(
                            classNumber: classNumber, gameData: _gameData["b"]),
                      ),
                    ),
                  ),
                  Scrollbar(
                    child: SingleChildScrollView(
                      child: Column(
                        children: _scheduleList(
                            classNumber: classNumber, gameData: _gameData["g"]),
                      ),
                    ),
                  ),
                  Scrollbar(
                    child: SingleChildScrollView(
                      child: Column(
                        children: _scheduleList(
                            classNumber: classNumber, gameData: _gameData["m"]),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
