import 'package:get/get.dart';

import '../modules/account_setting/bindings/account_setting_binding.dart';
import '../modules/account_setting/views/account_setting_view.dart';
import '../modules/attendance/bindings/attendance_binding.dart';
import '../modules/attendance/views/attendance_view.dart';
import '../modules/forgot_password/bindings/forgot_password_binding.dart';
import '../modules/forgot_password/views/forgot_password_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/password_setting/bindings/password_setting_binding.dart';
import '../modules/password_setting/views/password_setting_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/request/bindings/request_binding.dart';
import '../modules/request/views/request_view.dart';
import '../modules/request_leave/bindings/request_leave_binding.dart';
import '../modules/request_leave/views/request_leave_view.dart';
import '../modules/request_overtime/bindings/request_overtime_binding.dart';
import '../modules/request_overtime/views/request_overtime_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.REQUEST,
      page: () => const RequestView(),
      binding: RequestBinding(),
    ),
    GetPage(
      name: _Paths.ATTENDANCE,
      page: () => const AttendanceView(),
      binding: AttendanceBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.REQUEST_LEAVE,
      page: () => const RequestLeaveView(),
      binding: RequestLeaveBinding(),
    ),
    GetPage(
      name: _Paths.REQUEST_OVERTIME,
      page: () => const RequestOvertimeView(),
      binding: RequestOvertimeBinding(),
    ),
    GetPage(
      name: _Paths.ACCOUNT_SETTING,
      page: () => const AccountSettingView(),
      binding: AccountSettingBinding(),
    ),
    GetPage(
      name: _Paths.PASSWORD_SETTING,
      page: () => const PasswordSettingView(),
      binding: PasswordSettingBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () => const ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
  ];
}
