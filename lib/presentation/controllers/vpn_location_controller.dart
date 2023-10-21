import 'package:get/get.dart';
import 'package:virtual_shield/core/local_storage/app_preferences.dart';
import 'package:virtual_shield/data/remote_data/api_vpn_gate.dart';

import '../../domain/entities/vpn_model.dart';

class VpnLocationController extends GetxController {
  List<VpnModel> vpnFreeServersList = AppPreferences.vpnList;
  final RxBool isLoadingNewLocations = false.obs;

  Future<void> retrieveVpnInformation() async {
    isLoadingNewLocations.value = true;
    vpnFreeServersList.clear();
    vpnFreeServersList = await ApiVpnGate.retrieveAllAvailableFreeVpnServers();
    isLoadingNewLocations.value = false;
  }
}
