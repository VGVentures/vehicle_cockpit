import 'package:flutter/services.dart';

class FakeInput {
  // Borrowed from Flutter's KeyEventSimulator (these were sadly not public).
  static final Map<String, PhysicalKeyboardKey> _debugNameToPhysicalKey = (() {
    final result = <String, PhysicalKeyboardKey>{};
    for (final key in PhysicalKeyboardKey.knownPhysicalKeys) {
      final debugName = key.debugName;
      if (debugName != null) {
        result[debugName] = key;
      }
    }
    return result;
  })();

  static PhysicalKeyboardKey findPhysicalKey(LogicalKeyboardKey key) {
    final result = _debugNameToPhysicalKey[key.debugName];
    assert(
      result != null,
      'Physical key for $key not found in known physical keys',
    );
    return result!;
  }

  static KeyDownEvent keyDown(LogicalKeyboardKey key) => KeyDownEvent(
        logicalKey: key,
        physicalKey: findPhysicalKey(key),
        timeStamp: const Duration(milliseconds: 10),
      );

  static KeyUpEvent keyUp(LogicalKeyboardKey key) => KeyUpEvent(
        logicalKey: key,
        physicalKey: findPhysicalKey(key),
        timeStamp: const Duration(milliseconds: 10),
      );
}
