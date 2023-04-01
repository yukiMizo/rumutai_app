import 'package:flutter/material.dart';
import 'package:rumutai_app/providers/game_data.dart';

import 'game_results_screen.dart';
import '../../widgets/main_pop_up_menu.dart';

class PickCategoryScreen extends StatelessWidget {
  static const routeName = "/game-info-screen";

  const PickCategoryScreen({super.key});

  Widget _gameInfoButton({
    required context,
    required String title,
    required IconData icon,
    required String text,
    required CategoryToGet categoryToGet,
  }) {
    return Column(
      children: [
        FilledButton(
          style: FilledButton.styleFrom(
            padding: const EdgeInsets.all(0),
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            side: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: 1,
            ),
          ),
          onPressed: () => Navigator.of(context)
              .pushNamed(GameResultsScreen.routeName, arguments: categoryToGet),
          child: SizedBox(
            width: 90,
            height: 100,
            child: Column(
              children: [
                const SizedBox(height: 20),
                Icon(
                  icon,
                  size: 40,
                  color: Colors.brown.shade900,
                ),
                const SizedBox(height: 10),
                Text(
                  text,
                  style: TextStyle(
                    color: Colors.brown.shade900,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          ),
        ),
        Text(
          title,
          style: TextStyle(color: Colors.brown.shade900),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("試合結果を確認"),
        actions: const [MainPopUpMenu()],
      ),
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  Text(
                    "1年",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.brown.shade900,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _gameInfoButton(
                        context: context,
                        title: "男子",
                        icon: Icons.sports_soccer,
                        text: "フットサル",
                        categoryToGet: CategoryToGet.b1,
                      ),
                      const SizedBox(width: 10),
                      _gameInfoButton(
                        context: context,
                        title: "女子",
                        icon: Icons.sports_basketball_outlined,
                        text: "バスケット",
                        categoryToGet: CategoryToGet.g1,
                      ),
                      const SizedBox(width: 10),
                      _gameInfoButton(
                        context: context,
                        title: "混合",
                        icon: Icons.sports_volleyball_outlined,
                        text: "バレー",
                        categoryToGet: CategoryToGet.m1,
                      )
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                        left: 10, right: 10, top: 10, bottom: 5),
                    child: Divider(),
                  ),
                  Text(
                    "2年",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.brown.shade900,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _gameInfoButton(
                        context: context,
                        title: "男子",
                        icon: Icons.sports_soccer,
                        text: "フットサル",
                        categoryToGet: CategoryToGet.b2,
                      ),
                      const SizedBox(width: 10),
                      Column(
                        children: [
                          FilledButton(
                            style: FilledButton.styleFrom(
                              padding: const EdgeInsets.all(0),
                              foregroundColor: Colors.black,
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              side: BorderSide(
                                color: Theme.of(context).colorScheme.primary,
                                width: 1,
                              ),
                            ),
                            onPressed: () => Navigator.of(context).pushNamed(
                                GameResultsScreen.routeName,
                                arguments: CategoryToGet.g2),
                            child: SizedBox(
                              width: 90,
                              height: 100,
                              child: Column(
                                children: [
                                  const SizedBox(height: 23),
                                  Image.asset(
                                    "assets/images/frisbee_icon.png",
                                    scale: 15,
                                    color: Colors.brown.shade900,
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    "ドッチビー",
                                    style: TextStyle(
                                      color: Colors.brown.shade900,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Text("女子"),
                        ],
                      ),
                      const SizedBox(width: 10),
                      _gameInfoButton(
                        context: context,
                        title: "混合",
                        icon: Icons.sports_volleyball_outlined,
                        text: "バレー",
                        categoryToGet: CategoryToGet.m2,
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
