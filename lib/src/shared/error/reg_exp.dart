class RegExpApp {
  static RegExp validateCharacter = RegExp(r".{8,}$");
  static RegExp validateAlphabet = RegExp(r".*[a-zA-Z]");
  static RegExp validateNumber = RegExp(r".*[0-9]");
  static RegExp validateEmail = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+\.[a-zA-Z]+");
  static RegExp passwordValidAlphabets =
  RegExp(r"^(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]{8,}$");
  static RegExp validatePhoneNumber = RegExp(r"[0-9]{10,13}$");
}