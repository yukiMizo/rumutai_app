import 'package:flutter/material.dart';

import 'schedule_screen.dart';
import '../../widgets/main_pop_up_menu.dart';

//import '../providers/game_data.dart';
//import 'package:provider/provider.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';

class PickScheduleScreen extends StatelessWidget {
  static const routeName = "/schedule-screen";

  const PickScheduleScreen({super.key});
/*
  Widget _scheduleButton1({
    required context,
    required String title,
    required IconData icon,
    required String text,
    required Schedule schedule,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(title, style: const TextStyle(fontSize: 18)),
        const SizedBox(width: 10),
        OutlinedButton.icon(
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.black,
            shape: const StadiumBorder(),
            side: const BorderSide(color: Colors.black),
          ),
          onPressed: () => Navigator.of(context)
              .pushNamed(ScheduleDetailScreen.routeName, arguments: schedule),
          label: SizedBox(width: 80, child: Text(text)),
          icon: Icon(icon),
        ),
      ],
    );
  }*/

  Widget _scheduleButton({required context, required String classNumber}) {
    return SizedBox(
      width: double.infinity,
      height: 40,
      child: TextButton(
        style: TextButton.styleFrom(foregroundColor: Colors.black),
        onPressed: () => Navigator.of(context)
            .pushNamed(ScheduleScreen.routeName, arguments: classNumber),
        child: Row(
          children: [
            Expanded(
              child: Text(
                classNumber,
                style: TextStyle(fontSize: 20, color: Colors.brown.shade900),
                textAlign: TextAlign.center,
              ),
            ),
            Icon(Icons.navigate_next, size: 25, color: Colors.brown.shade900),
          ],
        ),
      ),
    );
  }

  Widget _gradeLable(String text) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(left: 5),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.brown.shade900,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //Provider.of<GameData>(context, listen: false)
    //  .loadGameData2(collection: "gameData");
    // FirebaseFirestore.instance
    //     .collection('refereesAndStaffs')
    //     .doc("refereesAndStaffsDoc")
    //     .set({"refereesAndStaffsList": mapToUpload});
    return Scaffold(
      appBar: AppBar(
        title: const Text("スケジュール"),
        actions: const [MainPopUpMenu()],
      ),
      backgroundColor: Colors.grey.shade100,
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                child: Card(
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    child: Column(children: [
                      _gradeLable("1年"),
                      _scheduleButton(context: context, classNumber: "101"),
                      const Divider(height: 1),
                      _scheduleButton(context: context, classNumber: "102"),
                      const Divider(height: 1),
                      _scheduleButton(context: context, classNumber: "103"),
                      const Divider(height: 1),
                      _scheduleButton(context: context, classNumber: "104"),
                      const Divider(height: 1),
                      _scheduleButton(context: context, classNumber: "105"),
                      const Divider(height: 1),
                      _scheduleButton(context: context, classNumber: "106"),
                      const Divider(height: 1),
                      _scheduleButton(context: context, classNumber: "107"),
                      const Divider(height: 1),
                      _scheduleButton(context: context, classNumber: "108"),
                      const Divider(height: 1),
                      _scheduleButton(context: context, classNumber: "109"),
                      const Divider(height: 1),
                      _scheduleButton(context: context, classNumber: "110"),
                      const Divider(height: 1),
                    ]),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Card(
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    child: Column(children: [
                      _gradeLable("2年"),
                      _scheduleButton(context: context, classNumber: "201"),
                      const Divider(height: 1),
                      _scheduleButton(context: context, classNumber: "202"),
                      const Divider(height: 1),
                      _scheduleButton(context: context, classNumber: "203"),
                      const Divider(height: 1),
                      _scheduleButton(context: context, classNumber: "204"),
                      const Divider(height: 1),
                      _scheduleButton(context: context, classNumber: "205"),
                      const Divider(height: 1),
                      _scheduleButton(context: context, classNumber: "206"),
                      const Divider(height: 1),
                      _scheduleButton(context: context, classNumber: "207"),
                      const Divider(height: 1),
                      _scheduleButton(context: context, classNumber: "208"),
                      const Divider(height: 1),
                      _scheduleButton(context: context, classNumber: "209"),
                      const Divider(height: 1),
                    ]),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
