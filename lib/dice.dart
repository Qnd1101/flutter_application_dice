class Dice {
  final int size;
  late List<int> dice = [];

  // 주사위 만들기
  Dice({required this.size}) {
    init();
  }

  // 다시 원래 크기로 만들기
  // 배열을 다시 초기화 한다~
  void init() {
    dice.clear();
    for (int i = 1; i <= size; i++) {
      dice.add(i);
    }
  }

  // 주사위 섞기
  void shake() {
    dice.shuffle();
  }

  // 뽑기
  int pick() {
    int result = dice.first;
    dice.removeAt(0);
    return result;
  }
}
