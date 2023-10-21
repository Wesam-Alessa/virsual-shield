import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virtual_shield/core/local_storage/app_preferences.dart';
import 'package:virtual_shield/domain/entities/vpn_config.dart';
import 'package:virtual_shield/domain/repositories/vpn_repo.dart';

import '../../domain/entities/vpn_model.dart';

class AppController extends GetxController {
  final Rx<VpnModel> vpnInfo = AppPreferences.vpnModelObj.obs;
  final vpnConnectionState = VpnRepo.vpnDisconnectedNow.obs;

  void connectToVpnNow() async {
    if (vpnInfo.value.base64OpenVPNConfigurationData.isEmpty) {
      Get.snackbar(
          "Country / Location", "please select country / location first");

      return;
    }

    if (vpnConnectionState.value == VpnRepo.vpnDisconnectedNow) {
      final dataConfigVpn = const Base64Decoder()
          .convert(vpnInfo.value.base64OpenVPNConfigurationData);
      final configuration = const Utf8Decoder().convert(dataConfigVpn);
      final vpnConfiguration = VpnConfigModel(
        username: 'vpn',
        password: 'vpn',
        countryName: vpnInfo.value.countryLongName,
        config: configuration,
      );
      await VpnRepo.startVpnNow(vpnConfiguration);
    }
    else{
      await VpnRepo.stopVpnNow();
    }
  }

  Color get getRoundVpnButtonColor{
    switch(vpnConnectionState.value){
      case VpnRepo.vpnDisconnectedNow :
        return Colors.redAccent;
      case VpnRepo.vpnConnectedNow :
        return Colors.green;
      default :
        return Colors.orange;
    }
  }


  String get getRoundVpnButtonText{
    switch(vpnConnectionState.value){
      case VpnRepo.vpnDisconnectedNow :
        return "Tap to Connect";
      case VpnRepo.vpnConnectedNow :
        return "Disconnect";
      default :
        return "Connecting...";
    }
  }
}
