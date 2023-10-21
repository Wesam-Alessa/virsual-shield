import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

import '../../domain/entities/vpn_model.dart';

class AppPreferences {
  static late Box boxOfData;

  static Future<void> initHive() async {
    await Hive.initFlutter();
    boxOfData = await Hive.openBox("data");
  }

  static bool get isModeDark => boxOfData.get('isModeDark') ?? false;

  static set isModeDark(bool value) => boxOfData.put("isModeDark", value);

  static VpnModel get vpnModelObj =>
      VpnModel.fromJson(jsonDecode(boxOfData.get('vpn') ?? "{}"));

  static set vpnModelObj(VpnModel value) =>
      boxOfData.put("vpn", jsonEncode(value));

  static List<VpnModel> get vpnList{
    List<VpnModel> list = [];
    final dataVpn = jsonDecode(boxOfData.get('vpnList')??"[]");
    for(var data in dataVpn){
      list.add( VpnModel.fromJson(data));
    }
    return list;
  }

  static set vpnList(List<VpnModel> list) => boxOfData.put('vpnList', jsonEncode(list));
}
