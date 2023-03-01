import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cool Alert',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: GoogleFonts.poppins().fontFamily,
      ),
      home: const MyHomePage(title: 'Cool Alert'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final successAlert = _buildButton(
      onTap: () {
        CoolAlert.show(
          context: context,
          type: CoolAlertType.success,
          text: 'Transaction completed successfully!',
          autoCloseDuration: const Duration(seconds: 2),
        );
      },
      text: 'Success',
      color: Colors.green,
    );

    final errorAlert = _buildButton(
      onTap: () {
        CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          title: 'Oops...',
          text: 'Sorry, something went wrong',
          loopAnimation: false,
        );
      },
      text: 'Error',
      color: Colors.red,
    );

    final warningAlert = _buildButton(
      onTap: () {
        CoolAlert.show(
          context: context,
          type: CoolAlertType.warning,
          text: 'You just broke protocol',
        );
      },
      text: 'Warning',
      color: Colors.orange,
    );

    final infoAlert = _buildButton(
      onTap: () {
        CoolAlert.show(
          context: context,
          type: CoolAlertType.info,
          text: 'Buy two, get one free',
          titleTextStyle: TextStyle(
            color: Colors.blue[900],
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          textTextStyle: TextStyle(
            color: Colors.blue[500],
            fontSize: 14,
          ),
        );
      },
      text: 'Info',
      color: Colors.blue[100],
    );

    final confirmAlert = _buildButton(
      onTap: () {
        CoolAlert.show(
          context: context,
          type: CoolAlertType.confirm,
          text: 'Do you want to logout',
          confirmBtnText: 'Yes',
          cancelBtnText: 'No',
          confirmBtnColor: Colors.green,
        );
      },
      text: 'Confirm',
      color: Colors.lightGreen,
    );

    final loadingAlert = _buildButton(
      onTap: () {
        CoolAlert.show(
          context: context,
          type: CoolAlertType.loading,
        );
      },
      text: 'Loading',
      color: Colors.grey,
    );

    final customAlert = _buildButton(
      onTap: () {
        var message = '';
        CoolAlert.show(
          context: context,
          type: CoolAlertType.custom,
          barrierDismissible: true,
          confirmBtnText: 'Save',
          widget: TextFormField(
            decoration: const InputDecoration(
              hintText: 'Enter Phone Number',
              prefixIcon: Icon(
                Icons.phone_outlined,
              ),
            ),
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.phone,
            onChanged: (value) => message = value,
          ),
          closeOnConfirmBtnTap: false,
          onConfirmBtnTap: () async {
            if (message.length < 5) {
              await CoolAlert.show(
                context: context,
                type: CoolAlertType.error,
                text: 'Please enter at least 5 characters',
              );

              return;
            }
            Navigator.of(context).pop();
            await Future.delayed(const Duration(milliseconds: 500), () async {
              await CoolAlert.show(
                context: context,
                type: CoolAlertType.success,
                text: "Phone number '$message' has been saved!.",
              );
            });
          },
        );
      },
      text: 'Custom',
      color: Colors.orange,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            successAlert,
            errorAlert,
            warningAlert,
            infoAlert,
            confirmAlert,
            loadingAlert,
            customAlert,
          ],
        ),
      ),
    );
  }

  Widget _buildButton(
      {VoidCallback? onTap, required String text, Color? color}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: MaterialButton(
        color: color,
        minWidth: double.infinity,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        onPressed: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
