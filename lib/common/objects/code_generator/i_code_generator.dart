import 'package:code_generator_app/common/objects/code_generator/code_generator.dart';
import 'package:code_generator_app/common/objects/code_generator/code_generator_types.dart';
import 'package:code_generator_app/common/objects/code_generator/hash_code_generator.dart';

abstract interface class ICodeGenerator {
  String generate(
    String enteredWord,
    String enteredKeyWord,
    String enteredLogin,
  );

  EncryptionType get type;

  factory ICodeGenerator(String? encryptionType) {
    switch (encryptionType) {
      case 'Встроенный':
        return CodeGenerator();
      case 'Hash-метод':
      case null:
      default:
        return HashCodeGenerator();
    }
  }

  @override
  String toString() => type.name;
}
