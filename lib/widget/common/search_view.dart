
import 'package:appassesment/utils/color_res.dart';
import 'package:appassesment/utils/font_res.dart';
import 'package:appassesment/utils/image_res.dart';
import 'package:appassesment/utils/string_res.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchView extends StatelessWidget {
  final TextEditingController? controller;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final BoxConstraints? constraints;
  final BoxDecoration? decoration;
  final InputDecoration? inputDecoration;
  final Function(String)? onTextChanged;
  const SearchView({
    super.key,
    this.padding,
    this.constraints,
    this.decoration,
    this.margin,
    this.inputDecoration,
    this.controller,
    this.onTextChanged
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: constraints ?? const BoxConstraints(
        minHeight: 40
      ),
      padding: padding ?? const EdgeInsets.symmetric(
          horizontal: 15
      ),
      margin:  margin ?? EdgeInsets.symmetric(
          horizontal: Get.width * .1
      ),
      decoration: decoration ?? BoxDecoration(
          color: ColorRes.bgSearchColor,
          borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
              image: AssetImage(
                  ImageRes.icSearch
              )
          ),
          const SizedBox(width: 15,),
          Flexible(
              child: TextField(
                controller: controller ?? TextEditingController(),
                style: TextStyle(
                    fontFamily: FontRes.regular,
                    color: ColorRes.white,
                    fontSize: 14
                ),
                onChanged: onTextChanged ?? (value){},
                decoration: inputDecoration ?? InputDecoration(
                  border: InputBorder.none,
                  hintText: StringRes.search ,
                  hintStyle: TextStyle(
                    fontFamily: FontRes.xsLight,
                    color: ColorRes.white.withOpacity(.5)
                  )
                ),
                cursorColor: ColorRes.white,
              )
          )
        ],
      ),
    );
  }
}
