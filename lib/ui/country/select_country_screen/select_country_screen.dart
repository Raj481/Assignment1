
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
            child: GridView.builder(
              physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // number of items in each row
                  mainAxisSpacing: 1.0, // spacing between rows
                  crossAxisSpacing: 1.0, // spacing between columns
                ),
                itemCount: 20,
                itemBuilder: (_, index){
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 100,
                        width:  100,
                        child: Image(
                          image: AssetImage(
                              ImageRes.imgCountry
                          ),
                        ),
                      ),
                      const SizedBox(height: 8,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15
                            ),
                            child: Flexible(
                              child: Text(
                                "New Zealand",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: ColorRes.white,
                                    fontSize: 18,
                                    fontFamily: FontRes.regular
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }
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
