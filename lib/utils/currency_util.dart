//Convert number to Vietnamdong format
//For example: 1000000 -> 1.000.000đ
String formatMoney(int number) {
  String s = number.toString();
  int n = s.length;
  if (n <= 3) {
    return s + " đ";
  } else {
    int m = n % 3;
    int k = (n / 3).floor();
    String result = "";
    if (m != 0) {
      result = s.substring(0, m) + ".";
    }
    for (int i = 0; i < k; i++) {
      result += s.substring(m + i * 3, m + i * 3 + 3) + ".";
    }
    result = result.substring(0, result.length - 1);
    return result + " đ";
  }
}
