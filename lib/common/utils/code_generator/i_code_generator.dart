import 'package:code_generator_app/common/utils/code_generator/code_generator.dart';
import 'package:code_generator_app/common/utils/code_generator/code_generator_types.dart';
import 'package:code_generator_app/common/utils/code_generator/hash_code_generator.dart';

abstract interface class ICodeGenerator {
  String generate(
    String enteredWord,
    String enteredKeyWord,
    String enteredLogin,
  );

  EncryptionType get type;

  factory ICodeGenerator(EncryptionType encryptionType) => switch (encryptionType) {
        EncryptionType.hashMethod => HashCodeGenerator(),
        EncryptionType.builtIn => CodeGenerator(),
      };

  @override
  String toString() => type.name;
}
