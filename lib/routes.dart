import 'package:booking/addroom.dart';
import 'package:booking/core/constants/route.dart';
import 'package:booking/core/middleware/mymiddleware.dart';
import 'package:booking/view/auth/successsignup.dart';
import 'package:booking/view/home/Homepage.dart';
import 'package:booking/view/home/addhotel/addhotel.dart';
import 'package:booking/view/home/addhotel/addhotelsecondpage.dart';
import 'package:booking/view/home/addhotel/addhotelthirdpage.dart';

import 'package:booking/view/home/authaccount.dart';
import 'package:booking/view/auth/login.dart';
import 'package:booking/view/auth/signup.dart';
import 'package:booking/view/forgetpassword/verifycodeforgetpassword.dart';
import 'package:booking/view/home/googlemap.dart';
import 'package:booking/view/home/homecardscreens/availability.dart';
import 'package:booking/view/home/homecardscreens/details.dart';
import 'package:booking/view/home/homecardscreens/groups.dart';
import 'package:booking/view/home/homecardscreens/mealplan.dart';
import 'package:booking/view/home/homecardscreens/payment.dart';
import 'package:booking/view/home/homecardscreens/periods.dart';
import 'package:booking/view/home/homecardscreens/photos.dart';
import 'package:booking/view/home/homecardscreens/profile.dart';
import 'package:booking/view/home/homecardscreens/rates.dart';
import 'package:booking/view/home/homecardscreens/roomdetails.dart';
import 'package:booking/view/home/homecardscreens/rooms.dart';
import 'package:booking/view/home/homecardscreens/stopsale.dart';
import 'package:booking/view/home/homecardscreens/update.dart';
import 'package:booking/view/home/homecardscreens/users.dart';
import 'package:booking/view/home/hotelsdetails.dart';
import 'package:booking/view/home/moreinfo.dart';
import 'package:booking/view/home/profile.dart';
import 'package:booking/view/home/roompreview.dart';
import 'package:booking/view/onboarding/onboarding.dart';
import 'package:booking/view/paypal_paying.dart';
import 'package:get/get.dart';

List<GetPage<dynamic>>? getPages = [
  GetPage(
      name: AppRoutes.signup,
      page: () => Signup(),
      middlewares: [MyMiddleware()]),
  GetPage(name: AppRoutes.AuthPage, page: () => AuthPage()),
  GetPage(
      name: "/",
      page: () => const Onboarding(),
      middlewares: [Onboardingmiddleware()]),
  GetPage(
    name: AppRoutes.success,
    page: () => SuccessSignup(),
  ),
  GetPage(name: AppRoutes.addroompage, page: () => AddRoom()),

  GetPage(name: AppRoutes.RoomPreview, page: () => RoomPreview()),
  GetPage(name: AppRoutes.verifycode, page: () => VerifycodeForgetpassword()),
  GetPage(name: AppRoutes.googlemap, page: () => Googlemap()),
  GetPage(name: AppRoutes.hoteldetails, page: () => Hoteldetails()),
  GetPage(name: AppRoutes.moreinfo, page: () => Moreinfo()),
  GetPage(name: AppRoutes.homepage, page: () => HomePage()),
  // GetPage(name: AppRoutes.addhotel, page: () => Addhotel()),
  GetPage(name: AppRoutes.addhotelsecondpage, page: () => AddHotelSecondpage()),
  GetPage(name: AppRoutes.addhotelthirdpage, page: () => AddHotelThirdPage()),

  // home page card rotes
  GetPage(name: AppRoutes.details, page: () => Details()),
  GetPage(name: AppRoutes.photos, page: () => Photos()),

  GetPage(name: AppRoutes.availability, page: () => Availability()),

  GetPage(name: AppRoutes.rooms, page: () => Rooms()),
  GetPage(name: AppRoutes.updates, page: () => Update()),
  GetPage(name: AppRoutes.periods, page: () => Periods()),
  GetPage(name: AppRoutes.editProfile, page: () => EditProfile()),

  GetPage(name: AppRoutes.stopsale, page: () => Stopsale()),

  GetPage(name: AppRoutes.payment, page: () => Payment()),

  GetPage(name: AppRoutes.users, page: () => Users()),

  GetPage(name: AppRoutes.groups, page: () => Groups()),

  GetPage(name: AppRoutes.rates, page: () => Rates()),
  GetPage(name: AppRoutes.mealplan, page: () => MealPlan()),
  GetPage(name: AppRoutes.roomdetails, page: () => RoomDetails()),
];
