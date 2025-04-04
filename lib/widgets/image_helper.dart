import '../utils/app_exports.dart';
import '../utils/images.dart';

class ImageHelper extends StatefulWidget {
  final String imagePath;
  final double? height;
  final double? width;
  final BoxFit fit;
  final bool? isUserProfileRound;

  const ImageHelper({
    super.key,
    required this.imagePath,
    this.height,
    this.width,
    this.isUserProfileRound,
    this.fit = BoxFit.cover,
  });

  @override
  State<ImageHelper> createState() => _ImageHelperState();
}

class _ImageHelperState extends State<ImageHelper> {
  Future<Widget>? _imageWidgetFuture;

  Future<bool> _isAssetImage(String path) async {
    try {
      await rootBundle.load(path);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<Widget> _getImageWidget(String path) async {
    if (await _isAssetImage(path)) {
      return Image.asset(
        path,
        height: widget.height,
        width: widget.width,
        fit: widget.fit,
      );
    } else {
      return CachedNetworkImage(
        imageUrl: path,
        height: widget.height,
        width: widget.width,
        fit: widget.fit,
        placeholder: (context, url) => SizedBox(
          height: widget.height,
          width: widget.width,
          child: LinearProgressIndicator(
            color: AppColors.white.withOpacity(0.5),
            backgroundColor: AppColors.grey.withOpacity(0.1),
          ),
        ),
        errorWidget: (context, url, error) => Center(
          child: widget.isUserProfileRound == true
              ? Image.asset(AppImages.userPlaceHolder)
              : SizedBox(
                  height: widget.height,
                  width: widget.width,
                  child: SvgPicture.asset(
                    AppImages.userPlaceHolder,
                    fit: BoxFit.contain,
                  ),
                ),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _imageWidgetFuture = _getImageWidget(widget.imagePath);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
      future: _imageWidgetFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            height: widget.height,
            width: widget.width,
            child: LinearProgressIndicator(
              color: AppColors.white.withOpacity(0.5),
              backgroundColor: AppColors.grey.withOpacity(0.1),
            ),
          );
        } else if (snapshot.hasData) {
          return snapshot.data!;
        } else {
          return Center(
            child: widget.isUserProfileRound == true
                ? Image.asset(AppImages.userPlaceHolder)
                : SvgPicture.asset(AppImages.userPlaceHolder),
          );
        }
      },
    );
  }
}

class RenderNetworkImage extends StatefulWidget {
  final String imagePath;
  final double? height;
  final double? width;
  final BoxFit fit;
  final Color? imageColor;
  final BlendMode? blendMode;

  const RenderNetworkImage({
    super.key,
    required this.imagePath,
    this.height,
    this.width,
    this.fit = BoxFit.cover,
    this.imageColor,
    this.blendMode,
  });

  @override
  State<RenderNetworkImage> createState() => _RenderNetworkImageState();
}

class _RenderNetworkImageState extends State<RenderNetworkImage> {
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: widget.imagePath,
      color: widget.imageColor,
      fit: widget.fit,
      width: widget.width,
      height: widget.height,
      colorBlendMode: widget.blendMode,
      placeholder: (context, url) => SizedBox(
        width: widget.width,
        height: widget.height,
        child: LinearProgressIndicator(
          color: AppColors.white.withOpacity(0.5),
          backgroundColor: AppColors.grey.withOpacity(0.1),
        ),
      ),
      errorWidget: (context, url, error) => Center(
        child: SizedBox(
          width: widget.width,
          height: widget.height,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: SvgPicture.asset(
              AppImages.userPlaceHolder,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}

class RenderAvatarImage extends StatefulWidget {
  final String imagePath;
  final double? height;
  final double? width;
  final BoxFit fit;

  const RenderAvatarImage({
    super.key,
    required this.imagePath,
    this.height,
    this.width,
    this.fit = BoxFit.cover,
  });

  @override
  State<RenderAvatarImage> createState() => _RenderAvatarImageState();
}

class _RenderAvatarImageState extends State<RenderAvatarImage> {
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: widget.imagePath,
      fit: widget.fit,
      width: widget.width,
      height: widget.height,
      placeholder: (context, url) => SizedBox(
        width: widget.width,
        height: widget.height,
        child: LinearProgressIndicator(
          color: AppColors.white.withOpacity(0.5),
          backgroundColor: AppColors.grey.withOpacity(0.1),
        ),
      ),
      errorWidget: (context, url, error) => Center(
        child: SizedBox(
          width: widget.width,
          height: widget.height,
          child: Image.asset(
            AppImages.userPlaceHolder,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
