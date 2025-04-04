import 'dart:ui';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/app_exports.dart';
import '../../utils/colorful_log.dart';
import 'bloc/discover_bloc.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    Future.delayed(const Duration(milliseconds: 100), () {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: AppColors.bgWhite,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
        statusBarColor: AppColors.transparent,
      ));
    });
    super.initState();
  }

  final TextEditingController _searchController = TextEditingController();

  final places = placesData.map((json) => PlaceItem.fromJson(json)).toList();

  final discoverPlaces = [AppImages.seven, AppImages.three, AppImages.eight];

  void _performSearch(String query) {
    ColorLog.magenta(query);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DiscoverBloc(),
      child: Scaffold(
        backgroundColor: AppColors.bgWhite,
        body: Stack(
          children: [
            Column(
              children: [
                _headerSection(context),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        _mostRelevantSection(context),
                        _discoverNewPlaces(context),
                        SizedBox(height: 80.h)
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              left: 15.w,
              right: 15.w,
              bottom: 10.h,
              child: BlocBuilder<DiscoverBloc, DiscoverState>(
                builder: (context, state) {
                  return _buildBottomTabNav(context, state);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _discoverNewPlaces(BuildContext context) {
    double mediaWidth = MediaQuery.sizeOf(context).width;
    double mediaHeight = MediaQuery.sizeOf(context).height;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 15.w, top: 15.h),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Discover new places',
              style: TextStyle(
                height: 0.8.h,
                fontSize: 17.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.black,
                fontFamily: CustomFonts.rewalt,
              ),
            ),
          ),
        ),
        SizedBox(
          width: mediaWidth,
          height: mediaHeight / 5,
          child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
            itemBuilder: (context, index) {
              final place = discoverPlaces[index];
              return _smallPlacesCard(context, place);
            },
            separatorBuilder: (BuildContext context, i) =>
                SizedBox(width: 15.w),
            itemCount: discoverPlaces.length,
          ),
        )
      ],
    );
  }

  Widget _mostRelevantSection(BuildContext context) {
    double mediaWidth = MediaQuery.sizeOf(context).width;
    double mediaHeight = MediaQuery.sizeOf(context).height;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 15.w, top: 20.h),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'The most relevant',
              style: TextStyle(
                height: 0.8.h,
                fontSize: 17.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.black,
                fontFamily: CustomFonts.rewalt,
              ),
            ),
          ),
        ),
        SizedBox(
          width: mediaWidth,
          height: mediaHeight / 2.4,
          child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
            itemBuilder: (context, index) {
              final place = places[index];
              return _placeCard(context, place);
            },
            separatorBuilder: (BuildContext context, i) =>
                SizedBox(width: 15.w),
            itemCount: places.length,
          ),
        )
      ],
    );
  }

  Widget _smallPlacesCard(
    BuildContext context,
    String imageUrl,
  ) {
    double mediaWidth = MediaQuery.sizeOf(context).width;
    double mediaHeight = MediaQuery.sizeOf(context).height;
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(30.r),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(255, 255, 255, 0.2),
            blurRadius: 6,
            spreadRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      width: mediaWidth / 2.5,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30.r),
          bottomRight: Radius.circular(30.r),
        ),
        child: Image.asset(
          imageUrl,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _placeCard(
    BuildContext context,
    PlaceItem place,
  ) {
    double mediaWidth = MediaQuery.sizeOf(context).width;
    double mediaHeight = MediaQuery.sizeOf(context).height;
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(30.r),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(255, 255, 255, 0.2),
            blurRadius: 6,
            spreadRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      width: mediaWidth / 1.2,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30.r),
              bottomRight: Radius.circular(30.r),
            ),
            child: Stack(
              children: [
                Image.asset(
                  place.imageUrl,
                  height: (mediaHeight / 2.4) / 1.5,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 10.h,
                  right: 15.h,
                  child: Material(
                    color: AppColors.transparent,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30.r),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
                        child: InkWell(
                          splashColor: AppColors.white.withOpacity(0.3),
                          highlightColor: AppColors.transparent,
                          borderRadius: BorderRadius.circular(24),
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.all(8.h),
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(255, 255, 255, 0.2),
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(
                                color: AppColors.white.withOpacity(0.1),
                                width: 0.5,
                              ),
                            ),
                            child: SvgPicture.asset(AppImages.heart),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: 15.w, right: 15.w, top: 10.h, bottom: 2.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  place.name,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                    fontFamily: CustomFonts.rewalt,
                    color: AppColors.black,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.star_rounded,
                      size: 15.h,
                      color: AppColors.black,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      '${place.rating} (${place.reviewCount})',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 13.sp,
                        fontFamily: CustomFonts.rany,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15.w, bottom: 3.h),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '${place.guests} guests • ${place.bedrooms} bedrooms • ${place.beds} beds • ${place.bathrooms} bathroom',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w400,
                  fontSize: 11.sp,
                  fontFamily: CustomFonts.rany,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15.w),
            child: Row(
              children: [
                Text(
                  '€${place.originalPrice}',
                  style: TextStyle(
                    decoration: TextDecoration.lineThrough,
                    color: Colors.grey[500],
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                    fontFamily: CustomFonts.rany,
                  ),
                ),
                SizedBox(width: 4.h),
                Text(
                  '€${place.discountedPrice} night',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 13.sp,
                    fontFamily: CustomFonts.rany,
                  ),
                ),
                Text(
                  ' • €${place.totalPrice} total',
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontWeight: FontWeight.w500,
                    fontSize: 13.sp,
                    fontFamily: CustomFonts.rany,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _headerSection(BuildContext context) {
    double statusBarHeight = MediaQuery.paddingOf(context).top;
    double mediaWidth = MediaQuery.sizeOf(context).width;
    double mediaHeight = MediaQuery.sizeOf(context).height;
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40.r),
            bottomRight: Radius.circular(40.r),
          ),
          child: Image.asset(
            AppImages.eight,
            height: mediaHeight / 3.2,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        ),
        Container(
          height: mediaHeight / 3.2,
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 15.h,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40.r),
              bottomRight: Radius.circular(40.r),
            ),
            color: AppColors.black.withOpacity(0.7),
          ),
          child: Padding(
            padding: EdgeInsets.only(top: statusBarHeight - 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.near_me_rounded,
                          color: AppColors.white,
                          size: 10.h,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          'Norway',
                          style: TextStyle(
                            height: 0.8.h,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.white,
                            fontFamily: CustomFonts.rewalt,
                          ),
                        )
                      ],
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(50),
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset(
                            AppImages.userRound,
                            height: 20.h,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Hey, Mertin? Tell us where you\nwant to go',
                    style: TextStyle(
                      height: 0.8.h,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.white,
                      fontFamily: CustomFonts.rewalt,
                    ),
                  ),
                ),
                _searchInput(
                  controller: _searchController,
                  onChanged: _performSearch,
                  hintText: 'Search places',
                  secondaryText: 'Date range • Number of guests',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _searchInput({
    required TextEditingController controller,
    required Function(String) onChanged,
    required String hintText,
    required String secondaryText,
  }) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.r),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 7.h,
            ),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(255, 255, 255, 0.2),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: AppColors.white.withOpacity(0.1),
                width: 0.5,
              ),
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  AppImages.search,
                  height: 17.h,
                  color: Colors.white70,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: controller,
                        onChanged: onChanged,
                        style: TextStyle(color: AppColors.white),
                        decoration: InputDecoration(
                          hintText: hintText,
                          hintStyle: TextStyle(
                            fontSize: 13.sp,
                            color: Colors.white70,
                            fontWeight: FontWeight.w500,
                            fontFamily: CustomFonts.rewalt,
                          ),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                      Text(
                        secondaryText,
                        style: TextStyle(
                          color: AppColors.white.withOpacity(0.6),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          fontFamily: CustomFonts.rewalt,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomTabNav(BuildContext context, DiscoverState state) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(40.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 12.h,
          ),
          decoration: BoxDecoration(
            color: AppColors.black.withOpacity(0.9),
            borderRadius: BorderRadius.circular(40.r),
            border: Border.all(
              color: AppColors.white.withOpacity(0.1),
              width: 0.5,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNavItemWithLabel(
                AppImages.discover,
                "Discover",
                0 == state.selectedBottomTabIndex,
                () {
                  context
                      .read<DiscoverBloc>()
                      .add(ChangeBottomTabIndexEvent(0));
                },
              ),
              _buildNavItemWithLabel(
                AppImages.heart,
                "Favorites",
                1 == state.selectedBottomTabIndex,
                () {
                  context
                      .read<DiscoverBloc>()
                      .add(ChangeBottomTabIndexEvent(1));
                },
              ),
              _buildNavItemWithLabel(
                AppImages.screenMirroring,
                "Bookings",
                2 == state.selectedBottomTabIndex,
                () {
                  context
                      .read<DiscoverBloc>()
                      .add(ChangeBottomTabIndexEvent(2));
                },
              ),
              _buildNavItemWithLabel(
                AppImages.messages,
                "Messages",
                3 == state.selectedBottomTabIndex,
                () {
                  context
                      .read<DiscoverBloc>()
                      .add(ChangeBottomTabIndexEvent(3));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItemWithLabel(
    String icon,
    String label,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: () {
        HapticFeedback.heavyImpact();
        onTap();
      },
      splashColor: AppColors.transparent,
      highlightColor: AppColors.transparent,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        child: TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 1.0, end: 1.0),
          duration: const Duration(milliseconds: 150),
          builder: (context, value, child) {
            return Transform.scale(
              scale: value,
              child: child,
            );
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                icon,
                height: 18.h,
                width: 18.w,
                color: isSelected
                    ? AppColors.white
                    : AppColors.white.withOpacity(0.6),
              ),
              SizedBox(height: 4.h),
              Text(
                label,
                style: TextStyle(
                  color: isSelected
                      ? AppColors.white
                      : AppColors.white.withOpacity(0.6),
                  fontSize: 10.sp,
                  fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
