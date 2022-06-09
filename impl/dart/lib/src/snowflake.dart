typedef FromEpoch = int;

int milliTime() =>
    DateTime.fromMillisecondsSinceEpoch(DateTime.now().millisecond).millisecond;

int bigInt(String value) => BigInt.parse(value).toInt();

class SnowflakeGenOpts {
  late FromEpoch timestamp;
}

class DeconstructedSnowflake {
  late BigInt id;
  late BigInt timestamp;
  late int nodeId;
  late int seq;
  late BigInt epoch;
}

class Snowflake {
  late BigInt _epoch;
  late BigInt _nodeId;
  BigInt _seq = BigInt.from(0);
  int _lastSequenceExhaustion = 0;

  Snowflake(this._epoch, this._nodeId);

  int get nodeId => _nodeId.toInt();

  gen({int? timestamp_}) {
    int timestamp = timestamp_ ?? milliTime();

    if (_seq == BigInt.parse("4095n") && timestamp == _lastSequenceExhaustion) {
      while (milliTime() - timestamp < 1) {
        continue;
      }
    }

    _seq = _seq >= BigInt.parse("4095n")
        ? BigInt.parse("0n")
        : _seq + BigInt.parse("1n");
    if (_seq == BigInt.parse("4095n")) _lastSequenceExhaustion = milliTime();

    return (((BigInt.from(timestamp) - _epoch) << bigInt("22n")) |
        ((_nodeId & BigInt.parse("0b1111111111n")) << bigInt("12n")) |
        _seq);
  }

  // please only put a string or bigint in here pls
  DeconstructedSnowflake deconstruct(dynamic id) {
    late BigInt bigIntId;
    if (id is String) {
      bigIntId = BigInt.parse(id);
    } else if (id is BigInt) {
      bigIntId = id;
    }

    DeconstructedSnowflake snowflake = DeconstructedSnowflake();
    snowflake.id = bigIntId;
    snowflake.timestamp = (bigIntId >> bigInt("22n")) + _epoch;
    snowflake.nodeId =
        (bigIntId >> bigInt("22n") & BigInt.parse("0b1111111111n")).toInt();
    snowflake.seq = (bigIntId & BigInt.parse("0b1111111111n")).toInt();
    snowflake.epoch = _epoch;

    return snowflake;
  }
}
