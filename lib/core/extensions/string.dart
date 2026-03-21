extension StringX on String {
  String obscure() {
    return split(' ').map((e) => '${e.substring(0, 1)}.').join('');
  }
}
