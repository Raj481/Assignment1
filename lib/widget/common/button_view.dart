

import 'package:appassesment/utils/color_res.dart';
import 'package:flutter/cupertino.dart';

class ButtonView extends StatelessWidget {
  final Widget child;
  final Function()? onTap;
  final EdgeInsets? padding;
  final BoxConstraints? constraints;
  final BoxDecoration? decoration;
  const ButtonView({
    super.key,
    required this.child,
    this.onTap,
    this.constraints,
    this.padding,
    this.decoration
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? (){},
      child: Container(
        constraints: constraints ?? const BoxConstraints(),
        padding: padding ?? const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 25
        ),
        decoration: decoration ?? BoxDecoration(
          color: ColorRes.bgDarkGrey,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              //offset: const Offset(-2, 2),
              color: ColorRes.white.withOpacity(.05),
              spreadRadius: 1,
              blurRadius: 5
            )
          ]
        ),
        child: child,
      ),
    );
  }
}
