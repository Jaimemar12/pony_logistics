import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pony_logistics/src/features/authentication/controllers/login_controller.dart';
import '../../../../../constants/sizes.dart';
import '../../../../../constants/text_strings.dart';
import '../../forget_password/forget_password_options/forget_password_model_bottom_sheet.dart';

class LoginFormWidget extends StatefulWidget {
  const LoginFormWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LoginFormWidget();
  }
}

class _LoginFormWidget extends State<LoginFormWidget> {
  _LoginFormWidget() : super();

  bool showPassword = true;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    final formKey = GlobalKey<FormState>();

    return Form(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: tFormHeight - 10),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "";
                  } else {
                    return null;
                  }
                },
                controller: controller.email,
                decoration: const InputDecoration(
                    errorStyle: TextStyle(height: 0),
                    prefixIcon: Icon(LineAwesomeIcons.user),
                    labelText: tEmail,
                    hintText: tEmail),
              ),
              const SizedBox(height: tFormHeight - 20),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "";
                  } else {
                    return null;
                  }
                },
                obscureText: showPassword,
                controller: controller.password,
                decoration: InputDecoration(
                    errorStyle: TextStyle(height: 0),
                    prefixIcon: Icon(Icons.fingerprint),
                    labelText: tPassword,
                    hintText: tPassword,
                    suffixIcon: IconButton(
                        icon: Icon(showPassword
                            ? LineAwesomeIcons.eye_slash
                            : LineAwesomeIcons.eye),
                        onPressed: () {
                          setState(() {
                            showPassword = !showPassword;
                          });
                        })),
              ),
              const SizedBox(height: tFormHeight - 20),

              /// -- FORGET PASSWORD BTN
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () =>
                      ForgetPasswordScreen.buildShowModalBottomSheet(context),
                  child: const Text(tForgetPassword),
                ),
              ),

              /// -- LOGIN BTN
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      LoginController.instance.loginUser(
                          controller.email.text.trim(),
                          controller.password.text.trim());
                    }
                  },
                  child: Text(tLogin.toUpperCase()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
