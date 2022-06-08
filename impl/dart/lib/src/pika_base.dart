// TODO: Put public facing types in this file.

/// Checks if you are awesome. Spoiler: you are.
class Awesome {
  bool get isAwesome => true;
}

class PikaPrefixRecord<F> {
  late F prefix;
  late String? description;
  late bool? secure;
  late Map<String, dynamic>? metadata;

}

class Pika<V> {
  final Map<String, PikaPrefixRecord<V>> prefixes = new Map();
}
