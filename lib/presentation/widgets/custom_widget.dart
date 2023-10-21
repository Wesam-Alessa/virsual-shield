import 'package:flutter/material.dart';
import 'package:virtual_shield/main.dart';

class CustomWidget extends StatelessWidget {
  final String titleText;
  final String subTitleText;
  final Widget widget;
  const CustomWidget({super.key, required this.titleText, required this.subTitleText, required this.widget});


  @override
  Widget build(BuildContext context) {
    sizeScreen = MediaQuery.of(context).size;
    return SizedBox(
      width: sizeScreen.width *.46,
      child: Column(
        children: [
          widget,
          const SizedBox(height: 7),
          Text(
            titleText,
            style: Theme.of(context).textTheme.labelMedium,
          ),
          const SizedBox(height: 7),
          Text(
            subTitleText,
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ],
      ),
    );
  }
}
