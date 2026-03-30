extension RecordX on Record {
  List<Object?> toList({required int length}) {
    final r = this;

    switch (length) {
      case 1:
        if (r case (final a,)) return [a];
        break;

      case 2:
        if (r case (final a, final b)) return [a, b];
        break;

      case 3:
        if (r case (final a, final b, final c)) return [a, b, c];
        break;

      case 4:
        if (r case (final a, final b, final c, final d)) {
          return [a, b, c, d];
        }
        break;
    }

    throw Exception('Record shape no soportado');
  }
}
