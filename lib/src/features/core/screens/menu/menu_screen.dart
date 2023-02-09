import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pony_logistics/src/constants/sizes.dart';
import 'package:pony_logistics/src/constants/text_strings.dart';
import 'package:pony_logistics/src/features/core/screens/menu/update_profile_screen.dart';
import 'package:pony_logistics/src/features/core/screens/menu/widgets/menu.dart';

import '../../../../constants/colors.dart';
import '../../../../repository/authentication_repository/authentication_repository.dart';
import '../../../authentication/models/user_model.dart';
import '../../controllers/profile_controller.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    final controller = Get.put(ProfileController());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(LineAwesomeIcons.angle_left)),
        title: Text(tMainMenu.toUpperCase(),
            style: Theme.of(context).textTheme.headlineMedium),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(isDark ? LineAwesomeIcons.sun : LineAwesomeIcons.moon))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(tDefaultSize),
          child: FutureBuilder(
              future: controller.getUserData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    UserModel user = snapshot.data as UserModel;
                    return Column(
                      children: [
                        /// -- IMAGE with ICON
                        // const ImageWithIcon(),
                        // const SizedBox(height: 10),
                        Text(user.fullName.toUpperCase(),
                            style: Theme.of(context).textTheme.headlineMedium),
                        Text(user.email,
                            style: Theme.of(context).textTheme.bodyMedium),
                        const SizedBox(height: 20),

                        /// -- BUTTON
                        SizedBox(
                          width: 200,
                          child: ElevatedButton(
                            onPressed: () => Get.to(
                              () => const UpdateProfileScreen(),
                              transition: Transition.noTransition,
                            ),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: tPrimaryColor,
                                side: BorderSide.none,
                                shape: const StadiumBorder()),
                            child: const Text(tEditProfile,
                                style: TextStyle(color: tDarkColor)),
                          ),
                        ),
                        const SizedBox(height: 30),
                        const Divider(),
                        const SizedBox(height: 10),

                        /// -- MENU
                        MenuWidget(
                            title: "Settings",
                            icon: LineAwesomeIcons.cog,
                            onPress: () {}),
                        // ProfileMenuWidget(
                        //     title: "Search Packages",
                        //     icon: LineAwesomeIcons.search,
                        //     onPress: () => Get.to(() => PackagesScreen())),
                        // ProfileMenuWidget(title: "User Management", icon: LineAwesomeIcons.user_check, onPress: () => Get.to(AllUsers())),
                        const Divider(),
                        const SizedBox(height: 10),
                        MenuWidget(
                            title: "Information",
                            icon: LineAwesomeIcons.info,
                            onPress: () {}),
                        MenuWidget(
                            title: "Logout",
                            icon: LineAwesomeIcons.alternate_sign_out,
                            textColor: Colors.red,
                            endIcon: false,
                            onPress: () {
                              Get.defaultDialog(
                                title: "LOGOUT",
                                titleStyle: const TextStyle(fontSize: 20),
                                content: const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 15.0),
                                  child:
                                      Text("Are you sure, you want to Logout?"),
                                ),
                                confirm: Expanded(
                                  child: ElevatedButton(
                                    onPressed: () => AuthenticationRepository
                                        .instance
                                        .logout(),
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.redAccent,
                                        side: BorderSide.none),
                                    child: const Text("Yes"),
                                  ),
                                ),
                                cancel: OutlinedButton(
                                    onPressed: () => Get.back(),
                                    child: const Text("No")),
                              );
                            }),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  } else {
                    return const Center(child: Text('Something went wrong'));
                  }
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }),
        ),
      ),
    );
  }
}
