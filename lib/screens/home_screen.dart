import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:provider/provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'notification/send_notification_screen.dart';
import 'schedule/pick_schedule_screen.dart';
import 'my_game_screen.dart';
import 'notification/notifications_screen.dart';
import 'game_result/pick_category_screen.dart';
import '../providers/local_data.dart';
import 'rule_book_screen.dart';
import 'cheer/pick_team_to_cheer_screen.dart';
import 'omikuji/pick_omikuji_screen.dart';

import '../utilities/local_notification.dart';
import '../widgets/main_drawer.dart';

final FlutterLocalNotificationsPlugin flnp = FlutterLocalNotificationsPlugin();

class HomeScreen extends StatefulWidget {
  static const routeName = "/home-screen";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    final fbm = FirebaseMessaging.instance;
    fbm.requestPermission();
    fbm.setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
    fbm.subscribeToTopic("notification");
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      flnp.initialize(const InitializationSettings(
          android: AndroidInitializationSettings('@mipmap/ic_launcher')));
      if (notification == null) {
        return;
      }
      // 通知
      flnp.show(
          notification.hashCode,
          notification.title,
          notification.body,
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'channel_id',
              'channel_name',
              importance: Importance.high,
              priority: Priority.high,
            ),
          ));
    });

    //ローカル通知初期化
    LocalNotification.initializeLocNotification();

    //認証コードが変更された場合の処理
    LocalData.listOfStringThatPasswordDidChange().then((list) {
      if (list != []) {
        if (list.contains("ルム対スタッフ")) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('ルム対スタッフ用の認証コードが変更されたので、サインアウトしました。'),
            ),
          );
        }
        if (list.contains("管理者")) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('管理者用の認証コードが変更されたので、サインアウトしました。'),
            ),
          );
        }
        Provider.of<LocalData>(context, listen: false).setDataFromLocal();
      }
    });

    //ローカルデータ初期化
    Provider.of<LocalData>(context, listen: false).setDataFromLocal();
    super.initState();
  }

  Widget _mainButton({
    required String text,
    required IconData icon,
    required double width,
    required void Function() onPressed,
    double? iconSize,
  }) {
    return SizedBox(
      width: width,
      height: 50,
      child: FilledButton.icon(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        label: Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            height: 1.0,
          ),
        ),
        icon: Icon(
          icon,
          size: iconSize ?? 25,
        ),
      ),
    );
  }

  Widget _subButton({
    required String text,
    required IconData icon,
    required double width,
    required void Function() onPressed,
    double? iconSize,
  }) {
    return SizedBox(
      width: width,
      height: 50,
      child: FilledButton.icon(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          side: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 2,
          ),
          backgroundColor: Colors.white,
          foregroundColor: Colors.brown.shade800,
        ),
        label: Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            height: 1.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        icon: Icon(
          icon,
          size: iconSize ?? 25,
        ),
      ),
    );
  }

  Widget _subButtonWithChild({
    required String text,
    required Widget child,
    required double width,
    required void Function() onPressed,
  }) {
    return SizedBox(
      width: width,
      height: 50,
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          side: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 2,
          ),
          backgroundColor: Colors.white,
          foregroundColor: Colors.brown.shade800,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            child,
            const SizedBox(width: 3),
            Text(
              text,
              style: const TextStyle(
                fontSize: 18,
                height: 1.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 3),
          ],
        ),
      ),
    );
  }

  Widget _tonalButton({
    required String text,
    required IconData icon,
    required double width,
    required void Function() onPressed,
    double? iconSize,
  }) {
    return SizedBox(
      width: width,
      height: 50,
      child: FilledButton.icon(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: Colors.brown.shade200,
          foregroundColor: Colors.brown.shade900,
        ),
        label: Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            height: 1.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        icon: Icon(
          icon,
          size: iconSize ?? 25,
        ),
      ),
    );
  }

  Widget _dividerWithText(String text) {
    return Container(
      width: 340,
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

  @override
  Widget build(BuildContext context) {
    bool? isLoggedInAdmin = Provider.of<LocalData>(context).isLoggedInAdmin;
    final double buttonWidth = MediaQuery.of(context).size.width * 4 / 5;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(NotificationsScreen.routeName),
            icon: const Icon(Icons.notifications),
          ),
        ],
        title: const Text("ホーム"),
      ),
      drawer: const MainDrawer(),
      body: SizedBox(
        width: double.infinity,
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: Column(
                children: [
                  Text(
                    "HR対抗 ",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      color: Colors.brown.shade800,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "2023  3/15〜16",
                    style: TextStyle(
                      color: Colors.brown.shade800,
                    ),
                  ),
                  const SizedBox(height: 40),
                  _mainButton(
                    text: "試合結果",
                    icon: Icons.scoreboard_outlined,
                    width: buttonWidth,
                    onPressed: () => Navigator.of(context)
                        .pushNamed(PickCategoryScreen.routeName),
                  ),
                  const SizedBox(height: 15),
                  _mainButton(
                    text: "スケジュール",
                    icon: Icons.event_note_outlined,
                    width: buttonWidth,
                    onPressed: () => Navigator.of(context)
                        .pushNamed(PickScheduleScreen.routeName),
                  ),
                  const SizedBox(height: 30),
                  _subButton(
                    text: "るるぶ",
                    icon: Icons.description_outlined,
                    width: buttonWidth,
                    onPressed: () => Navigator.of(context)
                        .pushNamed(RuleBookScreen.routeName),
                  ),
                  const SizedBox(height: 15),
                  _tonalButton(
                      text: "担当の試合",
                      icon: Icons.sports_score,
                      width: buttonWidth,
                      onPressed: () => Navigator.of(context)
                          .pushNamed(MyGameScreen.routeName)),
                  const SizedBox(height: 25),
                  _dividerWithText("その他機能"),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _subButton(
                        text: "おみくじ",
                        icon: FontAwesomeIcons.wandMagic,
                        iconSize: 18,
                        width: buttonWidth / 2 - 5,
                        onPressed: () => Navigator.of(context)
                            .pushNamed(PickOmikujiScreen.routeName),
                      ),
                      const SizedBox(width: 10),
                      _subButtonWithChild(
                        text: "応援",
                        child: SizedBox(
                          width: 26,
                          height: 26,
                          child: Image.asset(
                            "assets/images/cheer.png",
                            color: Colors.brown.shade700,
                          ),
                        ),
                        width: buttonWidth / 2 - 5,
                        onPressed: () => Navigator.of(context)
                            .pushNamed(PickTeamToCheerScreen.routeName),
                      ),
                    ],
                  ),
                  /*
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _subButton(
                        text: "おみくじ",
                        icon: FontAwesomeIcons.wandMagicSparkles,
                        iconSize: 18,
                        width: buttonWidth / 2 - 5,
                        onPressed: () {},
                      ),
                      const SizedBox(width: 10),
                      _subButton(
                        text: "表彰",
                        icon: Icons.workspace_premium_outlined,
                        width: buttonWidth / 2 - 5,
                        onPressed: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _subButton(
                        text: "クラス",
                        icon: Icons.diversity_3_outlined,
                        width: buttonWidth / 2 - 5,
                        onPressed: () {},
                      ),
                      const SizedBox(width: 10),
                      _subButton(
                        text: "表彰",
                        icon: Icons.workspace_premium_outlined,
                        width: buttonWidth / 2 - 5,
                        onPressed: () {},
                      ),
                    ],
                  ),
                  */
                  if (isLoggedInAdmin == true)
                    Column(
                      children: [
                        const SizedBox(height: 25),
                        _dividerWithText("管理者機能"),
                        const SizedBox(height: 15),
                        _tonalButton(
                          text: "通知を送る",
                          icon: Icons.send_outlined,
                          width: buttonWidth,
                          onPressed: () => Navigator.of(context)
                              .pushNamed(SendNotificationScreen.routeName),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
