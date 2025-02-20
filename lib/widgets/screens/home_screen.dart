import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:offiql_techno_assign/utils/custom_colors.dart';
import 'package:offiql_techno_assign/utils/custom_widgets.dart';
import 'package:offiql_techno_assign/utils/widgets_custom_class.dart';
import 'package:offiql_techno_assign/widgets/screens/details_screen.dart';
import 'package:offiql_techno_assign/widgets/state_controller/controller.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _random = math.Random();

  @override
  void initState() {
    super.initState();
    // Call api when appliction is open
    final stateController =
        Provider.of<ProviderStateController>(context, listen: false);
    stateController.fetchData();
  }

  @override
  Scaffold build(BuildContext context) {
    log("call");
    final stateController =
        Provider.of<ProviderStateController>(context, listen: false);
    return Scaffold(
      appBar: appBar(() {
        // when tap replay button then fetch api data
        stateController.fetchData();
      }),
      body: Padding(
        padding: const EdgeInsets.only(
          right: 8.0,
          left: 8.0,
          top: 8.0,
        ),
        child:
            // useing provider state management to rebuild widget
            Consumer<ProviderStateController>(builder: (context, ref, child) {
          return Column(
            children: <Widget>[
              SizedBox(
                width: double.infinity,
                height: 58,
                child: SearchBar(
                  onChanged: stateController.onQueryChanged,
                  backgroundColor: const MaterialStatePropertyAll(
                    Color.fromARGB(255, 240, 223, 255),
                  ),
                  hintText: "Serach User",
                  shape: MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              stateController.isLoading
                  ? Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.35,
                        ),
                        const CircularProgressIndicator(),
                      ],
                    )
                  : stateController.dataList.isEmpty
                      ? Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.30,
                            ),
                            const Text("Data Not Available"),
                          ],
                        )
                      : Expanded(
                          child: gridViewBulider(),
                        ),
            ],
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 30, 203, 233),
        onPressed: () {
          // save new user useing show model bottom sheet
          showModelSheet(context, stateController);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> showModelSheet(
    BuildContext context,
    ProviderStateController stateController,
  ) {
    return showModalBottomSheet<void>(
      useSafeArea: true,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
              right: 18.0,
              left: 18.0,
              top: 18.0,
              bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SingleChildScrollView(
            child: Builder(builder: (context) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customText(
                    "Add user",
                    fontsize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(height: 8.0),
                  CustomTextField(
                    nameController: stateController.nameController,
                    hintText: "Ente Your Name",
                  ),
                  const SizedBox(height: 8.0),
                  CustomTextField(
                    nameController: stateController.usernameController,
                    hintText: "Username",
                  ),
                  const SizedBox(height: 8.0),
                  CustomTextField(
                    nameController: stateController.emailController,
                    hintText: "Email",
                  ),
                  const SizedBox(height: 8.0),
                  CustomTextField(
                    nameController: stateController.numberController,
                    hintText: "Enter Your Number",
                  ),
                  const SizedBox(height: 8.0),
                  CustomTextField(
                    nameController: stateController.websiteController,
                    hintText: "Website",
                  ),
                  const SizedBox(height: 8.0),
                  customText(
                    "Address",
                    fontsize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: CustomTextField(
                          nameController: stateController.streetController,
                          hintText: "Street",
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        flex: 1,
                        child: CustomTextField(
                          nameController: stateController.suiteController,
                          hintText: "Suite",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: CustomTextField(
                          nameController: stateController.cityController,
                          hintText: "city",
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        flex: 1,
                        child: CustomTextField(
                          nameController: stateController.zipcodeController,
                          hintText: "zipcode",
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  Row(
                    children: [
                      funButton(
                        context,
                        () {
                          Navigator.of(context).pop();
                          stateController.nameController.clear();
                          stateController.numberController.clear();
                          stateController.emailController.clear();
                          stateController.usernameController.clear();
                          stateController.websiteController.clear();
                          stateController.cityController.clear();
                          stateController.streetController.clear();
                          stateController.suiteController.clear();
                          stateController.zipcodeController.clear();
                        },
                        "Cancel",
                      ),
                      const SizedBox(width: 8.0),
                      funButton(
                        context,
                        () {
                          if (stateController.nameController.text.isNotEmpty) {
                            stateController.addNewUser();
                            FocusManager.instance.primaryFocus?.unfocus();
                            stateController.nameController.clear();
                            stateController.numberController.clear();
                            stateController.emailController.clear();
                            stateController.usernameController.clear();
                            stateController.websiteController.clear();
                            stateController.cityController.clear();
                            stateController.streetController.clear();
                            stateController.suiteController.clear();
                            stateController.zipcodeController.clear();
                            Navigator.of(context).pop();
                          } else {
                            Fluttertoast.showToast(
                              msg: "Please Required Name",
                            );
                          }
                        },
                        "Add",
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),
                ],
              );
            }),
          ),
        );
      },
    );
  }

  Expanded funButton(
    BuildContext context,
    VoidCallback onPressed,
    String text,
  ) {
    return Expanded(
      child: TextButton(
          style: ButtonStyle(
            shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            backgroundColor: const MaterialStatePropertyAll(Colors.blue),
          ),
          onPressed: onPressed,
          child: customText(
            text,
            color: Colors.white,
          )),
    );
  }

  GridView gridViewBulider() {
    final stateController = Provider.of<ProviderStateController>(
      context,
      listen: false,
    );
    return GridView.builder(
      padding: const EdgeInsets.only(
        bottom: kFloatingActionButtonMargin + 68,
      ),
      itemCount: stateController.dataList.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
      ),
      itemBuilder: (context, index) {
        Color randomColor = colorsList[_random.nextInt(colorsList.length)];
        return InkWell(
          onTap: () {
            //Navigate Home Screen To User Details Screen
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.rightToLeft,
                child: DetailsScreen(
                  dataList: stateController.dataList[index],
                  color: randomColor,
                ),
              ),
            );
          },
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 196, 196, 196),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircleAvatar(
                      radius: MediaQuery.of(context).size.height * 0.05,
                      backgroundColor: randomColor,
                      child: const Icon(Icons.person),
                    ),
                    const SizedBox(height: 15),
                    customText(
                      "@${stateController.dataList[index].username.toString()}",
                    ),
                    customText(
                      stateController.dataList[index].name.toString(),
                      color: const Color.fromARGB(255, 4, 62, 255),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 220, 220, 220),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Column(
                        children: [
                          customText(
                            "Email : ${stateController.dataList[index].email.toString()}",
                          ),
                          customText(
                            "Mob. : ${stateController.dataList[index].phone.toString()}",
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 12,
                  backgroundColor: Colors.blueGrey,
                  child: customText(
                    "${index + 1}",
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  PreferredSize appBar(VoidCallback onPressed) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: CustomAppbar(
        title: "Offiql Techno",
        iconWidget: IconButton(
          onPressed: onPressed,
          icon: const Icon(Icons.replay),
        ),
      ),
    );
  }
}
