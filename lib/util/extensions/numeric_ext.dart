extension RangeExtension on num {
  bool isBetween(num from, num to) {
    return this >= from && this <= to;
  }
}
