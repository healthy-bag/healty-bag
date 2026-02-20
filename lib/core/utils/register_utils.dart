class RegisterUtils {
  static bool isValidNickname(String nickname) {
    int letterCount = nickname.replaceAll(RegExp(r'[^a-zA-Z]'), '').length;
    bool hasNumber = nickname.contains(RegExp(r'[0-9]'));
    return letterCount >= 3 && hasNumber;
  }
}
