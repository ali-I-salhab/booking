import 'package:get/get.dart';

validate(String val, int min, int max, String type) {
  if (type == 'roomname') {
    if (val.isEmpty) {
      return 'room name cant be empty';
    }
    if (val.length > max) {
      return 'roomname length cant be bigger than $max';
    }
    if (val.length < min) {
      return 'roomname length cant be less than $min';
    }
  }
  if (type == 'roomdesc') {
    if (val.isEmpty) {
      return 'roomdesc cant be empty';
    }
    if (val.length > max) {
      return 'roomdesc length cant be bigger than $max';
    }
    if (val.length < min) {
      return 'roomdesc length cant be less than $min';
    }
  }
  if (type == 'password') {
    if (val.isEmpty) {
      return 'field cant be empty';
    }
    if (val.length > max) {
      return 'value length cant be bigger than $max';
    }
    if (val.length < min) {
      return 'value length cant be less than $min';
    }
  }
  if (type == 'numrate') {
    if (val.isEmpty) {
      return 'field cant be empty';
    }
    int v = int.parse(val);
    if (v > 1000) {
      return 'cant be bigger than 1000';
    }
    if (v > 1000) {
      return 'cant be bigger than 1000';
    }
  }
  if (type == 'numavailabilty') {
    if (val.isEmpty) {
      return 'field cant be empty';
    }
    int v = int.parse(val);
    if (v > 40) {
      return 'cant be bigger than 40';
    }
    if (v < 1) {
      return 'cant be bigger less than 1';
    }
  }

  if (type == 'phone') {
    if (!GetUtils.isPhoneNumber(val)) {
      return 'invalid phone number ';
    }
  }
  if (type == 'username') {
    if (val.isEmpty) {
      return 'field cant be empty';
    }
    if (val.length > max) {
      return 'value length cant be bigger than $max';
    }
    if (val.length < min) {
      return 'value length cant be less than $min';
    }

    if (!GetUtils.isUsername(val.trim())) {
      // print("fgfgf");
      return 'invalid username ';
    }
  }
  if (type == 'name') {
    if (val.isEmpty) {
      return 'field cant be empty';
    }
    if (val.length > max) {
      return 'value length cant be bigger than $max';
    }
    if (val.length < min) {
      return 'value length cant be less than $min';
    }
  }
  if (type == 'email') {
    if (val.isEmpty) {
      return 'field cant be empty';
    }

    if (!GetUtils.isEmail(val.trim())) {
      // print("fgfgf");
      return 'invalid email ';
    }
  }
}
