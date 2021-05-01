import 'package:cool_alert/cool_alert.dart';
import 'package:cool_alert/src/models/cool_alert_options.dart';
import 'package:flutter/material.dart';

class CoolAlertButtons extends StatelessWidget {
  final CoolAlertOptions? options;

  CoolAlertButtons({
    Key? key,
    this.options,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _cancelBtn(context),
          _okayBtn(context),
        ],
      ),
    );
  }

  Widget _okayBtn(context) {
    final showCancelBtn =
        options!.type == CoolAlertType.confirm ? true : options!.showCancelBtn!;

    final _okayBtn = _buildButton(
      context: context,
      isOkayBtn: true,
      text: options!.confirmBtnText!,
      onTap: options!.onConfirmBtnTap ?? () => Navigator.pop(context),
    );

    if (showCancelBtn) {
      return Expanded(child: _okayBtn);
    } else {
      return _okayBtn;
    }
  }

  Widget _cancelBtn(context) {
    final showCancelBtn =
        options!.type == CoolAlertType.confirm ? true : options!.showCancelBtn!;

    final _cancelBtn = _buildButton(
      context: context,
      isOkayBtn: false,
      text: options!.cancelBtnText!,
      onTap: options!.onCancelBtnTap ?? () => Navigator.pop(context),
    );

    if (showCancelBtn) {
      return Expanded(child: _cancelBtn);
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
    final _btnText = Text(
      text,
      style: _defaultTextStyle(isOkayBtn),
    );

    final okayBtn = MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      color: options!.confirmBtnColor ?? Theme.of(context!).primaryColor,
      onPressed: onTap,
      child: Container(
        child: Center(
          child: _btnText,
        ),
      ),
    );

    final cancelBtn = GestureDetector(
      onTap: onTap,
      child: Container(
        child: Center(
          child: _btnText,
        ),
      ),
    );

    return isOkayBtn ? okayBtn : cancelBtn;
  }

  TextStyle _defaultTextStyle(bool isOkayBtn) {
    final textStyle = TextStyle(
      color: isOkayBtn ? Colors.white : Colors.grey,
      fontWeight: FontWeight.w600,
      fontSize: 18.0,
    );

    if (isOkayBtn) {
      return options!.confirmBtnTextStyle ?? textStyle;
    } else {
      return options!.cancelBtnTextStyle ?? textStyle;
    }
  }
}
