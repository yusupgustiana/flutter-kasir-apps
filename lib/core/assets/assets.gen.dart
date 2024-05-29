/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';

class $AssetsIconGen {
  const $AssetsIconGen();

  /// File path: assets/icon/all_categories.svg
  SvgGenImage get allCategories =>
      const SvgGenImage('assets/icon/all_categories.svg');

  /// File path: assets/icon/cash.svg
  SvgGenImage get cash => const SvgGenImage('assets/icon/cash.svg');

  /// File path: assets/icon/dashboard.svg
  SvgGenImage get dashboard => const SvgGenImage('assets/icon/dashboard.svg');

  /// File path: assets/icon/debit.svg
  SvgGenImage get debit => const SvgGenImage('assets/icon/debit.svg');

  /// File path: assets/icon/delete.svg
  SvgGenImage get delete => const SvgGenImage('assets/icon/delete.svg');

  /// File path: assets/icon/done.svg
  SvgGenImage get done => const SvgGenImage('assets/icon/done.svg');

  /// File path: assets/icon/drink.svg
  SvgGenImage get drink => const SvgGenImage('assets/icon/drink.svg');

  /// File path: assets/icon/food.svg
  SvgGenImage get food => const SvgGenImage('assets/icon/food.svg');

  /// File path: assets/icon/history.svg
  SvgGenImage get history => const SvgGenImage('assets/icon/history.svg');

  /// File path: assets/icon/home.svg
  SvgGenImage get home => const SvgGenImage('assets/icon/home.svg');

  /// File path: assets/icon/icon1.jpg
  AssetGenImage get icon1 => const AssetGenImage('assets/icon/icon1.jpg');

  /// File path: assets/icon/image.svg
  SvgGenImage get image => const SvgGenImage('assets/icon/image.svg');

  /// File path: assets/icon/orders.svg
  SvgGenImage get orders => const SvgGenImage('assets/icon/orders.svg');

  /// File path: assets/icon/payments.svg
  SvgGenImage get payments => const SvgGenImage('assets/icon/payments.svg');

  /// File path: assets/icon/print.svg
  SvgGenImage get print => const SvgGenImage('assets/icon/print.svg');

  /// File path: assets/icon/qr_code.svg
  SvgGenImage get qrCode => const SvgGenImage('assets/icon/qr_code.svg');

  /// File path: assets/icon/snack.svg
  SvgGenImage get snack => const SvgGenImage('assets/icon/snack.svg');

  /// List of all assets
  List<dynamic> get values => [
        allCategories,
        cash,
        dashboard,
        debit,
        delete,
        done,
        drink,
        food,
        history,
        home,
        icon1,
        image,
        orders,
        payments,
        print,
        qrCode,
        snack
      ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/f1.jpeg
  AssetGenImage get f1 => const AssetGenImage('assets/images/f1.jpeg');

  /// File path: assets/images/f2.jpeg
  AssetGenImage get f2 => const AssetGenImage('assets/images/f2.jpeg');

  /// File path: assets/images/f3.jpeg
  AssetGenImage get f3 => const AssetGenImage('assets/images/f3.jpeg');

  /// File path: assets/images/f4.jpeg
  AssetGenImage get f4 => const AssetGenImage('assets/images/f4.jpeg');

  /// File path: assets/images/f5.jpeg
  AssetGenImage get f5 => const AssetGenImage('assets/images/f5.jpeg');

  /// File path: assets/images/f6.jpeg
  AssetGenImage get f6 => const AssetGenImage('assets/images/f6.jpeg');

  /// File path: assets/images/f7.jpeg
  AssetGenImage get f7 => const AssetGenImage('assets/images/f7.jpeg');

  /// File path: assets/images/f8.jpeg
  AssetGenImage get f8 => const AssetGenImage('assets/images/f8.jpeg');

  /// File path: assets/images/kopi1.jpg
  AssetGenImage get kopi1 => const AssetGenImage('assets/images/kopi1.jpg');

  /// File path: assets/images/kopi2.jpg
  AssetGenImage get kopi2 => const AssetGenImage('assets/images/kopi2.jpg');

  /// File path: assets/images/logo.png
  AssetGenImage get logo => const AssetGenImage('assets/images/logo.png');

  /// File path: assets/images/manage_printer.png
  AssetGenImage get managePrinter =>
      const AssetGenImage('assets/images/manage_printer.png');

  /// File path: assets/images/manage_printerx.png
  AssetGenImage get managePrinterx =>
      const AssetGenImage('assets/images/manage_printerx.png');

  /// File path: assets/images/manage_product.png
  AssetGenImage get manageProduct =>
      const AssetGenImage('assets/images/manage_product.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        f1,
        f2,
        f3,
        f4,
        f5,
        f6,
        f7,
        f8,
        kopi1,
        kopi2,
        logo,
        managePrinter,
        managePrinterx,
        manageProduct
      ];
}

class Assets {
  Assets._();

  static const $AssetsIconGen icon = $AssetsIconGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class SvgGenImage {
  const SvgGenImage(this._assetName);

  final String _assetName;

  SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    SvgTheme theme = const SvgTheme(),
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    return SvgPicture.asset(
      _assetName,
      key: key,
      matchTextDirection: matchTextDirection,
      bundle: bundle,
      package: package,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      theme: theme,
      colorFilter: colorFilter,
      color: color,
      colorBlendMode: colorBlendMode,
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
