import 'dart:convert';
import 'package:code_generator_app/common/objects/code_generator/i_code_generator.dart';
import 'package:crypto/crypto.dart';

class HashCodeGenerator implements ICodeGenerator {
  static const _upper = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  static const _lower = 'abcdefghijklmnopqrstuvwxyz';
  static const _digits = '0123456789';
  static const _specials = '!@#\$%^&*()';

  static const _allChars = _upper + _lower + _digits + _specials;

  @override
  String generate(
    String enteredWord,
    String enteredKeyWord,
    String enteredLogin,
  ) {
    /* Генерируем хэш из всех 3 слов
    Вставка ":" между строками (enteredWord, enteredKeyWord, enteredLogin)
    нужна для повышения устойчивости к коллизиям при формировании входа в хэш-функцию. */
    final input = '$enteredWord:$enteredKeyWord:$enteredLogin';
    final hash = sha256.convert(utf8.encode(input)).bytes;

    List<String> password = List.filled(12, '');

    // Гарантируем хотя бы по одному символу каждого типа
    password[0] = _upper[hash[0] % _upper.length];
    password[1] = _lower[hash[1] % _lower.length];
    password[2] = _digits[hash[2] % _digits.length];
    password[3] = _specials[hash[3] % _specials.length];

    // Заполняем оставшиеся позиции
    for (int i = 4; i < 12; i++) {
      password[i] = _allChars[hash[i] % _allChars.length];
    }

    // Перемешиваем символы, используя хэш (без рандома!)
    final shuffled = _deterministicShuffle(password, hash);

    return shuffled.join();
  }

  List<String> _deterministicShuffle(List<String> items, List<int> hash) {
    var list = List<String>.from(items);
    for (int i = list.length - 1; i > 0; i--) {
      int j = hash[i % hash.length] % (i + 1);
      var tmp = list[i];
      list[i] = list[j];
      list[j] = tmp;
    }
    return list;
  }
}
