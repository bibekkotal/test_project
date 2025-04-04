import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../utils/app_exports.dart';
import '../../widgets/appbar.dart';
// import 'bloc/discover_bloc.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: AppColors.bgWhite,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: AppColors.transparent,
    ));

    return Scaffold(
      backgroundColor: AppColors.bgWhite,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 200.h,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0x98C5EE66),
                    Color(0x00D6FF75),
                  ],
                  stops: [0.2, 1.0],
                ),
              ),
            ),
          ),
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                const CustomAppBarNoBackground(
                  imageUrl:
                      'https://xinva.ai/wp-content/uploads/2023/12/105.jpg',
                  displayName: 'Sandra',
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.h, left: 10.w, bottom: 20.w),
                  child: Row(
                    children: [
                      Material(
                        color: AppColors.transparent,
                        child: InkWell(
                          onTap: () {},
                          borderRadius: BorderRadius.circular(100.r),
                          child: Container(
                            padding: EdgeInsets.all(9.w),
                            decoration:
                                const BoxDecoration(shape: BoxShape.circle),
                            child: SvgPicture.asset(
                              AppImages.back,
                              width: 25.h,
                              height: 25.h,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        'Choose Seats',
                        style: TextStyle(
                            height: 0.8.h,
                            fontSize: 27.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.black,
                            fontFamily: CustomFonts.rewalt),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 25.w, vertical: 10.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _optionsSection(AppColors.melRose, 'Selected'),
                      _optionsSection(AppColors.black, 'Reserved'),
                      _optionsSection(AppColors.yellowishGrey, 'Available'),
                    ],
                  ),
                ),
                _checkOutSection(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _optionsSection(Color color, String title) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(right: 5.w),
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          height: 10.h,
          width: 10.h,
        ),
        Text(
          title,
          style: TextStyle(
            height: 0.8.h,
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.black,
            fontFamily: CustomFonts.rewalt,
          ),
        ),
      ],
    );
  }

  Widget _checkOutSection(BuildContext context) {
    double mediaWidth = MediaQuery.sizeOf(context).width;
    double mediaHeight = MediaQuery.sizeOf(context).height;
    return Container(
      height: 120.h,
      margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: AppColors.black,
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset(
                AppImages.locationPin,
                color: Colors.white,
                height: 15.h,
              ),
            ],
          )
        ],
      ),
    );
  }
}
