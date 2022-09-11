import 'package:flutter/material.dart';

import '../../ui/resources/app_assets.dart';
import 'log_utils.dart';

class ImageUtils {
  const ImageUtils._internal();

  static Widget getNetworkImage(
    String? imageUrl, {
    String? placeholder,
    double? width,
    double? height,
    BoxFit? fit,
  }) {
    placeholder = placeholder ?? AppAssets.imgPlaceholder;
    return FadeInImage.assetNetwork(
      placeholder: placeholder,
      width: width,
      height: height,
      imageErrorBuilder: (context, error, stackTrace) {
        LogUtils.error(error);
        return _getErrorImage(
          placeholder!,
          width: width,
          height: height,
          fit: fit,
        );
      },
      image: imageUrl ?? '',
      fit: fit ?? BoxFit.fill,
    );
  }

  static Widget getLocalImage(
    String? imagePath, {
    String? placeholder,
    double? width,
    double? height,
    BoxFit? fit,
  }) {
    placeholder = placeholder ?? AppAssets.imgPlaceholder;
    return Image.asset(
      imagePath ?? placeholder,
      width: width,
      height: height,
      errorBuilder: (context, error, stackTrace) {
        LogUtils.error(error);
        return _getErrorImage(
          placeholder!,
          width: width,
          height: height,
          fit: fit,
        );
      },
      fit: fit ?? BoxFit.fill,
    );
  }

  static Widget _getErrorImage(
    String placeholder, {
    double? width,
    double? height,
    BoxFit? fit,
  }) {
    return Image.asset(
      placeholder,
      width: width,
      height: height,
      fit: fit ?? BoxFit.fill,
    );
  }
}
