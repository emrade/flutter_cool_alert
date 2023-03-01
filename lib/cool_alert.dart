library cool_alert;

import 'dart:async';

import 'package:flutter/material.dart';

import 'src/models/cool_alert_options.dart';
import 'src/utils/animate.dart';
import 'src/widgets/cool_alert_container.dart';

enum CoolAlertType { success, error, warning, confirm, info, loading, custom }

enum CoolAlertAnimType {
  scale,
  rotate,
  slideInDown,
  slideInUp,
  slideInLeft,
  slideInRight,
}

/// CoolAlert.
class CoolAlert {
  static Future show({
    /// BuildContext
    required BuildContext context,

    /// Title of the dialog
    String? title,

    /// Text of the dialog
    String? text,

    /// Custom Widget of the dialog
    Widget? widget,

    // Alert type [success, error, warning, confirm, info, loading, custom]
    required CoolAlertType type,

    // Animation type  [scale, rotate, slideInDown, slideInUp, slideInLeft, slideInRight]
    CoolAlertAnimType animType = CoolAlertAnimType.scale,

    /// Barrier Dissmisable
    bool barrierDismissible = true,

    // Triggered when confirm button is tapped
    VoidCallback? onConfirmBtnTap,

    /// Triggered when cancel button is tapped
    VoidCallback? onCancelBtnTap,

    /// Confirmation button text
    String confirmBtnText = 'Ok',

    /// Cancel button text
    String cancelBtnText = 'Cancel',

    /// Color for confirm button
    Color confirmBtnColor = const Color(0xFF3085D6),

    /// TextStyle for confirm button
    TextStyle? confirmBtnTextStyle,

    /// TextStyle for cancel button
    TextStyle? cancelBtnTextStyle,

    /// TextStyle for title
    TextStyle? titleTextStyle,

    /// TextStyle for text
    TextStyle? textTextStyle,

    /// Determines if cancel button is shown or not
    bool showCancelBtn = false,

    /// Dialog Border Radius
    double borderRadius = 10.0,

    /// Header background color
    Color backgroundColor = const Color(0xFF515C6F),

    /// Flare asset path
    String? flareAsset,

    /// Flare animation name
    String flareAnimationName = 'play',

    /// Asset path of your lottie file
    String? lottieAsset,

    /// Width of the dialog
    double? width,

    /// Determines how long the dialog stays open for before closing
    /// [default] is null
    /// When it is null, it won't autoclose
    Duration? autoCloseDuration,

    /// Detemines if the animation loops or not
    bool loopAnimation = false,

    /// Detemines if dialog closes when the confirm button is tapped
    /// [default] is true
    /// When it is true, it will close
    /// When it is false, you will have to close it manually by using Navigator.of(context).pop();
    bool closeOnConfirmBtnTap = true,

    /// Reverse the order of the buttons
    bool reverseBtnOrder = false,
  }) {
    if (autoCloseDuration != null) {
      Future.delayed(autoCloseDuration, () {
        Navigator.of(context, rootNavigator: true).pop();
      });
    }

    final options = CoolAlertOptions(
      title: title,
      text: text,
      widget: widget,
      type: type,
      animType: animType,
      barrierDismissible: barrierDismissible,
      onConfirmBtnTap: onConfirmBtnTap,
      onCancelBtnTap: onCancelBtnTap,
      confirmBtnText: confirmBtnText,
      cancelBtnText: cancelBtnText,
      confirmBtnColor: confirmBtnColor,
      confirmBtnTextStyle: confirmBtnTextStyle,
      cancelBtnTextStyle: cancelBtnTextStyle,
      titleTextStyle: titleTextStyle,
      textTextStyle: textTextStyle,
      showCancelBtn: showCancelBtn,
      borderRadius: borderRadius,
      backgroundColor: backgroundColor,
      flareAsset: flareAsset,
      flareAnimationName: flareAnimationName,
      lottieAsset: lottieAsset,
      width: width,
      loopAnimation: loopAnimation,
      closeOnConfirmBtnTap: closeOnConfirmBtnTap,
      autoCloseDuration: autoCloseDuration,
      reverseBtnOrder: reverseBtnOrder,
    );

    final child = AlertDialog(
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      content: CoolAlertContainer(
        options: options,
      ),
    );

    return showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (context, anim1, __, widget) {
        switch (animType) {
          case CoolAlertAnimType.scale:
            return Animate.scale(child: child, animation: anim1);

          case CoolAlertAnimType.rotate:
            return Animate.rotate(child: child, animation: anim1);

          case CoolAlertAnimType.slideInDown:
            return Animate.slideInDown(child: child, animation: anim1);

          case CoolAlertAnimType.slideInUp:
            return Animate.slideInUp(child: child, animation: anim1);

          case CoolAlertAnimType.slideInLeft:
            return Animate.slideInLeft(child: child, animation: anim1);

          case CoolAlertAnimType.slideInRight:
            return Animate.slideInRight(child: child, animation: anim1);

          default:
            return child;
        }
      },
      transitionDuration: const Duration(milliseconds: 200),
      barrierDismissible:
          autoCloseDuration != null ? false : barrierDismissible,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, _, __) => Container(),
    );
  }
}
