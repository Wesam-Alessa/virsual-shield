import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:virtual_shield/domain/entities/vpn_config.dart';
import 'package:virtual_shield/domain/entities/vpn_status_model.dart';

class VpnRepo {
  static const String vpnStage = "vpnStage";
  static const String vpnStatus = "vpnStatus";
  static const String vpnControl = "vpnControl";

  static Stream<String> snapshotVpnStage() =>
      const EventChannel(vpnStage).receiveBroadcastStream().cast();

  static Stream<VpnStatusModel?> snapshotVpnStatus() =>
      const EventChannel(vpnStatus)
          .receiveBroadcastStream()
          .map((event) => VpnStatusModel.fromJson(jsonDecode(event)))
          .cast();

  static Future<void> startVpnNow(VpnConfigModel vpnConfigModel) async {
    return const MethodChannel(vpnControl).invokeMethod("start", {
      "config": vpnConfigModel.config,
      "country": vpnConfigModel.countryName,
      "username": vpnConfigModel.username,
      "password": vpnConfigModel.password
    });
  }

  static Future<void> stopVpnNow(){
    return const MethodChannel(vpnControl).invokeMethod("stop");
  }

  static Future<void> killSwitchVpnNow(){
    return const MethodChannel(vpnControl).invokeMethod("kill_switch");
  }

  static Future<void> refreshStageVpnNow(){
    return const MethodChannel(vpnControl).invokeMethod("refresh");
  }

  static Future<String?> getStage(){
    return const MethodChannel(vpnControl).invokeMethod("stage");
  }

  static Future<bool> isConnectedNow(){
    return getStage().then((value) => value!.toLowerCase() == "connected");
  }

  static const String vpnConnectedNow = "connected";
  static const String vpnDisconnectedNow = "disconnected";
  static const String vpnWaitConnectionNow = "wait_connection";
  static const String vpnAuthenticatingNow = "authenticating";
  static const String vpnReconnectNow = "reconnect";
  static const String vpnNoConnectionNow = "no_connection";
  static const String vpnConnectingNow = "connecting";
  static const String vpnPrepareNow = "prepare";
  static const String vpnDeniedNow = "denied";
}
