import 'package:cool_alert/cool_alert.dart';
import 'package:cool_alert/src/models/cool_alert_options.dart';
import 'package:flutter/material.dart';

class CoolAlertButtons extends StatelessWidget {
  final CoolAlertOptions options;

  const CoolAlertButtons({
    Key? key,
    required this.options,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> buttons = [
      _cancelBtn(context),
      _okayBtn(context),
    ];
    if (options.reverseBtnOrder) {
      buttons = buttons.reversed.toList();
    }

    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: buttons,
      ),
    );
  }

  Widget _okayBtn(context) {
    final showCancelBtn =
        options.type == CoolAlertType.confirm ? true : options.showCancelBtn!;

    final okayBtn = _buildButton(
      context: context,
      isOkayBtn: true,
      text: options.confirmBtnText!,
      onTap: () {
        options.onConfirmBtnTap?.call();

        // If autoCloseDuration is NOT null, it means the dialg will be auto closed, so disable confirm button tap
        if (options.autoCloseDuration != null) {
          return;
        }
        if (options.closeOnConfirmBtnTap) {
          Navigator.of(context, rootNavigator: true).pop();
        }
      },
    );

    if (showCancelBtn) {
      return Expanded(child: okayBtn);
    } else {
      return okayBtn;
    }
  }

  Widget _cancelBtn(context) {
    final showCancelBtn =
        options.type == CoolAlertType.confirm ? true : options.showCancelBtn!;

    final cancelBtn = _buildButton(
      context: context,
      isOkayBtn: false,
      text: options.cancelBtnText!,
      onTap: () {
        options.onCancelBtnTap?.call();
        Navigator.pop(context);
      },
    );

    if (showCancelBtn) {
      return Expanded(child: cancelBtn);
    } else {
      return Container();
    }
  }

  Widget _buildButton({
    BuildContext? context,
    required bool isOkayBtn,
    required String text,
    VoidCallback? onTap,
  }) {
    final btnText = Text(
      text,
      style: _defaultTextStyle(isOkayBtn),
    );

    final okayBtn = MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      elevation: 0,
      color: options.confirmBtnColor ?? Theme.of(context!).primaryColor,
      onPressed: onTap,
      child: Center(
        child: btnText,
      ),
    );

    final cancelBtn = GestureDetector(
      onTap: onTap,
      child: Center(
        child: btnText,
      ),
    );

    return isOkayBtn ? okayBtn : cancelBtn;
  }

  TextStyle _defaultTextStyle(bool isOkayBtn) {
    final textStyle = TextStyle(
      color: isOkayBtn ? Colors.white : Colors.grey,
      fontWeight: FontWeight.w600,
      fontSize: 14.0,
    );

    if (isOkayBtn) {
      return options.confirmBtnTextStyle ?? textStyle;
    } else {
      return options.cancelBtnTextStyle ?? textStyle;
    }
  }
}
