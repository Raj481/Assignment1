
 import 'package:appassesment/model/country_model.dart';
import 'package:appassesment/utils/color_res.dart';
import 'package:appassesment/utils/font_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CountryRectangleItemView extends StatelessWidget {
  final CountryModel model;
   const CountryRectangleItemView({
     super.key,
     required this.model
   });
   @override
   Widget build(BuildContext context) {
     return Container(
       constraints: const BoxConstraints(
         minHeight: 45
       ),
       margin: const EdgeInsets.symmetric(
         horizontal: .15, vertical: .15
       ),
       padding: const EdgeInsets.symmetric(
         horizontal: 15,
         vertical: 5
       ),
       decoration: BoxDecoration(
           color: ColorRes.bgDarkGrey,
         borderRadius: BorderRadius.circular(0)
       ),
       child:  Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [
           Flexible(
             child: Row(
               mainAxisSize: MainAxisSize.min,
               children: [
                 if(model.flag != null)
                 SizedBox(
                   width: 25,
                   height: 25,
                   child: SvgPicture.network(
                     model.flag!,
                   ),
                 ),
                 if(model.flag == null)
                   const SizedBox(
                     width: 25,
                     height: 25,
                   ),
                 const SizedBox( width: 10,),
                 Flexible(
                   child: Text(
                     model.name ?? "",
                     style: TextStyle(
                         color: ColorRes.white,
                         fontSize: 18,
                         fontFamily: FontRes.smMedium
                     ),
                     overflow: TextOverflow.ellipsis,
                   ),
                 ),
               ],
             ),
           ),
           const SizedBox(width: 10,),
           Text(
             model.telCode ?? "",
             style: TextStyle(
                 color: ColorRes.white,
                 fontSize: 18,
                 fontFamily: FontRes.smMedium
             ),
             overflow: TextOverflow.ellipsis,
           ),
         ],
       ),
     );
   }
 }
