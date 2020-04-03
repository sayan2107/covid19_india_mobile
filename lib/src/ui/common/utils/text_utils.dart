class TextUtils {
  static bool isEmpty(String str) {
    if(str == null) return true;
    if(str.trim().length == 0) return true;
    return false;
  }

  static bool isValidEmail(String str){
    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(str);
    return emailValid;
  }


}