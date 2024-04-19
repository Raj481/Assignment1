
import 'package:appassesment/controller/select_country_screen_controller.dart';
import 'package:appassesment/ui/country/select_country_screen/widget/select_country_bottom_view.dart';
import 'package:appassesment/ui/country/select_country_screen/widget/select_country_topbar_view.dart';
import 'package:appassesment/utils/color_res.dart';
import 'package:appassesment/utils/font_res.dart';
import 'package:appassesment/utils/image_res.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SelectCountryScreen extends StatelessWidget {
  const SelectCountryScreen({super.key});

  @override
  Widget build(BuildContext context) {

    SelectCountryScreenController controller = Get.put(SelectCountryScreenController());

    return Scaffold(
      backgroundColor: ColorRes.bgDarkGrey,
      body: Column(
        children: [
          SelectCountryTopBarView(
            onBackTap: () {  },
          ),
          Flexible(
            child: GetBuilder(
              init: controller,
              builder: (_) {
                return GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // number of items in each row
                      mainAxisSpacing: 8.0, // spacing between rows
                      crossAxisSpacing: 8.0, // spacing between columns
                    ),
                    itemCount: controller.getCountries.length,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 25
                    ),
                    itemBuilder: (_, index){
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          if(controller.getCountries.elementAt(index).image!.trim().isNotEmpty)
                            SizedBox(
                              height: 90,
                              width:  90,
                              child: Container(
                                foregroundDecoration: const BoxDecoration(
                                  color: Colors.white,
                                  backgroundBlendMode: BlendMode.saturation,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        controller.getCountries.elementAt(index).image!
                                    )
                                  )
                                ),
                              ),
                            ),
                          if(controller.getCountries.elementAt(index).image!.trim().isEmpty)
                            const SizedBox(
                              height: 90,
                              width:  90,
                            ),
                          const SizedBox(height: 8,),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: Text(
                                    controller.getCountries.elementAt(index).name ?? "",
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: ColorRes.white,
                                        fontSize: 17,
                                        fontFamily: FontRes.regular
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }
                );
              },
            ),
          ),
          SelectCountryBottomView(
            controller: controller,
            onProceedTap: () => controller.onProceedTap(),
          )
        ],
      ),
    );
  }
}
