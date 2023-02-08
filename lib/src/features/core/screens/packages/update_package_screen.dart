import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pony_logistics/src/features/authentication/models/user_model.dart';
import 'package:pony_logistics/src/features/core/controllers/package_controller.dart';
import 'package:pony_logistics/src/features/core/controllers/profile_controller.dart';
import 'package:pony_logistics/src/features/core/models/dashboard/package_model.dart';
import 'package:pony_logistics/src/features/core/screens/packages/package_update_screen.dart';
import 'package:pony_logistics/src/features/core/screens/profile/profile_form.dart';
import 'package:pony_logistics/src/features/core/screens/profile/widgets/image_with_icon.dart';
import '../../../../constants/sizes.dart';
import '../../../../constants/text_strings.dart';

class UpdatePackageScreen extends StatelessWidget {
  final PackageModel packageModel;

  const UpdatePackageScreen(this.packageModel, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PackageController());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(LineAwesomeIcons.angle_left)),
        title: Text(tEditPackage, style: Theme.of(context).textTheme.headlineMedium),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(tDefaultSize),

          /// -- Future Builder to load cloud data
          child: FutureBuilder(
            future: controller.getPackageData(packageModel.partNumber),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  PackageModel package = snapshot.data as PackageModel;

                  //Controllers
                  final partNumber = TextEditingController(text: package.partNumber);
                  final caseNumber = TextEditingController(text: package.caseNumber);
                  final quantity = TextEditingController(text: package.quantity);
                  final dateDelivered = TextEditingController(text: package.dateDelivered);

                  return Column(
                    children: [

                      /// -- Form (Get data and pass it to FormScreen)
                      PackageUpdateScreen(
                          partNumber: partNumber,
                          caseNumber: caseNumber,
                          quantity: quantity,
                          dateDelivered: dateDelivered,
                          package: packageModel),
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
            },
          ),
        ),
      ),
    );
  }
}
