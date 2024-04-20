
import 'package:appassesment/model/country_model.dart';
import 'package:appassesment/utils/color_res.dart';
import 'package:appassesment/utils/font_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class PhoneNumberTextView extends StatelessWidget {

  final CountryModel model;
  final TextEditingController? controller;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final BoxConstraints? constraints;
  final BoxDecoration? decoration;
  final InputDecoration? inputDecoration;
  final Function(String)? onTextChanged;
  const PhoneNumberTextView({
    super.key,
    this.padding,
    this.constraints,
    this.decoration,
    this.margin,
    this.inputDecoration,
    this.controller,
    this.onTextChanged,
    required this.model
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: constraints ?? const BoxConstraints(
          minHeight: 40
      ),
      padding: padding ?? const EdgeInsets.symmetric(
          horizontal: 25
      ),
      margin:  margin ?? EdgeInsets.symmetric(
          horizontal: Get.width * .1
      ),
      decoration: decoration ?? BoxDecoration(
        color: ColorRes.bgSearchColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if(model.flag != null)
          SizedBox(
            height: 30,
            width: 30,
            child: SvgPicture.network(
                model.flag!
            ),
          ),
          const SizedBox(width: 15,),
          Text(
            model.telCode!,
            style: TextStyle(
                fontFamily: FontRes.smMedium,
                color: ColorRes.white,
                fontSize: 18
            ),
          ),
          const SizedBox(width: 15,),
          Flexible(
              child: TextField(
                controller: controller ?? TextEditingController(),
                keyboardType: TextInputType.phone,
                style: TextStyle(
                    fontFamily: FontRes.regular,
                    color: ColorRes.white,
                    fontSize: 18
                ),
                onChanged: onTextChanged ?? (value){},
                decoration: inputDecoration ?? InputDecoration(
                    border: InputBorder.none,
                    hintText: "9999999999" ,
                    hintStyle: TextStyle(
                        fontFamily: FontRes.smMedium,
                        color: ColorRes.white.withOpacity(.3),
                        fontSize: 18
                    )
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.singleLineFormatter,
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(15)
                ],
              )
          )
        ],
      ),
    );
  }
}
