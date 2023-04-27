import 'package:flutter/material.dart';
import 'package:pony_logistics/src/common_widgets/form/form_header_widget.dart';
import 'package:pony_logistics/src/constants/image_strings.dart';
import 'package:pony_logistics/src/constants/text_strings.dart';
import '../../../../constants/colors.dart';
import '../../../../constants/sizes.dart';
import 'widgets/login_footer_widget.dart';
import 'widgets/login_form_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor:
        MediaQuery.of(context).platformBrightness == Brightness.dark
            ? tAccentColor
            : tPrimaryColor,
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(tDefaultSize),
            child: Column(
              children: const [
                FormHeaderWidget(
                  image: tWelcomeScreenImage,
                  title: tLoginTitle,
                  subTitle: tLoginSubTitle,
                ),
                LoginFormWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
