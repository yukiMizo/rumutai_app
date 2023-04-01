import 'package:flutter/material.dart';

class RankWidget extends StatelessWidget {
  final List<String> rank;
  const RankWidget(this.rank, {super.key});

  List<Widget> rankWidget(List<String> rank) {
    List<Widget> rankList = [
      if (rank.isNotEmpty)
        const Text(
          "順位",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      const SizedBox(height: 15),
    ];
    var count = 1;
    for (var team in rank) {
      rankList.add(
        Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
          SizedBox(
            width: 12,
            height: 18,
            child: Text(
              "$count",
              style: const TextStyle(
                fontSize: 18,
                height: 1.0,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          const SizedBox(
            height: 18,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                "位",
                style: TextStyle(
                  fontSize: 15,
                  height: 1.0,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 33,
            child: Text(
              team,
              style: const TextStyle(fontSize: 18, height: 1.0),
              textAlign: TextAlign.center,
            ),
          ),
        ]),
      );
      rankList.add(const SizedBox(height: 5));
      count++;
    }
    return rankList;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: rank.isEmpty ? 0 : 68,
      height: 230,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: rankWidget(rank),
      ),
    );
  }
}
