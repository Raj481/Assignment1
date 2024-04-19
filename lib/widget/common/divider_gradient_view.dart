
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class DividerGradientView extends StatelessWidget {
  final EdgeInsets? margin;
  final double? height;
  final LinearGradient? gradient;
  const DividerGradientView({
    super.key,
    this.margin,
    this.height,
    this.gradient
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? .3,
      margin: margin ?? EdgeInsets.symmetric(
          horizontal: Get.width * .05,
      ),
      decoration: BoxDecoration(
        gradient: gradient ?? const LinearGradient(
            colors: [
              Color(0xFF2A2D2F),
              Color(0xFF343739),
              Color(0xFF2A2D2F),
            ],
          stops: [.25, .5, .25],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        )
      ),
    );
  }
}
