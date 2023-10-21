// ignore_for_file: unnecessary_string_interpolations

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virtual_shield/core/local_storage/app_preferences.dart';
import 'package:virtual_shield/domain/entities/vpn_model.dart';
import 'package:virtual_shield/domain/repositories/vpn_repo.dart';
import 'package:virtual_shield/main.dart';
import 'package:virtual_shield/presentation/controllers/app_controller.dart';

class VpnLocationCard extends StatelessWidget {
  final VpnModel model;

  const VpnLocationCard({super.key, required this.model});

  String formatSpeed(int speed, int decimal) {
    if (speed <= 0) {
      return "0 B";
    }
    const suffixTitle = ['Bps', 'Kbps', 'Mbps', 'Gbps', 'Tbps'];
    var sp = (log(speed) / log(1024)).floor();
    return "${(speed / pow(1024, sp)).toStringAsFixed(decimal)} ${suffixTitle[sp]}";
  }

  @override
  Widget build(BuildContext context) {
    sizeScreen = MediaQuery.of(context).size;
    final appController = Get.find<AppController>();
    return Card(
      elevation: 6,
      margin: EdgeInsets.symmetric(vertical: sizeScreen.height * .01),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          appController.vpnInfo.value = model;
          AppPreferences.vpnModelObj = model;
          Get.back();
          if (appController.vpnConnectionState.value ==
              VpnRepo.vpnConnectedNow) {
            print("if :");
            print(appController.vpnConnectionState.value.toString());
            VpnRepo.stopVpnNow();
            Future.delayed(const Duration(seconds: 3),
                () => appController.connectToVpnNow());
          } else {
            appController.connectToVpnNow();
            print("else :");
            print(appController.vpnConnectionState.value.toString());
          }
        },
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          leading: Container(
            padding: const EdgeInsets.all(0.5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.black12),
            ),
            child: Image.asset(
              "assets/countryFlags/${model.countryShortName.toLowerCase()}.png",
              height: 40,
              width: sizeScreen.width * .15,
              fit: BoxFit.cover,
            ),
          ),
          title: Text(
            model.countryLongName,
            style: Theme.of(context).textTheme.labelMedium,
          ),
          subtitle: Row(
            children: [
              const Icon(
                Icons.shutter_speed,
                color: Colors.redAccent,
                size: 20,
              ),
              const SizedBox(
                width: 4,
              ),
              Text(formatSpeed(model.speed, 2),
                  style: Theme.of(context).textTheme.labelSmall),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(model.vpnSessionsNum.toString(),
                  style: Theme.of(context).textTheme.labelSmall),
              const SizedBox(
                width: 4,
              ),
              const Icon(
                CupertinoIcons.person_2_alt,
                color: Colors.redAccent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
