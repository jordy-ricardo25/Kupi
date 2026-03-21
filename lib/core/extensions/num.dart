extension NumX on num {
  String toCleanString() {
    return this % 1 == 0 ? toInt().toString() : toString();
  }
}
