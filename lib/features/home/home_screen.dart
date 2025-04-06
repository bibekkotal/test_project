import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../data/plan_response.dart';
import '../../services/plan_services.dart';
import '../../utils/app_exports.dart';
import '../../utils/colorful_log.dart';
import '../../widgets/appbar.dart';
import 'bloc/home_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    Future.delayed(const Duration(milliseconds: 100), () {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: AppColors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: AppColors.white,
      ));
    });
    super.initState();
  }

  late HomeBloc homeBloc;

  @override
  Widget build(BuildContext context) {
    String today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    return BlocProvider(
      create: (_) => HomeBloc(PlanServices())
        ..add(GenerateWeekDatesEvent())
        ..add(GetPlansByDateEvent(today)),
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          bottom: false,
          child: Stack(
            children: [
              Column(
                children: [
                  const CustomAppBar(
                    imageUrl:
                        'https://xinva.ai/wp-content/uploads/2023/12/105.jpg',
                    displayName: 'Sandra',
                  ),
                  SizedBox(height: 5.h),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          SizedBox(height: 10.h),
                          _topBannerSection(context),
                          BlocConsumer<HomeBloc, HomeState>(
                            listener: (context, state) {},
                            builder: (context, state) {
                              homeBloc = context.read<HomeBloc>();
                              return _dateSelector(context, state.weekDates,
                                  state.selectedIndex);
                            },
                          ),
                          _planSection(context,
                              'https://xinva.ai/wp-content/uploads/2023/12/106.jpg'),
                          _buildPlansList(context),
                          SizedBox(height: 70.h),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                left: 25.w,
                right: 25.w,
                bottom: 10.h,
                child: BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    return Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(40.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ...[
                            AppImages.home,
                            AppImages.widget,
                            AppImages.chartSquare,
                            AppImages.user,
                          ].asMap().entries.map((entry) {
                            int index = entry.key;
                            String icon = entry.value;
                            return _buildNavItem(
                                icon, index == state.selectedBottomTabIndex,
                                () {
                              context
                                  .read<HomeBloc>()
                                  .add(ChangeBottomTabIndexEvent(index));
                            });
                          }),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    String icon,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return TweenAnimationBuilder(
        duration: const Duration(milliseconds: 200),
        tween: Tween<double>(begin: 1.0, end: isSelected ? 1.1 : 1.0),
        builder: (context, double value, child) {
          return Transform.scale(
            scale: value,
            child: Material(
              color: AppColors.transparent,
              child: InkWell(
                onTap: onTap,
                borderRadius: BorderRadius.circular(100.r),
                splashColor: AppColors.white.withOpacity(0.2),
                highlightColor: AppColors.white.withOpacity(0.1),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    TweenAnimationBuilder<double>(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.elasticOut,
                      tween: Tween<double>(
                        begin: 0,
                        end: isSelected ? 1.0 : 0,
                      ),
                      builder: (context, animValue, _) {
                        return Transform.rotate(
                          angle: (1 - animValue) * pi / 2,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            width: 50.w,
                            height: 50.h,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.white
                                  : AppColors.transparent,
                              shape: BoxShape.circle,
                              boxShadow: isSelected
                                  ? [
                                      BoxShadow(
                                        color: AppColors.white.withOpacity(0.3),
                                        blurRadius: 5.0,
                                        spreadRadius: 1.0,
                                      )
                                    ]
                                  : null,
                            ),
                          ),
                        );
                      },
                    ),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                        return FadeTransition(
                          opacity: animation,
                          child: SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(0, 0.5),
                              end: Offset.zero,
                            ).animate(animation),
                            child: child,
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(5.w),
                        child: SvgPicture.asset(
                          icon,
                          key: ValueKey<bool>(isSelected),
                          width: 25.h,
                          height: 24.h,
                          color: isSelected ? AppColors.black : AppColors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget _topBannerSection(BuildContext context) {
    double mediaWidth = MediaQuery.sizeOf(context).width;
    double mediaHeight = MediaQuery.sizeOf(context).height;

    List<String> imageList = [
      'https://xinva.ai/wp-content/uploads/2023/12/100.jpg',
      'https://xinva.ai/wp-content/uploads/2023/12/110.jpg',
      'https://xinva.ai/wp-content/uploads/2023/12/106.jpg',
      'https://xinva.ai/wp-content/uploads/2023/12/106.jpg',
      'https://xinva.ai/wp-content/uploads/2023/12/106.jpg',
      'https://xinva.ai/wp-content/uploads/2023/12/106.jpg',
    ];

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          margin:
              EdgeInsets.only(left: 15.w, right: 15.w, top: 20.h, bottom: 5.h),
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.melRose.withOpacity(0.9),
            borderRadius: BorderRadius.circular(26.r),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 15.w,
            vertical: 15.h,
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Daily\nchallenge',
                  style: TextStyle(
                    height: 0.8.h,
                    fontSize: 30.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black,
                  ),
                ),
                SizedBox(height: 5.h),
                Text(
                  'Do your plan before 09:00 AM',
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.black,
                  ),
                ),
                SizedBox(height: 10.h),
                _imageStack(
                  imageUrls: imageList,
                  maxVisible: 3,
                  overlapAmount: 30,
                  avatarRadius: 15.h,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: mediaWidth / 9,
          bottom: mediaHeight / 14,
          child: Container(
            height: 5,
            width: mediaWidth / 4,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withOpacity(0.8),
                  spreadRadius: 8,
                  blurRadius: 35,
                  offset: const Offset(0.5, 8),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: -(mediaHeight / 60),
          right: -(mediaWidth / 9),
          child: Image.asset(
            AppImages.banner1,
            width: mediaWidth / 1.5,
            height: mediaHeight / 4.2,
          ),
        ),
      ],
    );
  }

  Widget _imageStack({
    required List<String> imageUrls,
    required int maxVisible,
    required double overlapAmount,
    required double avatarRadius,
  }) {
    final totalCount = imageUrls.length;
    final visibleCount = totalCount > maxVisible ? maxVisible : totalCount;
    final remainingCount = totalCount - visibleCount;
    return SizedBox(
      height: avatarRadius * 2,
      child: Stack(
        children: [
          Positioned(
            left: visibleCount > 0
                ? (visibleCount - 1) * overlapAmount + (avatarRadius * 2 * 0.7)
                : 0,
            child: Container(
              width: (avatarRadius * 2) - 3,
              height: (avatarRadius * 2) - 3,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.darkerMelRose,
              ),
              child: Center(
                child: Text(
                  '+$remainingCount',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: (avatarRadius * 0.5).sp,
                    fontFamily: CustomFonts.rany,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          for (int i = 0; i < visibleCount; i++)
            Positioned(
              left: i * overlapAmount,
              child: ClipOval(
                child: SizedBox(
                  width: avatarRadius * 2,
                  height: avatarRadius * 2,
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.melRose.withOpacity(0.8),
                            width: 2,
                          ),
                        ),
                        child: ClipOval(
                          child: SizedBox(
                            width: avatarRadius * 2,
                            height: avatarRadius * 2,
                            child: imageUrls[i].isNotEmpty
                                ? Image.network(
                                    imageUrls[i],
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Image.asset(
                                      AppImages.userPlaceHolder,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Image.asset(
                                    AppImages.userPlaceHolder,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _dateSelector(
    BuildContext context,
    List<DateTime> weekDates,
    int selectedIndex,
  ) {
    double mediaWidth = MediaQuery.sizeOf(context).width;
    return SizedBox(
      height: 70.h,
      width: mediaWidth,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 15.w),
        itemBuilder: (context, index) {
          bool isSelected = index == selectedIndex;
          DateTime date = weekDates[index];
          return InkWell(
            borderRadius: BorderRadius.circular(25.r),
            splashColor: Colors.black26,
            onTap: () {
              context.read<HomeBloc>().add(SelectDateEvent(index));
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              width: mediaWidth / 8.5,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.black : AppColors.white,
                borderRadius: BorderRadius.circular(25.r),
                border: Border.all(color: Colors.black12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  index % 2 == 0
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 4.0),
                          child: Icon(Icons.circle,
                              size: 6,
                              color: isSelected
                                  ? AppColors.white
                                  : AppColors.black),
                        )
                      : const Padding(padding: EdgeInsets.only(bottom: 4.0)),
                  Text(
                    DateFormat('E').format(date),
                    style: TextStyle(
                      color: isSelected ? AppColors.white : Colors.black54,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    date.day.toString(),
                    style: TextStyle(
                      color: isSelected ? AppColors.white : AppColors.black,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, i) => SizedBox(width: 5.w),
        itemCount: weekDates.length,
      ),
    );
  }

  Widget _planSection(BuildContext context, String imageUrl) {
    double mediaWidth = MediaQuery.sizeOf(context).width;
    double mediaHeight = MediaQuery.sizeOf(context).height;
    return Padding(
      padding:
          EdgeInsets.only(top: 15.h, left: 15.w, right: 15.w, bottom: 10.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                StaticStrings.yourPlan,
                style: TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 25.sp,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  final _formKey = GlobalKey<FormState>();

                  final titleController = TextEditingController();
                  final roomController = TextEditingController();
                  final trainerController = TextEditingController();
                  String selectedLevel = 'Medium';

                  TimeOfDay? startTime;
                  TimeOfDay? endTime;
                  final timeController = TextEditingController();

                  Future<void> pickTimeRange() async {
                    startTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (startTime != null) {
                      endTime = await showTimePicker(
                        context: context,
                        initialTime: startTime!,
                      );
                      if (endTime != null) {
                        timeController.text =
                            '${startTime!.format(context)}-${endTime!.format(context)}';
                      }
                    }
                  }

                  void onCreatePlan(PlanUpdatePayload plan) {
                    homeBloc.add(SendUpdatePlansEvent(payload: plan));
                  }

                  showDialog(
                    context: context,
                    builder: (ctx) {
                      return Dialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.r),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(20.w),
                          child: SingleChildScrollView(
                            child: Form(
                              key: _formKey,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextFormField(
                                    controller: titleController,
                                    decoration: InputDecoration(
                                      hintText: 'Title',
                                      filled: true,
                                      fillColor:
                                          AppColors.orange.withOpacity(0.1),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.r),
                                        borderSide: BorderSide.none,
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 15.w, vertical: 12.h),
                                    ),
                                    maxLength: 15,
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return 'Title is required';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 12.h),
                                  FormField<String>(
                                    initialValue: selectedLevel,
                                    builder: (FormFieldState<String> state) {
                                      return Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15.w),
                                        decoration: BoxDecoration(
                                          color:
                                              AppColors.orange.withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(20.r),
                                          border: state.hasError
                                              ? Border.all(
                                                  color: Colors.red, width: 1)
                                              : null,
                                        ),
                                        child: DropdownButtonFormField<String>(
                                          value: selectedLevel,
                                          isExpanded: true,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            errorText: state.errorText,
                                            errorStyle: TextStyle(
                                              color: Colors.red,
                                              fontSize: 12.sp,
                                            ),
                                          ),
                                          dropdownColor: AppColors.white,
                                          items: ['Medium', 'Light']
                                              .map((e) => DropdownMenuItem(
                                                    value: e,
                                                    child: Text(
                                                      e,
                                                      style: TextStyle(
                                                          fontSize: 14.sp),
                                                    ),
                                                  ))
                                              .toList(),
                                          onChanged: (value) {
                                            if (value != null) {
                                              selectedLevel = value;
                                              state.didChange(value);
                                            }
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                  SizedBox(height: 12.h),
                                  FormField<String>(
                                    initialValue: timeController.text,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Time is required';
                                      }
                                      return null;
                                    },
                                    builder: (FormFieldState<String> state) {
                                      return GestureDetector(
                                        onTap: () async {
                                          await pickTimeRange();
                                          state.didChange(timeController.text);
                                        },
                                        child: AbsorbPointer(
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 8.h),
                                            child: TextField(
                                              controller: timeController,
                                              readOnly: true,
                                              decoration: InputDecoration(
                                                labelText:
                                                    'Time (e.g. 14:00-15:00)',
                                                filled: true,
                                                fillColor: AppColors.orange
                                                    .withOpacity(0.1),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.r),
                                                  borderSide: BorderSide.none,
                                                ),
                                                suffixIcon: Icon(
                                                    Icons.access_time,
                                                    color: AppColors.darkPink),
                                                errorText: state.errorText,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  SizedBox(height: 12.h),
                                  TextFormField(
                                    controller: roomController,
                                    decoration: InputDecoration(
                                      hintText: 'Room',
                                      filled: true,
                                      fillColor:
                                          AppColors.orange.withOpacity(0.1),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.r),
                                        borderSide: BorderSide.none,
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 15.w, vertical: 12.h),
                                    ),
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return 'Room is required';
                                      }
                                      return null;
                                    },
                                    maxLength: 2,
                                  ),
                                  SizedBox(height: 12.h),
                                  TextFormField(
                                    controller: trainerController,
                                    decoration: InputDecoration(
                                      hintText: 'Trainer',
                                      filled: true,
                                      fillColor:
                                          AppColors.orange.withOpacity(0.1),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.r),
                                        borderSide: BorderSide.none,
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 15.w, vertical: 12.h),
                                    ),
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return 'Trainer name is required';
                                      }
                                      return null;
                                    },
                                    maxLength: 15,
                                    maxLengthEnforcement:
                                        MaxLengthEnforcement.none,
                                    buildCounter: (_,
                                            {required currentLength,
                                            required isFocused,
                                            required maxLength}) =>
                                        null,
                                  ),
                                  SizedBox(height: 20.h),
                                  ElevatedButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        final plan = PlanUpdatePayload(
                                          title: titleController.text,
                                          level: selectedLevel,
                                          time: timeController.text,
                                          room: roomController.text,
                                          trainer: trainerController.text,
                                        );
                                        onCreatePlan(plan);
                                        Navigator.pop(ctx);
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.darkPink,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.r),
                                      ),
                                    ),
                                    child: Text(
                                      'Save Plan',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: AppColors.white,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  backgroundColor: AppColors.indicatorColor.withOpacity(0.3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                ),
                child: Text(
                  'Add plan',
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.white,
                  ),
                ),
              ),
            ],
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: mediaWidth,
              maxHeight: mediaHeight / 2.7,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 30,
                    child: Container(
                      margin: EdgeInsets.only(right: 10.w),
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.w, vertical: 15.h),
                      decoration: BoxDecoration(
                        color: AppColors.orange,
                        borderRadius: BorderRadius.circular(25.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.white.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(25.r),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 3.h),
                            child: Text(
                              StaticStrings.medium,
                              style: TextStyle(
                                color: AppColors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 10.sp,
                              ),
                            ),
                          ),
                          SizedBox(height: 20.h),
                          Text(
                            StaticStrings.yogaGroup,
                            style: TextStyle(
                              color: AppColors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 20.sp,
                            ),
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            '25 Nov.',
                            style: TextStyle(
                              color: AppColors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 13.sp,
                            ),
                          ),
                          Text(
                            '14:00-15:00',
                            style: TextStyle(
                              color: AppColors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 13.sp,
                            ),
                          ),
                          Text(
                            'A5 room',
                            style: TextStyle(
                              color: AppColors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 13.sp,
                            ),
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 15.h,
                                backgroundImage: imageUrl != ''
                                    ? NetworkImage(imageUrl)
                                    : const AssetImage(
                                            AppImages.userPlaceHolder)
                                        as ImageProvider,
                              ),
                              SizedBox(width: 5.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Trainer',
                                    style: TextStyle(
                                      color: AppColors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13.sp,
                                    ),
                                  ),
                                  Text(
                                    'Tiffany Way',
                                    style: TextStyle(
                                      color: AppColors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 26,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 4,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                width: double.infinity,
                                margin: EdgeInsets.only(bottom: 10.h),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15.w, vertical: 15.h),
                                decoration: BoxDecoration(
                                  color: AppColors.cyanLight,
                                  borderRadius: BorderRadius.circular(25.r),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: AppColors.white.withOpacity(0.3),
                                        borderRadius:
                                            BorderRadius.circular(25.r),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.w, vertical: 3.h),
                                      child: Text(
                                        StaticStrings.light,
                                        style: TextStyle(
                                          color: AppColors.black,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 10.sp,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 20.h),
                                    Text(
                                      'Balance',
                                      style: TextStyle(
                                        color: AppColors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20.sp,
                                      ),
                                    ),
                                    SizedBox(height: 5.h),
                                    Text(
                                      '28 Nov.',
                                      style: TextStyle(
                                        color: AppColors.black,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 13.sp,
                                      ),
                                    ),
                                    Text(
                                      '18:00-19:30',
                                      style: TextStyle(
                                        color: AppColors.black,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 13.sp,
                                      ),
                                    ),
                                    Text(
                                      'A5 room',
                                      style: TextStyle(
                                        color: AppColors.black,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                right: mediaWidth / 50,
                                bottom: mediaHeight / 20,
                                child: Container(
                                  height: 5,
                                  width: mediaWidth / 4,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.black.withOpacity(0.8),
                                        spreadRadius: 8,
                                        blurRadius: 38,
                                        offset: const Offset(0.5, 8),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: (mediaHeight / 22),
                                right: -(mediaWidth / 9),
                                child: Image.asset(
                                  AppImages.banner2,
                                  width: mediaWidth / 2.6,
                                  height: mediaHeight / 7,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            decoration: BoxDecoration(
                              color: AppColors.pinkLight,
                              borderRadius: BorderRadius.circular(25.r),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _iconButtons(
                                  AppImages.instagram,
                                  () {},
                                ),
                                _iconButtons(
                                  AppImages.youtube,
                                  () {},
                                ),
                                _iconButtons(
                                  AppImages.facebook,
                                  () {},
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPlansList(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final plans = state.userPlansData?.plans ?? [];

        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (plans.isEmpty) {
          return const SizedBox.shrink();
        }

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 15.w,
              mainAxisSpacing: 15.h,
              childAspectRatio: 0.75,
            ),
            itemCount: plans.length,
            itemBuilder: (context, index) {
              final plan = plans[index];
              final isMedium = plan.level.toLowerCase() == 'medium';
              return isMedium
                  ? _buildMediumPlanCard(plan)
                  : _buildLightPlanCard(context, plan);
            },
          ),
        );
      },
    );
  }

  Widget _buildMediumPlanCard(Plan plan) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
      decoration: BoxDecoration(
        color: AppColors.orange,
        borderRadius: BorderRadius.circular(25.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.white.withOpacity(0.3),
              borderRadius: BorderRadius.circular(25.r),
            ),
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
            child: Text(
              plan.level,
              style: TextStyle(
                color: AppColors.black,
                fontWeight: FontWeight.w400,
                fontSize: 10.sp,
              ),
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            plan.title,
            style: TextStyle(
              color: AppColors.black,
              fontWeight: FontWeight.w500,
              fontSize: 20.sp,
            ),
          ),
          SizedBox(height: 5.h),
          Text(
            plan.date ?? "",
            style: TextStyle(
              color: AppColors.black,
              fontWeight: FontWeight.w400,
              fontSize: 13.sp,
            ),
          ),
          Text(
            plan.time,
            style: TextStyle(
              color: AppColors.black,
              fontWeight: FontWeight.w400,
              fontSize: 13.sp,
            ),
          ),
          Text(
            plan.room,
            style: TextStyle(
              color: AppColors.black,
              fontWeight: FontWeight.w400,
              fontSize: 13.sp,
            ),
          ),
          const Spacer(),
          Row(
            children: [
              CircleAvatar(
                radius: 15.h,
                backgroundImage: const AssetImage(AppImages.userPlaceHolder),
              ),
              SizedBox(width: 5.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Trainer",
                      style: TextStyle(
                        color: AppColors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 13.sp,
                      ),
                    ),
                    Text(
                      plan.trainer,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLightPlanCard(BuildContext context, Plan plan) {
    return SizedBox(
      child: Column(
        children: [
          Expanded(
            flex: 4,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
              decoration: BoxDecoration(
                color: AppColors.cyanLight,
                borderRadius: BorderRadius.circular(25.r),
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.white.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(25.r),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 3.h),
                        child: Text(
                          plan.level,
                          style: TextStyle(
                            color: AppColors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 10.sp,
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        plan.title,
                        style: TextStyle(
                          color: AppColors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 20.sp,
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        plan.date ?? "",
                        style: TextStyle(
                          color: AppColors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 13.sp,
                        ),
                      ),
                      Text(
                        plan.time,
                        style: TextStyle(
                          color: AppColors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 13.sp,
                        ),
                      ),
                      Text(
                        plan.room,
                        style: TextStyle(
                          color: AppColors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 13.sp,
                        ),
                      ),
                    ],
                  ),
                  // Banner image
                  Positioned(
                    bottom: -10,
                    right: -20,
                    child: Image.asset(
                      AppImages.banner2,
                      width: 100.w,
                      height: 100.h,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _iconButtons(String icon, VoidCallback onTap) {
    return Material(
      color: AppColors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(100.r),
        splashColor: AppColors.darkPink.withOpacity(0.3),
        child: Ink(
          padding: EdgeInsets.all(5.w),
          decoration: BoxDecoration(
            color: AppColors.white,
            border: Border.all(color: AppColors.darkPink, width: 5),
            shape: BoxShape.circle,
          ),
          child: SvgPicture.asset(
            icon,
            width: 15.h,
            height: 15.h,
            color: AppColors.darkPink,
          ),
        ),
      ),
    );
  }
}
