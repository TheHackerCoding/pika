import './snowflake.dart';

class PikaPrefixRecord<F> {
  late F prefix;
  late String? description;
  late bool? secure;
  late Map<String, dynamic>? metadata;
}

class DecodedPika<F> {
  late String prefix;
  late String tail;
  late BigInt snowflake;
  late int nodeId;
  late int seq;
  int version = 1;
  late PikaPrefixRecord<F>? prefixRecord;
}

class PikaInitializationOptions {
  late FromEpoch? epoch;
  late int? nodeId;
  late bool? suppressPrefixWarnings;
  late bool? disableLowercase;
}

final VALID_PREFIX = RegExp(r'/^[a-z0-9_]+$/i');
final DEFAULT_EPOCH = bigInt("1640995200000n");

class Pika<V> {
  final Map<String, PikaPrefixRecord<V>> prefixes = {};
  late Snowflake _snowflake;

  bool _suppressPrefixWarnings = false;
  late BigInt _nodeId;

  Pika(String prefixes, {int? epoch, int? nodeId, bool? suppressPrefixWarnings, bool? disableLowercase }) {
    this._nodeId = nodeId ? BigInt.from(nodeId!) % BigInt.parse("1024n") : ;
  }
}
