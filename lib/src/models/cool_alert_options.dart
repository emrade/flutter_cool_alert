import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/widgets.dart';

class CoolAlertOptions {
  String title;
  String text;
  CoolAlertType type;
  CoolAlertAnimType animType;
  bool barrierDismissible = false;
  VoidCallback onConfirmBtnTap;
  VoidCallback onCancelBtnTap;
  String confirmBtnText;
  String cancelBtnText;
  Color confirmBtnColor;
  bool showCancelBtn;
  double borderRadius;

  CoolAlertOptions({
    this.title,
    this.text,
    @required this.type,
    this.animType,
    this.barrierDismissible,
    this.onConfirmBtnTap,
    this.onCancelBtnTap,
    this.confirmBtnText,
    this.cancelBtnText,
    this.confirmBtnColor,
    this.showCancelBtn,
    this.borderRadius
  });
}
