import '../extensions/str_extensions.dart';
import 'package:flutter/material.dart';

class RegisterFrom {
  static bool notEmpty(
      String textField, String textFieldName, BuildContext context) {
    if (textField.isNotEmpty) {
      return true;
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Empty  $textFieldName"),
          ),
        );
      });
      return false;
    }
  }

  static bool charactersCheck(
      String text, String textFieldName, BuildContext context) {
    if (text.hasMoreThanEightLetter) {
      return true;
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("The words included are not enough $textFieldName"),
          ),
        );
      });
      return false;
    }
  }

  static bool emailCheck(String email, BuildContext context) {
    if (email.isValidEmail) {
      return true;
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("The email is incorrect"),
          ),
        );
      });
      return false;
    }
  }

  static bool mobileNUmberCheck(String mobileNumber, BuildContext context) {
    if (mobileNumber.isValidPhoneNumber) {
      return true;
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("The mobile number is incorrect"),
          ),
        );
      });
      return false;
    }
  }

  static bool nicNumberCheck(String nic, BuildContext context) {
    if (nic.isValidNIC) {
      return true;
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("The NIC number is incorrect"),
          ),
        );
      });
      return false;
    }
  }

  static bool passwordCheck(String password, BuildContext context) {
    if (password.isValidPassword) {
      return true;
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("The  password incorrect"),
          ),
        );
      });
      return false;
    }
  }

  static bool studentEmailCheck(String email, BuildContext context) {
    if (email.isValidEmail || email.isEmpty) {
      return true;
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("The email is incorrect"),
          ),
        );
      });
      return false;
    }
  }

  static bool studentNicNumberCheck(String nic, BuildContext context) {
    if (nic.isValidNIC || nic.isEmpty) {
      return true;
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("The NIC number is incorrect"),
          ),
        );
      });
      return false;
    }
  }
}
