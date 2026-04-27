class OverWord {
  OverWord(this.word);

  final String word;

  int get length => word.length;

  String operator [](int ind) {
    return word[ind % word.length];
  }

  @override
  String toString() => word;
}