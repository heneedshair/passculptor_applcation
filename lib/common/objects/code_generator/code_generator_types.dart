enum EncryptionType {
  builtIn('Встроенный'),
  hashMethod('Hash-метод');

  final String name;

  const EncryptionType(this.name);

  @override
  String toString() => name;
}
