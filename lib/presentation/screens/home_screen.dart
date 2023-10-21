import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:virtual_shield/core/local_storage/app_preferences.dart';
import 'package:virtual_shield/domain/entities/vpn_status_model.dart';
import 'package:virtual_shield/domain/repositories/vpn_repo.dart';
import 'package:virtual_shield/main.dart';
import 'package:virtual_shield/presentation/screens/available_locations_screen.dart';
import 'package:virtual_shield/presentation/screens/ip_info_screen.dart';
import 'package:virtual_shield/presentation/widgets/custom_widget.dart';
import 'package:virtual_shield/presentation/widgets/timer_widget.dart';

import '../controllers/app_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final appController = Get.put(AppController());

  locationBottomNavigation(BuildContext context) {
    return SafeArea(
      child: Semantics(
        button: true,
        child: InkWell(
          onTap: () {
            Get.to(() => AvailableLocationsScreen());
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: sizeScreen.width * .041),
            height: 62,
            child: Row(
              children: [
                Image.asset('assets/png_icons/flag.png'),
                const SizedBox(width: 12),
                Text("Select Country / Location",
                    style: Theme.of(context).textTheme.titleLarge),
                const Spacer(),
                CircleAvatar(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  child: const Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.redAccent,
                    size: 26,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  vpnButton(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: sizeScreen.height * .06,),
      //decoration: BoxDecoration(color: Colors.redAccent),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Semantics(
            button: true,
            child: InkWell(
              borderRadius: BorderRadius.circular(75),
              onTap: () {
                appController.connectToVpnNow();
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: appController.getRoundVpnButtonColor.withOpacity(.1)),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          appController.getRoundVpnButtonColor.withOpacity(.3)),
                  child: Container(
                    height: sizeScreen.height * .14,
                    width: sizeScreen.height * .14,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: appController.getRoundVpnButtonColor),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Image.asset(
                        //   'assets/png_icons/power.png',
                        //   height: sizeScreen.height * .10,
                        //   width: sizeScreen.width * .18,
                        // ),
                        Icon(
                          Icons.power_settings_new,
                          size: 35,
                          color: Colors.white,
                        ),
                        Text(
                          appController.getRoundVpnButtonText,
                          style: TextStyle(fontSize: 12, color: Colors.white),
                          //Theme.of(context).textTheme.labelSmall,
                        ),
                        // Text(
                        //   "Connect",
                        //   style: Theme.of(context).textTheme.labelSmall,
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: sizeScreen.height * .02, bottom: sizeScreen.height * .01),
                padding: EdgeInsets.only(top: 2,left: 16,right:  16),
                decoration: BoxDecoration(color: Colors.redAccent,borderRadius: BorderRadius.circular(16)),
                child: Text(
                  appController.vpnConnectionState.value == VpnRepo.vpnDisconnectedNow
                      ? "Not connected"
                      : appController.vpnConnectionState.replaceAll("_"," ").toUpperCase(),
                    style: TextStyle(color:Colors.white,fontSize: 18),
                ),
              ),
              Obx(() => TimerWidget(initNow: appController.vpnConnectionState.value == VpnRepo.vpnConnectedNow)),
            ],
          ),
            SizedBox(height: 25,)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    VpnRepo.snapshotVpnStage().listen((event) {
      appController.vpnConnectionState.value = event;
    });
    sizeScreen = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text("Virtual Shield",
            style: Theme.of(context).textTheme.titleLarge),
        leading: GestureDetector(
          onTap: () {
            Get.to(()=>IpInfoScreen());
          },
          child: SvgPicture.asset(
            'assets/svg_icons/info.svg',
            height: 35,
            width: 35,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: GestureDetector(
              onTap: () {
                Get.changeThemeMode(AppPreferences.isModeDark
                    ? ThemeMode.light
                    : ThemeMode.dark);
                AppPreferences.isModeDark = !AppPreferences.isModeDark;
              },
              child: AppPreferences.isModeDark
                  ? SvgPicture.asset(
                      'assets/svg_icons/sun.svg',
                      height: 35,
                      width: 35,
                    )
                  : SvgPicture.asset(
                      'assets/svg_icons/halfmoon.svg',
                      height: 35,
                      width: 35,
                    ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: locationBottomNavigation(context),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomWidget(
                      titleText:
                          appController.vpnInfo.value.countryLongName.isEmpty
                              ? "Location"
                              : appController.vpnInfo.value.countryLongName,
                      subTitleText: "FREE",
                      widget: CircleAvatar(
                        radius: 42,
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        backgroundImage:
                            appController.vpnInfo.value.countryLongName.isEmpty
                                ? const AssetImage(
                                    'assets/png_icons/flag_on_moon.png',
                                  )
                                : AssetImage(
                                    'assets/countryFlags/${appController.vpnInfo.value.countryShortName.toLowerCase()}.png',
                                  ),
                      ),
                    ),
                    CustomWidget(
                      titleText:
                          appController.vpnInfo.value.countryLongName.isEmpty
                              ? "0 / ms"
                              : "${appController.vpnInfo.value.ping} ms",
                      subTitleText: "PING",
                      widget: CircleAvatar(
                        radius: 42,
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        backgroundImage: const AssetImage(
                          'assets/png_icons/wave1.gif',
                        ),
                      ),
                    ),
                  ],
                )),
            Obx(() => vpnButton(context)),
            StreamBuilder<VpnStatusModel?>(
                initialData: VpnStatusModel(),
                stream: VpnRepo.snapshotVpnStatus(),
                builder: (context, dataSnapshot) {
                  log(dataSnapshot.data!.toJson().toString());
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomWidget(
                        titleText: dataSnapshot.data?.byteIn ?? "0 kbps",
                        subTitleText: "DOWNLOAD",
                        widget: CircleAvatar(
                          radius: 42,
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          backgroundImage: const AssetImage(
                            'assets/png_icons/download.png',
                          ),
                        ),
                      ),
                      CustomWidget(
                        titleText: dataSnapshot.data?.byteOut ?? "0 kbps",
                        subTitleText: "UPLOAD",
                        widget: CircleAvatar(
                          radius: 42,
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          backgroundImage: const AssetImage(
                            'assets/png_icons/smartphone_download.png',
                          ),
                        ),
                      ),
                    ],
                  );
                }),
          ],
        ),
      ),
    );
  }
}
