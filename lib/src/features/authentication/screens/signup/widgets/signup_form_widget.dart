import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pony_logistics/src/features/authentication/models/user_model.dart';
import '../../../../../constants/sizes.dart';
import '../../../../../constants/text_strings.dart';
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
              decoration: InputDecoration(
                errorStyle: TextStyle(height: 0),
                label: Text(tPassword),
                prefixIcon: Icon(Icons.fingerprint),
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
