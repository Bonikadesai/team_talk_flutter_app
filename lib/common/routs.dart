import 'package:get/get.dart';

import '../Screen/Auth/authScreen.dart';
import '../Screen/ContactScreen/contactScreen.dart';
import '../Screen/Home/homeScreen.dart';
import '../Screen/ProfileScreen/ProfileScreen.dart';
import '../Screen/UserProfileScreen/updateProfileScreen.dart';

var routes = [
  GetPage(
    name: "/authPage",
    page: () => const AuthScreen(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: "/homePage",
    page: () => const HomeScreen(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: "/profilePage",
    page: () => const ProfileScreen(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: "/contactPage",
    page: () => const ContactScreen(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: "/updateProfilePage",
    page: () => const UserUpdateProfile(),
    transition: Transition.rightToLeft,
  ),
];
