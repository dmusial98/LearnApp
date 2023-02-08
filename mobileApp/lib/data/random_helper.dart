import 'dart:math';

class RandomHelper {
  static List<int> generateRandomIntsFromRangeWithoutRepetitionAndWithoutNumber(
      int range, int howMany, int numberWithout) {
    var random = Random();
    Set<int> set = {numberWithout};
    while (set.length <= howMany) {
      set.add(random.nextInt(range));
    }
    set.remove(numberWithout);
    return set.toList();
  }
}
