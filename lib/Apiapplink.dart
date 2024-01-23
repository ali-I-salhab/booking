class ApiApplinks {
  static const server = "https://alisalhabqq11.000webhostapp.com/";
  static const roomimagesfolder = server + "upload/roomimages/";
  static const profilesimagefolder = server + "upload/usersprofileimages/";

  // auth
  static const String login = server + "auth/login.php";
  static const String signup = server + "auth/signup.php";
  static const String verifycode = server + "auth/verifycode.php";

  // forget
  static const String forgetpassword =
      server + "forgetpassword/forgetpassword.php";
  static const String resetpassword =
      server + "forgetpassword/resetpassword.php";
  static const String verifycodeforget =
      server + "forgetpassword/verifycode.php";
// ------------------hotels
  static const String deletehotel = server + "addhotel/details/delete.php";

  static const String addhoteldetails = server + "addhotel/details/add.php";
  static const String hoteldetailsview = server + "addhotel/details/view.php";
  static const String hoteldetailsedit = server + "addhotel/details/edit.php";
  // ------------------------photos
  static const String photosupload = server + "addhotel/photos/add.php";
  static const String photosedit = server + "addhotel/photos/edit.php";

  static const String photosview = server + "addhotel/photos/view.php";
  static const String photosdelete = server + "addhotel/photos/delete.php";
  // -----------groups
  static const String groupview = server + "groups/view.php";
  static const String updategroupstatus =
      server + "groups/updategroupstatus.php";

  static const String groupedit = server + "groups/update.php";
  static const String groupdelete = server + "groups/delete.php";
  static const String groupadd = server + "groups/add.php";
  // -----------rooms
  static const String uploadroomphotos = server + "rooms/uploadroomphotos.php";

  static const String roomadd = server + "rooms/add.php";

  static const String roomedit = server + "rooms/edit.php";

  static const String roomdelete = server + "rooms/delete.php";

  static const String roomview = server + "rooms/view.php";
  static const String getgroupsfromrooms = server + "rooms/groupsnames.php";
  static const String getroomimages = server + "rooms/getroomimages.php";

  // -----------mealplans

  static const String mealplansadd = server + "mealplans/add.php";
  static const String updatemealplanstatus =
      server + "mealplans/updatemealplanstatus.php";

  static const String mealplansedit = server + "mealplans/edit.php";

  static const String mealplansdelete = server + "mealplans/delete.php";

  static const String mealplansview = server + "mealplans/view.php";

  // -----------users
  static const String usersadd = server + "users/add.php";

  static const String usersedit = server + "users/edit.php";

  static const String usersdelete = server + "users/delete.php";

  static const String usersview = server + "users/view.php";
  // rates
  static const String addrate = server + "rate/add.php";
  static const String editrate = server + "rate/edit.php";
  static const String deleterate = server + "rate/delete.php";
  static const String viewrate = server + "rate/view.php";
  // stopsale
  static const String addstopsale = server + "stopsale/add.php";
  static const String editstopsale = server + "stopsale/edit.php";
  static const String deletestopsale = server + "stopsale/delete.php";
  static const String viewstopsale = server + "stopsale/view.php";
  // Updatedownrate
  static const String addUpdatedownrate = server + "updatedownrate/add.php";
  static const String editUpdatedownrate = server + "updatedownrate/edit.php";
  static const String deleteUpdatedownrate =
      server + "updatedownrate/delete.php";
  static const String viewUpdatedownrate = server + "updatedownrate/view.php";
  // payment
  static const String addpayment = server + "payment/add.php";
  static const String editpayment = server + "payment/edit.php";
  static const String deletepayment = server + "payment/delete.php";
  static const String viewpayment = server + "payment/view.php";
  // periods
  static const String addperiod = server + "period/add.php";
  static const String editperiod = server + "period/edit.php";
  static const String deleteperiod = server + "period/delete.php";
  static const String viewperiod = server + "period/view.php";
}
// addhotel/hotelphotosview.php
// https://alisalhabqq11.000webhostapp.com/auth/login.php
// rooms/add.php