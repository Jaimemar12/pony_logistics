import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/sizes.dart';
import '../../../../constants/text_strings.dart';
import '../../../authentication/models/user_model.dart';
import '../../controllers/profile_controller.dart';

class ProfileFormScreen extends StatefulWidget {
  final TextEditingController fullName;
  final TextEditingController email;
  final TextEditingController phoneNo;
  final TextEditingController password;
  final UserModel user;

  const ProfileFormScreen(
      {required this.fullName,
      required this.email,
      required this.phoneNo,
      required this.password,
      required this.user,
      Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ProfileFormScreen(
        fullName: fullName,
        email: email,
        phoneNo: phoneNo,
        password: password,
        user: user);
  }
}

class _ProfileFormScreen extends State<ProfileFormScreen> {
  _ProfileFormScreen({
    required this.fullName,
    required this.email,
    required this.phoneNo,
    required this.password,
    required this.user,
  }) : super();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController fullName;
  final TextEditingController email;
  final TextEditingController phoneNo;
  final TextEditingController password;
  final UserModel user;
  bool showPassword = true;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());

    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return "";
              } else {
                return null;
              }
            },
            controller: fullName,
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
            controller: email,
            decoration: const InputDecoration(
                errorStyle: TextStyle(height: 0),
                label: Text(tEmail),
                prefixIcon: Icon(LineAwesomeIcons.envelope_1)),
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
            controller: phoneNo,
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
            controller: password,
            obscureText: showPassword,
            decoration: InputDecoration(
              errorStyle: const TextStyle(height: 0),
              label: const Text(tPassword),
              prefixIcon: const Icon(Icons.fingerprint),
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
          const SizedBox(height: tFormHeight),

          /// -- Form Submit Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  final userData = UserModel(
                    id: user.id,
                    email: email.text.trim(),
                    password: password.text.trim(),
                    fullName: fullName.text.trim(),
                    phoneNo: phoneNo.text.trim(),
                  );

                  await controller.updateRecord(userData);
                } else {
                  // showDialog(
                  //     context: context,
                  //     builder: (context) {
                  //       return AlertDialog(
                  //         title: Text('Material Dialog'),
                  //         content: Text('Hey! I am Coflutter!'),
                  //         actions: <Widget>[
                  //           TextButton(
                  //               onPressed: () {
                  //                 Navigator.pop(context);
                  //               },
                  //               child: Text('Close')),
                  //           TextButton(
                  //             onPressed: () {
                  //               print('HelloWorld!');
                  //               Navigator.pop(context);
                  //             },
                  //             child: Text('HelloWorld!'),
                  //           )
                  //         ],
                  //       );
                  //     });
                  print("Not Validated");
                }
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: tPrimaryColor,
                  side: BorderSide.none,
                  shape: const StadiumBorder()),
              child:
                  const Text(tEditProfile, style: TextStyle(color: tDarkColor)),
            ),
          ),
          const SizedBox(height: tFormHeight),

          /// -- Created Date and Delete Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text.rich(
                TextSpan(
                  text: tJoined,
                  style: TextStyle(fontSize: 12),
                  children: [
                    TextSpan(
                        text: tJoinedAt,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12))
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent.withOpacity(0.1),
                    elevation: 0,
                    foregroundColor: Colors.red,
                    shape: const StadiumBorder(),
                    side: BorderSide.none),
                child: const Text(tDelete),
              ),
            ],
          )
        ],
      ),
    );
  }
}
