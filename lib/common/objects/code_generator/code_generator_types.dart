import 'dart:developer';

enum EncryptionType {
  builtIn('Встроенный'),
  hashMethod('Hash-метод');

  final String name;

  const EncryptionType(this.name);

  factory EncryptionType.create(String name) {
    for (final value in EncryptionType.values) {
      if (value.name == name) return value;
    }
    log('Введенное значение не соответствует существующим объектам, возвращен стандартный объект "hashMethod"');
    return EncryptionType.hashMethod;
  }

  @override
  String toString() => name;
}
