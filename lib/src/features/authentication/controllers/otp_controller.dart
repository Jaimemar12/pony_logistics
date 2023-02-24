import 'package:get/get.dart';
import '../../../repository/authentication_repository/authentication_repository.dart';
import '../../core/screens/dashboard/admin_dashboard.dart';

class OTPController extends GetxController {
  static OTPController get instance => Get.find();

  void verifyOTP(String otp) async {
    var isVerified = await AuthenticationRepository.instance.verifyOTP(otp);
    isVerified
        ? Get.offAll(
            AdminDashboard(),
            transition: Transition.noTransition,
          )
        : Get.back();
  }
}
