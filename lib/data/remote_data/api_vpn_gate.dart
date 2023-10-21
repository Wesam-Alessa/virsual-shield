import 'dart:convert';

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:virtual_shield/core/consts/api_const.dart';
import 'package:virtual_shield/core/local_storage/app_preferences.dart';
import 'package:virtual_shield/domain/entities/vpn_model.dart';

import '../../domain/entities/ip_model.dart';

class ApiVpnGate {
  static Future<List<VpnModel>> retrieveAllAvailableFreeVpnServers() async {
    final List<VpnModel> vpnServerList = [];
    try {
      final response = await http.get(Uri.parse(ApiConst.baseUrl));
      final comma = response.body.split("#")[1].replaceAll("*", "");
      List<List<dynamic>> listData = const CsvToListConverter().convert(comma);
      final header = listData[0];
      for (int counter = 1; counter < listData.length - 1; counter++) {
        Map<String, dynamic> jsonData = {};
        for (int iCounter = 0; iCounter < header.length; iCounter++) {
          jsonData.addAll(
              {header[iCounter].toString(): listData[counter][iCounter]});
        }
        vpnServerList.add(VpnModel.fromJson(jsonData));
      }
    } catch (exp) {
      Get.snackbar(
        "Error Occurred",
        exp.toString(),
        colorText: Colors.white,
        backgroundColor: Colors.redAccent,
      );
    }
    vpnServerList.shuffle();
    if(vpnServerList.isNotEmpty)AppPreferences.vpnList = vpnServerList;
    return vpnServerList;
  }

  static Future<void> retrieveIpDetails({required Rx<IpModel> ipModel})async{
    try{
      final response = await http.get(Uri.parse(ApiConst.ip));
      final data = jsonDecode(response.body);
      ipModel.value = IpModel.fromJson(data);
    }
    catch (exp) {
      Get.snackbar(
        "Error Occurred",
        exp.toString(),
        colorText: Colors.white,
        backgroundColor: Colors.redAccent,
      );
    }
  }
}
