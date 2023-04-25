import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pony_logistics/src/features/authentication/models/user_model.dart';
import '../../../../../constants/sizes.dart';
import '../../../../../constants/text_strings.dart';
import '../../../../../repository/google_sheets_repository/google_sheets_repository.dart';
import '../../../controllers/signup_controller.dart';

class SignUpFormWidget extends StatefulWidget {
  const SignUpFormWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SignUpFormWidget();
  }
}

class _SignUpFormWidget extends State<SignUpFormWidget> {
  _SignUpFormWidget() : super();

  bool showPassword = true;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    Get.put(GoogleSheetsRepository());
    final formKey = GlobalKey<FormState>();

    return Container(
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
              controller: controller.fullName,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                  errorStyle: TextStyle(height: 0),
                  label: Text(tFullName),
                  prefixIcon: Icon(LineAwesomeIcons.user)),
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
              controller: controller.email,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                  errorStyle: TextStyle(height: 0),
                  label: Text(tEmail),
                  prefixIcon: Icon(LineAwesomeIcons.envelope)),
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
              controller: controller.phoneNo,
              keyboardType:
              const TextInputType.numberWithOptions(
                  decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                    RegExp('[0-9]')),
              ],
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                  errorStyle: TextStyle(height: 0),
                  label: Text(tPhoneNo),
                  prefixIcon: Icon(LineAwesomeIcons.phone)),
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
              textInputAction: TextInputAction.go,
              onFieldSubmitted: (value) async {
                if (formKey.currentState!.validate()) {
                  /// Email & Password Authentication
                  // SignUpController.instance.registerUser(controller.email.text.trim(), controller.password.text.trim());

                  /// For Phone Authentication
                  // SignUpController.instance.phoneAuthentication(controller.phoneNo.text.trim());

                  /*
                     =========
                     Todo:Step - 3 [Get User and Pass it to Controller]
                     =========
                    */
                  final user = UserModel(
                    email: controller.email.text.trim(),
                    password: controller.password.text.trim(),
                    fullName: controller.fullName.text.trim(),
                    phoneNo: controller.phoneNo.text.trim(),
                  );
                  await SignUpController.instance.createUser(user);
                }
              },
              decoration: InputDecoration(
                errorStyle: const TextStyle(height: 0),
                label: const Text(tPassword),
                prefixIcon: const Icon(Icons.fingerprint),
                hintText: tPassword,
                suffixIcon: IconButton(
                    icon: Icon(showPassword
                        ? LineAwesomeIcons.eye_slash
                        : LineAwesomeIcons.eye),
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    }),
              ),
            ),
            const SizedBox(height: tFormHeight - 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    /// Email & Password Authentication
                    // SignUpController.instance.registerUser(controller.email.text.trim(), controller.password.text.trim());

                    /// For Phone Authentication
                    // SignUpController.instance.phoneAuthentication(controller.phoneNo.text.trim());

                    /*
                     =========
                     Todo:Step - 3 [Get User and Pass it to Controller]
                     =========
                    */
                    final user = UserModel(
                      email: controller.email.text.trim(),
                      password: controller.password.text.trim(),
                      fullName: controller.fullName.text.trim(),
                      phoneNo: controller.phoneNo.text.trim(),
                    );
                    await SignUpController.instance.createUser(user);
                  }
                },
                child: Text(tSignup.toUpperCase()),
              ),
            )
          ],
        ),
      ),
    );
  }
}
