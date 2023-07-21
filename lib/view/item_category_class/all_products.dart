import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:plant_shoap_app/controller/controller.dart';
import 'package:plant_shoap_app/datafile/model_data.dart';
import 'package:plant_shoap_app/model/plant_product.dart';
import 'package:plant_shoap_app/model/popular_plant.dart';
import 'package:plant_shoap_app/utils/color_category.dart';
import 'package:plant_shoap_app/utils/constant.dart';
import 'package:plant_shoap_app/utils/constantWidget.dart';
import 'package:plant_shoap_app/view/item_category_class/plant_detail_screen.dart';
import 'package:shimmer/shimmer.dart';

class AllProducts extends StatefulWidget {
  const AllProducts({Key? key}) : super(key: key);

  @override
  State<AllProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  List<PlantProduct> plantdata = Data.getPlantProductData();
  List<PopularPlant> popularplantdata = Data.getPopularPlantData();

  Future<bool> _future = Future<bool>.delayed(
    const Duration(milliseconds: 400),
    () {
      return true;
    },
  );

  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return FutureBuilder<bool>(
      future: _future,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.hasData) {
          return column();
        } else {
          return Shimmer.fromColors(
            baseColor: Colors.grey.withOpacity(0.14),
            highlightColor: bgColor,
            direction: ShimmerDirection.ltr,
            child: column(),
          );
        }
      },
    );
  }

  Widget column() {
    return GetBuilder<HomeScreenController>(
      init: HomeScreenController(),
      builder: (homeScreencontroller) {
        return SizedBox(
          height: 259.h,
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 259,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
            ),
            itemCount: plantdata.length,
            itemBuilder: (BuildContext context, int index) {
              return GetBuilder<PopularPlantDataScreen>(
                init: PopularPlantDataScreen(),
                builder: (setcontroller) {
                  return GestureDetector(
                    onTap: () {
                      Get.to(PlantDetail(
                        detail: popularplantdata[index],
                      ));
                    },
                    child: Stack(
                      children: [
                        Container(
                          width: 177.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.h),
                            color: const Color(0XFFE5E5E5),
                            image: DecorationImage(
                              image: AssetImage(
                                '${Constant.assetImagePath}${plantdata[index].image}',
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 20.w),
                            child: Column(
                              children: [
                                getVerSpace(201.h),
                                Row(
                                  children: [
                                    getCustomFont(
                                      '${plantdata[index].name}',
                                      16.sp,
                                      const Color(0XFF000000),
                                      1,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    getHorSpace(5.w),
                                    getCustomFont(
                                      '(${plantdata[index].category})',
                                      12.sp,
                                      regularBlack,
                                      1,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ],
                                ),
                                getVerSpace(4.h),
                                getCustomFont(
                                  '\$${plantdata[index].price.toString()}',
                                  14.sp,
                                  const Color(0XFF000000),
                                  1,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 149.w, top: 12.h),
                          child: GestureDetector(
                            onTap: () {
                              setcontroller.onLikeCHange(plantdata[index]);
                              print(plantdata[index].initialvalue);
                            },
                            child: plantdata[index].initialvalue
                                ? getAssetImage(
                                    'likefillIcon.png',
                                    height: 16.sp,
                                    width: 16.sp,
                                  )
                                : getAssetImage(
                                    'likeIcon.png',
                                    height: 16.sp,
                                    width: 16.sp,
                                  ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
