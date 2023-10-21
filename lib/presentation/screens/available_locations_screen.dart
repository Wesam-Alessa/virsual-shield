import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virtual_shield/presentation/controllers/vpn_location_controller.dart';

import '../widgets/vpn_location_card.dart';

class AvailableLocationsScreen extends StatelessWidget {
  AvailableLocationsScreen({super.key});

  final vpnController = VpnLocationController();

  loadingWidget(context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
          ),
          const SizedBox(height: 8),
          Text(
            "Gathering Free Vpn Location...",
            style: Theme.of(context).textTheme.labelMedium,
          )
        ],
      ),
    );
  }

  noServerFoundWidget(context) {
    return Center(
      child: Text(
        "No VPN Found, Try Again.",
        style: Theme.of(context).textTheme.labelMedium,
      ),
    );
  }

  serverDataWidget(context) {
    return ListView.builder(
        itemCount: vpnController.vpnFreeServersList.length,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(3),
        itemBuilder: (context, index) {
          return VpnLocationCard(
              model: vpnController.vpnFreeServersList[index]);
        });
  }

  @override
  Widget build(BuildContext context) {
    if (vpnController.vpnFreeServersList.isEmpty) {
      vpnController.retrieveVpnInformation();
    }
    return Obx(
      () => Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
          title: Text(
              "VPN Location ( ${vpnController.vpnFreeServersList.length} )",
              style: Theme.of(context).textTheme.titleLarge),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 10, right: 5),
          child: FloatingActionButton(
            backgroundColor: Colors.redAccent,
            onPressed: () {
              vpnController.retrieveVpnInformation();
            },
            child: const Icon(
              CupertinoIcons.refresh_circled,
              size: 40,
              color: Colors.white,
            ),
          ),
        ),
        body: vpnController.isLoadingNewLocations.value
            ? loadingWidget(context)
            : vpnController.vpnFreeServersList.isEmpty
                ? noServerFoundWidget(context)
                : serverDataWidget(context),
      ),
    );
  }
}
