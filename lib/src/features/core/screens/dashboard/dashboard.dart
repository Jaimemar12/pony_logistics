import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pony_logistics/src/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:pony_logistics/src/features/core/screens/dashboard/widgets/appbar.dart';
import 'package:pony_logistics/src/features/core/screens/packages/packages_screen.dart';
import 'package:intl/intl.dart';
import '../../../../constants/colors.dart';
import '../../../../constants/text_strings.dart';
import '../../controllers/package_controller.dart';
import '../../controllers/text_controller.dart';
import '../../models/dashboard/package_model.dart';
import '../packages/update_package_screen.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _Dashboard();
  }
}

class _Dashboard extends State<Dashboard> {
  _Dashboard() : super();

  final packageController = Get.put(PackageController());
  final textController = Get.put(TextController());

  Future refresh() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final isDark = MediaQuery.of(context).platformBrightness ==
        Brightness.dark; //Dark mode
    var iconColor = isDark ? tPrimaryColor : tAccentColor;
    var textColor = isDark ? tPrimaryColor : tAccentColor;
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: DashboardAppBar(
        isDark: isDark,
      ),
      body: Container(
        padding: const EdgeInsets.all(tDashboardPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
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
                      controller: textController.partNumber,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                      ],
                      decoration: InputDecoration(
                          errorStyle: TextStyle(height: 0),
                          label: const Text(tPartNumber),
                          prefixIcon:
                              const Icon(LineAwesomeIcons.slack_hashtag),
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10.0)),
                              borderSide:
                                  BorderSide(color: textColor, width: 1.0))),
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
                      controller: textController.caseNumber,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                      ],
                      decoration: InputDecoration(
                          errorStyle: TextStyle(height: 0),
                          label: const Text(tCaseNumber),
                          prefixIcon:
                              const Icon(LineAwesomeIcons.slack_hashtag),
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10.0)),
                              borderSide:
                                  BorderSide(color: textColor, width: 1.0))),
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
                      controller: textController.quantity,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                      ],
                      decoration: InputDecoration(
                          errorStyle: TextStyle(height: 0),
                          label: const Text(tQuantity),
                          prefixIcon:
                              const Icon(LineAwesomeIcons.slack_hashtag),
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10.0)),
                              borderSide:
                                  BorderSide(color: textColor, width: 1.0))),
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
                      controller: textController.dateReceived,
                      readOnly: true,
                      decoration: InputDecoration(
                          errorStyle: TextStyle(height: 0),
                          label: const Text(tDateDelivered),
                          prefixIcon: const Icon(Icons.calendar_today),
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10.0)),
                              borderSide:
                                  BorderSide(color: textColor, width: 1.0))),
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100));
                        if (pickedDate != null) {
                          String formattedDate =
                              DateFormat('MM-dd-yyyy').format(pickedDate);
                          setState(() {
                            textController.dateReceived.text =
                                formattedDate; //set output date to TextField value.
                          });
                        }
                      },
                    ),
                    const SizedBox(height: tFormHeight - 10),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            final package = PackageModel(
                                partNumber: textController.partNumber.text.trim(),
                                caseNumber: textController.caseNumber.text.trim(),
                                quantity: textController.quantity.text.trim(),
                                dateDelivered:
                                textController.dateReceived.text.trim());
                            TextController.instance.createPackage(package);
                            setState(() {
                              textController.partNumber.text = "";
                              textController.caseNumber.text = "";
                              textController.quantity.text = "";
                              textController.dateReceived.text = "";
                            });
                          }
                        },
                        child: Text(tSubmit.toUpperCase()),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Text("Today's Packages",
                    style: Theme.of(context).textTheme.headlineMedium),
                const Spacer(),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: iconColor.withOpacity(0.1),
                  ),
                  child: IconButton(
                    onPressed: () => Get.to(() => const PackagesScreen()),
                    icon: const Icon(LineAwesomeIcons.search),
                    color: iconColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            FutureBuilder<List<PackageModel>>(
              future: packageController.getTodayPackages(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return Flexible(
                      child: RefreshIndicator(
                        onRefresh: refresh,
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (c, index) {
                              return Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(1),
                                    decoration: BoxDecoration(
                                        color: tPrimaryColor.withOpacity(0.1),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        border: const Border(
                                          bottom: BorderSide(),
                                          top: BorderSide(),
                                          left: BorderSide(),
                                          right: BorderSide(),
                                        )),
                                    child: ListTile(
                                      leading: Container(
                                        padding: const EdgeInsets.all(10.0),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: iconColor.withOpacity(0.1),
                                        ),
                                        child: Icon(LineAwesomeIcons.box,
                                            color: iconColor),
                                      ),
                                      title: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              "PN: ${snapshot.data![index].partNumber} "),
                                          Text(
                                              "CNO: ${snapshot.data![index].caseNumber}"),
                                        ],
                                      ),
                                      subtitle: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              "Q: ${snapshot.data![index].quantity} "),
                                          Text(
                                              "DD: ${snapshot.data![index].dateDelivered}"),
                                        ],
                                      ),
                                      trailing: Container(
                                        padding: const EdgeInsets.all(1.0),
                                        child: Container(
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            color: iconColor.withOpacity(0.1),
                                          ),
                                          child: IconButton(
                                            onPressed: () => Get.to(() =>
                                                UpdatePackageScreen(package:
                                                    snapshot.data![index])),
                                            icon: const Icon(
                                                LineAwesomeIcons.edit),
                                            color: iconColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  )
                                ],
                              );
                            }),
                      ),
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
          ],
        ),
      ),
    );
  }
}
