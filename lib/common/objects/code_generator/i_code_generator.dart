abstract interface class ICodeGenerator {
  String generate(
    String enteredWord,
    String enteredKeyWord,
    String enteredLogin,
  );

  /// Протестировать слово на ключевые слова через консоль
  void test(String word);
}
