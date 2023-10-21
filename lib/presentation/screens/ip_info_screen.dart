import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virtual_shield/data/remote_data/api_vpn_gate.dart';
import 'package:virtual_shield/domain/entities/ip_model.dart';
import 'package:virtual_shield/domain/entities/network_ip_model.dart';
import 'package:virtual_shield/presentation/widgets/ip_widget.dart';

class IpInfoScreen extends StatelessWidget {
  const IpInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ipModel = IpModel.fromJson({}).obs;
    ApiVpnGate.retrieveIpDetails(ipModel: ipModel);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text("Ip Information",
            style: Theme.of(context).textTheme.titleLarge),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10, right: 5),
        child: FloatingActionButton(
          backgroundColor: Colors.redAccent,
          onPressed: () {
            ipModel.value = IpModel.fromJson({});
            ApiVpnGate.retrieveIpDetails(ipModel: ipModel);
          },
          child: Icon(
            CupertinoIcons.refresh_circled,
            size: 40,
            color: Colors.white,
          ),
        ),
      ),
      body: Obx(
        () => ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(3),
          children: [
            IpWidget(
                model: NetworkIpModel(
                    title: "IP Address",
                    subTitle: ipModel.value.query,
                    icon: Icon(
                      Icons.my_location_outlined,
                      color: Colors.redAccent,
                    ))),
            IpWidget(
                model: NetworkIpModel(
                    title: "Internet Service Provider",
                    subTitle: ipModel.value.internetServiceProvider,
                    icon: Icon(
                      Icons.account_tree_outlined,
                      color: Colors.deepOrangeAccent,
                    ))),
            IpWidget(
                model: NetworkIpModel(
                    title: "Location",
                    subTitle: ipModel.value.countryName.isEmpty?
                    "Retrieving..."
                    :"${ipModel.value.cityName}, ${ipModel.value.regionName}, ${ipModel.value.countryName}",
                    icon: Icon(
                      CupertinoIcons.location_solid,
                      color: Colors.green,
                    ))),
            IpWidget(
                model: NetworkIpModel(
                    title: "Zip Code",
                    subTitle: ipModel.value.zipcode,
                    icon: Icon(
                     CupertinoIcons.map_pin_ellipse,
                      color: Colors.purpleAccent,
                    ))),
            IpWidget(
                model: NetworkIpModel(
                    title: "Time Zone",
                    subTitle: ipModel.value.timezone,
                    icon: Icon(
                      Icons.share_arrival_time_rounded,
                      color: Colors.cyan,
                    ))),
          ],
        ),
      ),
    );
  }
}
