import 'package:example_app/page/auth/signIn/controller/add_phone_number_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../router/app_route.dart';

class OtpConfirmController extends GetxController {

  final AddPhoneNumberController addPhoneNumberController = Get.find();

  final otp = List.generate(6, (_) => ''.obs);
  final controllers = List.generate(6, (_) => TextEditingController());

  void onOtpChanged(int index, String value, List<FocusNode> focusNodes) {
    otp[index].value = value;

    if (value.isNotEmpty && index < otp.length - 1) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        focusNodes[index + 1].requestFocus();
      });
    } else if (value.isEmpty && index > 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        focusNodes[index - 1].requestFocus();
      });
    }

    if (otp.every((element) => element.value.isNotEmpty)) {
      confirmOTP();
    }
  }

  void confirmOTP() {
    if(addPhoneNumberController.isFromSignup){
      Get.offNamed(AppRoutes.signupAddName);
    }
    if(addPhoneNumberController.isFromProfile){
      Get.offNamed(AppRoutes.rateService,arguments: {'source': 'profile'});
    }
  }

  @override
  void onInit() {
    super.onInit();
    for (int i = 0; i < 6; i++) {
      ever(otp[i], (val) {
        final controller = controllers[i];
        final selection = controller.selection;
        controller.value = TextEditingValue(
          text: val,
          selection: selection,
          composing: TextRange.empty,
        );
      });
    }
  }

  @override
  void onClose() {
    for (final c in controllers) {
      c.dispose();
    }
    super.onClose();
  }
}
