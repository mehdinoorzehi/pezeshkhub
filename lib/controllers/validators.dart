// ignore_for_file: curly_braces_in_flow_control_structures, non_constant_identifier_names

//! ولیدیتور ها

String? phoneValidator(String value) {
  String pattern = r'^9\d{9}$';
  RegExp regex = RegExp(pattern);
  if (value.isEmpty) {
    return 'شماره موبایل نمی‌تواند خالی باشد';
  } else if (!regex.hasMatch(value)) {
    return 'شماره موبایل باید با 9 شروع شود';
  } else {
    return null;
  }
}

//
//
//
String? validatePassword(String value) {
  if (value.isEmpty)
    return 'رمز عبور نمی‌تواند خالی باشد';
  else if (value.length < 8)
    return 'رمز عبور باید حداقل ۸ کاراکتر داشته باشد';
  else if (!value.contains(RegExp(r'[0-9]')))
    return 'رمز عبور باید حداقل یک عدد داشته باشد';
  else
    return null;
}

//
//
//
String? usernameValidator(String value) {
  // بررسی خالی بودن نام کاربری
  if (value.isEmpty) {
    return 'نام کاربری نمی‌تواند خالی باشد';
  }

  // بررسی فاصله‌ها
  if (value.contains(' ')) {
    return 'نام کاربری نباید شامل فاصله باشد';
  }

  // بررسی حروف و اعداد فارسی
  String persianPattern = r'[آ-ی۰-۹]';
  RegExp persianRegex = RegExp(persianPattern);
  if (persianRegex.hasMatch(value)) {
    return 'نام کاربری نباید شامل حروف یا اعداد فارسی باشد';
  }

  // بررسی وجود حداقل یک حرف انگلیسی
  String alphaPattern = r'[a-zA-Z]';
  RegExp alphaRegex = RegExp(alphaPattern);
  if (!alphaRegex.hasMatch(value)) {
    return 'نام کاربری باید شامل حداقل یک حرف انگلیسی باشد';
  }

  // بررسی وجود حداقل یک عدد
  String digitPattern = r'\d';
  RegExp digitRegex = RegExp(digitPattern);
  if (!digitRegex.hasMatch(value)) {
    return 'نام کاربری باید شامل حداقل یک عدد باشد';
  }

  return null;
}

//
//
//
String? validateTempPass(String value) {
  String pattern = r'^[0-9]+$';
  RegExp regex = RegExp(pattern);
  if (value.isEmpty ||
      value.length < 4 ||
      value.length > 4 ||
      !regex.hasMatch(value)) {
    return 'لطفا کد را به درستی وارد کنید';
  } else
    return null;
}
