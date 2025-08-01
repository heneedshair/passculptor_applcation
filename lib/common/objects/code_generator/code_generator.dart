import 'dart:math';

import 'package:code_generator_app/common/objects/code_generator/app_data.dart';
import 'package:code_generator_app/common/objects/code_generator/code_generator_types.dart';
import 'package:code_generator_app/common/objects/code_generator/i_code_generator.dart';
import 'package:code_generator_app/common/objects/code_generator/over_word.dart';
import 'package:flutter/material.dart';

class CodeGenerator implements ICodeGenerator {
  @override
  EncryptionType get type => EncryptionType.builtIn;

  @override
  String generate(
    String enteredWord,
    String enteredKeyWord,
    String enteredLogin,
  ) {
    final OverWord word = OverWord(enteredWord.toLowerCase());
    final OverWord key = OverWord(
      '$enteredLogin${enteredKeyWord.toLowerCase()}',
    );

    final StringBuffer buffer = StringBuffer();
    // Получаем значение сдвига для второй и третьей буквы относительно первой
    final int genLettersShift = _getGenLettersShift(enteredKeyWord);

    for (int i = 0; i < word.length; i++) {
      buffer.write(_getNextLetter(
        word,
        key,
        enteredLogin.length,
        genLettersShift,
        i,
      ));
      if (buffer.length >= 12) break;
    }

    if (buffer.toString().length < 12) {
      for (int i = word.length - 1; i >= 0; i++) {
        buffer.write(_getNextLetter(
          word,
          key,
          enteredLogin.length,
          genLettersShift,
          i,
        ));
        if (buffer.length >= 12) break;
      }
    }
    String result = buffer.toString();

    // Финальная проверка на валидность пароля

    result = _validCheck(result);

    debugPrint('$key - $buffer');
    debugPrint('gen letters shift - $genLettersShift');

    return result;
  }

  static String _validCheck(String word) {
    if (RegExp(r'^[^A-Z]*$').hasMatch(word)) {
      word = word[0].toUpperCase() + word.substring(1);
    }
    if (RegExp(r'^[^a-z]*$').hasMatch(word)) {
      word = word[0].toLowerCase() + word.substring(1);
    }
    if (RegExp(r'^[^\d]*$').hasMatch(word)) {
      word = '${word}1';
    }
    if (RegExp(r'^[^!@#$%^&*(),.?":{}|<>]*$').hasMatch(word)) {
      word = '$word!';
    }
    return word;
  }

  static String _getNextLetter(
    OverWord word,
    OverWord key,
    int loginLength,
    int genLettersShift,
    int i,
  ) {
    const abc = AppData.abc;
    StringBuffer buffer = StringBuffer();

    final int shift =
        abc[word[i]]! + abc[word[i + genLettersShift]]! + abc[key[i]]! + abc[key[i + genLettersShift + loginLength]]!;
    // Второй символ ключевого слова берем исключительно из ключа, не затрагивая логин

    // Сдвигаем букву по лафавиту
    String letter = _shiftLetter(word[i], shift);

    // Если значение сдвига четное - буква заглавная, иначе строчная
    if (shift % 2 == 0) letter = letter.toUpperCase();

    buffer.write(letter);

    // Пишем цифру если текущая буква имеет четную цену
    if (abc[key[i]]! % 2 != 0) {
      buffer.write(
        (max(genLettersShift, shift) - min(genLettersShift, shift)) % 10,
      );
    }

    if (shift <= 40) buffer.write(_getSpecialSymbol(shift));

    return buffer.toString();
  }

  static String _getSpecialSymbol(int shift) {
    return switch (shift % 10) {
      1 => '!',
      2 => '@',
      3 => '#',
      4 => '\$',
      5 => '%',
      6 => '^',
      7 => '&',
      8 => '*',
      9 => '(',
      0 => ')',
      int() => throw UnimplementedError(),
    };
  }

  /// Сдвиг буквы с учётом переполнения (26 букв в алфавите)
  static String _shiftLetter(String letter, int shift) {
    int newCode = (letter.codeUnitAt(0) - 'a'.codeUnitAt(0) + shift) % 26;
    if (newCode < 0) {
      newCode += 26; // Обработка отрицательных значений, если сдвиг влево
    }
    return String.fromCharCode(newCode + 'a'.codeUnitAt(0));
  }

  /// Получить поцследннюю цифру суммы значений слова
  static int _getGenLettersShift(String word) {
    int totalCoast = 0;
    for (int i = 0; i < word.length; i++) {
      totalCoast += AppData.abc[word[i]]!;
    }
    totalCoast = totalCoast % 10;

    return totalCoast == 0 ? 10 : totalCoast;
  }
}
