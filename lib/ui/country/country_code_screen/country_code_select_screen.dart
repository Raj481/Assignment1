
import 'package:appassesment/controller/country_list_screen_controller.dart';
import 'package:appassesment/utils/color_res.dart';
import 'package:appassesment/widget/utils/custom_ui_utils.dart';
import 'package:appassesment/utils/font_res.dart';
import 'package:appassesment/utils/image_res.dart';
import 'package:appassesment/utils/string_res.dart';
import 'package:appassesment/widget/common/divider_gradient_view.dart';
import 'package:appassesment/widget/common/search_view.dart';
import 'package:appassesment/ui/country/country_code_screen/widget/country_rectangle_item_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CountryCodeSelectScreen extends StatelessWidget {
  const CountryCodeSelectScreen({super.key});

  @override
  Widget build(BuildContext context) {

    CountryListScreenController controller = Get.put(CountryListScreenController());

    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: ColorRes.bgDarkGrey,
        body: Column(
          children: [
            Container(
            padding: const EdgeInsets.only(
              bottom: 10
            ),
            decoration: BoxDecoration(
              color: ColorRes.bgDarkGrey,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: 18,
                          top: Get.statusBarHeight
                      ),
                      child: GestureDetector(
                        onTap: controller.onBackTap,
                        child: Image(
                            image: AssetImage(
                                ImageRes.icBack
                            ),
                            height: 45,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      StringRes.selectYourCountry,
                      style: TextStyle(
                          color: ColorRes.white,
                          fontSize: 24,
                          fontFamily: FontRes.regular
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: GetBuilder(
                          init: controller,
                          builder: (_) {
                            return SearchView(
                              controller: controller.searchController,
                              onTextChanged: (value){
                                controller.searchedCountry();
                              },
                            );
                          },
                        )
                    )
                  ],
                ),
              ],
            ),
          ),
            const DividerGradientView(
              margin: EdgeInsets.zero,
            ),
            GetBuilder(
                init: controller,
                builder: (_){

                  if(controller.isLoading){
                    return Expanded(
                        child: Center(
                            child: CustomUiUtils.loaderWidget()
                        )
                    );
                  }

                  return Flexible(
                    child: RefreshIndicator(
                      color: ColorRes.textDarkBrown,
                      backgroundColor: ColorRes.white,
                      onRefresh: () async {
                        await controller.fetchCountries(
                          isRefresh: true
                        );
                        return Future.value(true);
                      },
                      child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.only(
                              top: 25, bottom: 25,
                              left: 15, right: 15
                          ),
                          itemCount: controller.getCountries.length,
                          itemBuilder: (_, index){
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                InkWell(
                                  onTap: () => controller.onCountryTap(
                                      controller.getCountries.elementAt(index)
                                  ),
                                  child: CountryRectangleItemView(
                                    model: controller.getCountries.elementAt(index),
                                  ),
                                ),
                                if(index != (controller.getCountries.length - 1) )
                                  const DividerGradientView(),
                              ],
                            );
                          }
                      ),
                    ),
                  );
                }
            )
          ],
        ),
      ),
    );
  }
}
