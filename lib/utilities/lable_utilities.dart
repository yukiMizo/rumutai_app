class LableUtilities {
  static List<String> refereeLableList(String gameId) {
    if (gameId[1] == "b" || gameId[1] == "m") {
      return ["主審", "線審", "線審"];
    } else if (gameId.contains("1g")) {
      return ["主審", "副審", "副審", "オフィシャル"];
    } else {
      return ["主審", "副審", "副審"];
    }
  }

  static List<String> scoreDetailLableList(String gameId) {
    if (gameId[1] == "b") {
      return ["前半", "後半"];
    } else if (gameId[1] == "m") {
      return ["セット１", "セット２", "セット３"];
    } else if (gameId[0] == "1") {
      return ["ピリオド１", "ピリオド２", "ピリオド３"];
    } else if (gameId[0] == "2") {
      return ["前半", "後半"];
    }
    return [];
  }

  static String extraTimeLable(String gameId) {
    if (gameId[1] == "b") {
      return "PK：";
    }
    return "延長：";
  }
}
