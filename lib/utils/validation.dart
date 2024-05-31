import 'package:nutrogen/utils/helper.dart';

RegExp get _emailReg =>
    RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$');

String? firstNameValidate(String? value) {
  if ((value?.length ?? 0) < 3) {
    return loc.pleaseEnterValidFirstName;
  } else {
    return null;
  }
}

String? lastNameValidate(String? value) {
  if ((value?.length ?? 0) < 3) {
    return loc.pleaseEnterValidLastName;
  } else {
    return null;
  }
}

String? emailValidate(String? value) {
  if (!_emailReg.hasMatch('$value')) {
    return loc.pleaseEnterValidEmail;
  } else {
    return null;
  }
}

String? passwordValidate(String? value) {
  if ((value?.length ?? 0) < 6) {
    return loc.passwordLengthShouldBeGreaterThan5;
  } else {
    return null;
  }
}

String? mobileValidate(String? value) {
  if ((value?.length ?? 0) < 10) {
    return loc.pleaseEnterValidMobileNumber;
  } else {
    return null;
  }
}

String? branchValidate(String? value) {
  if (value == null || value == loc.selectBranch) {
    return loc.pleaseSelectVaildBranch;
  } else {
    return null;
  }
}

String? weightValidate(String? value) {
  if ((value?.length ?? 0) < 1) {
    return loc.pleaseEnterValidWeight;
  } else {
    return null;
  }
}

String? heightValidate(String? value) {
  if ((value?.length ?? 0) < 1) {
    return loc.pleaseEnterValidHeight;
  } else {
    return null;
  }
}

String? ageValidate(String? value) {
  if ((value?.length ?? 0) < 1) {
    return loc.pleaseEnterAge;
  } else {
    return null;
  }
}

String? cardNumberValidate(String? value) {
  if ((value?.length ?? 0) < 12) {
    return loc.enterValidCardNumber;
  } else {
    return null;
  }
}

String? cardExpiryDateValidate(String? value) {
  if ((value?.length ?? 0) < 4) {
    return loc.enterValidExpiryDate;
  } else {
    return null;
  }
}

String? cardCVCValidate(String? value) {
  if ((value?.length ?? 0) < 3) {
    return loc.enterValidCVC;
  } else {
    return null;
  }
}

String? cardNameValidate(String? value) {
  if ((value?.length ?? 0) < 3) {
    return loc.enterValidName;
  } else {
    return null;
  }
}
