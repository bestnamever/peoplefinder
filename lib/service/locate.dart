class Locate {
  setPosition(int x, int y, int z) {
    if (x != null && y != null && z != null) {
      String a = z.toString();
      a = a + "." + (x ~/ 50).toString() + (y ~/ 60).toString();
      return a;
    } else
      return "Nowhere";
  }
}
