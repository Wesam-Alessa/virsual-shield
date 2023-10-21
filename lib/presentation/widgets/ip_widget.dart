import 'package:flutter/material.dart';
import 'package:virtual_shield/main.dart';

import '../../domain/entities/network_ip_model.dart';

class IpWidget extends StatelessWidget {
  final NetworkIpModel model;

  IpWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    sizeScreen = MediaQuery.of(context).size;
    return Card(
      elevation: 6,
      margin: EdgeInsets.symmetric(vertical: sizeScreen.height * .01),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        leading: Icon(
          model.icon.icon,
          size: model.icon.size ?? 28,
          color: model.icon.color,
        ),
        title: Text(model.title),
        subtitle: Text(model.subTitle),
      ),
    );
  }
}
