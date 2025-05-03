import 'dart:convert';
import 'package:code_generator_app/common/objects/code_generator/i_code_generator.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/rendering.dart';

class HmacCodeGenerator implements ICodeGenerator {
  @override
  String generate(
      String enteredWord, String enteredKeyWord, String enteredLogin) {
    // Используем enteredKeyWord как "соль" для HMAC
    final key = utf8.encode(enteredKeyWord);
    final bytes = utf8.encode('$enteredWord$enteredLogin');
    final hmac = Hmac(sha256, key);
    final digest = hmac.convert(bytes);

    return _digestToPassword(digest.toString());
  }

  String _digestToPassword(String digest) {
    const upper = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const lower = 'abcdefghijklmnopqrstuvwxyz';
    const digits = '0123456789';
    const special = '!@#\$%^&*()';
    const allChars = upper + lower + digits + special;
    final codes = digest.codeUnits;

    // 1. Фиксируем позиции для обязательных символов
    final passwordChars = List<String?>.filled(12, null);

    // Первые 4 символа — гарантированные категории
    passwordChars[0] = upper[codes[0] % upper.length]; // Заглавная
    passwordChars[1] = digits[codes[1] % digits.length]; // Цифра
    passwordChars[2] = special[codes[2] % special.length]; // Спецсимвол
    passwordChars[3] = lower[codes[3] % lower.length]; // Строчная

    // 2. Заполняем оставшиеся 8 позиций детерминированно
    for (int i = 4; i < 12; i++) {
      final index = codes[i] % allChars.length;
      passwordChars[i] = allChars[index];
    }

    return passwordChars.join();
  }

  @override
  void test(String word) {
    debugPrint('HMAC test for word: $word');
    debugPrint('Test password: ${generate(word, 'secret', 'admin')}');
  }
}
