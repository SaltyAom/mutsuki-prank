import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:niku/niku.dart';
import 'package:niku/namespace.dart' as n;

import 'package:bitsdojo_window/bitsdojo_window.dart';

import 'package:card_sensei/services.dart';

void main() {
  runApp(const MyApp());

  doWhenWindowReady(() {
    const initialSize = Size(720, 480);

    appWindow
      ..title = "p-please sensei"
      ..minSize = initialSize
      ..size = initialSize
      ..alignment = Alignment.center;

    appWindow.show();
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Card Senpai',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home: IWannaKnowOWO(),
      // home: const ArigatouSensei(),
    );
  }
}

class IWannaKnowOWO extends HookWidget {
  IWannaKnowOWO({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();

  @override
  build(context) {
    return Scaffold(
      body: WindowBorder(
        color: Colors.white,
        child: n.Column([
          WindowTitleBarBox(
            child: MoveWindow(
              child: "p-please sensei".n
                ..color = Colors.grey.shade600
                ..center
                ..fullSize,
            ),
          ),
          Form(
            key: formKey,
            child: n.Row([
              n.Image.asset("assets/mutsuki.jpg")
                ..wFull
                ..maxWidth = 320
                ..ml = 32,
              n.Column([
                "w-would you let me see your card details p-please?".h6..mb = 8,
                n.TextFormField.label("pass me your card number o-onegai~")
                  ..outlined
                  ..hintText = 'XXXX XXXX XXXX XXXX'
                  ..maxLength = 19
                  ..counterText = ""
                  ..inputFormatters = [
                    FilteringTextInputFormatter.digitsOnly,
                    CardNumberFormatter(),
                  ]
                  ..validator = (value) =>
                      value == null || value.isEmpty || value.length != 19
                          ? 'card number onegai TwT'
                          : null,
                n.TextFormField.label("when does it expire owo")
                  ..outlined
                  ..hintText = 'XX/XX'
                  ..suffix = "MM/YY".n
                  ..maxLength = 5
                  ..counterText = ""
                  ..inputFormatters = [
                    FilteringTextInputFormatter.digitsOnly,
                    MonthYearFormatter(),
                  ]
                  ..validator = (value) =>
                      value == null || value.isEmpty || value.length != 5
                          ? 'read out the date for me onegai~'
                          : null,
                n.TextFormField.label(
                    "those three numbers on the back...\nwhat do they say? i can't read it :(")
                  ..outlined
                  ..maxLength = 3
                  ..counterText = ""
                  ..suffix = "CVC".n
                  ..validator = (value) =>
                      value == null || value.isEmpty || value.length != 3
                          ? 'I can\'t see number sensei... uoh'
                          : null,
                n.Button.outlined("arigatou sensei!".n)
                  ..onPressed = () async {
                    if (formKey.currentState!.validate()) {
                      final page = await Future.microtask(
                        () => const ArigatouSensei(),
                      );

                      // ignore: use_build_context_synchronously
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => page,
                        ),
                      );
                    }
                  }
                  ..border = BorderSide(color: Colors.blue.shade500)
                  ..py = 20
                  ..wFull
              ])
                ..gap = 16
                ..mr = 32
                ..py = 20
                ..center
                ..scrollable
                ..expanded
            ])
              ..center
              ..gap = 32,
          ).niku
            ..expanded
        ]),
      ),
    );
  }
}

class ArigatouSensei extends StatelessWidget {
  const ArigatouSensei({Key? key}) : super(key: key);

  @override
  build(context) {
    return Scaffold(
      body: WindowBorder(
        color: Colors.white,
        child: n.Column([
          WindowTitleBarBox(
            child: MoveWindow(
              child: "arigatou sensei~".n
                ..color = Colors.grey.shade600
                ..center
                ..fullSize,
            ),
          ),
          n.Column([
            Niku(
              n.Image.asset("assets/mesugaki.jpg")..aspect = 1,
            )..maxW = 320,
            "Arigatou Sensei! tehehe~".h6,
            n.Button(
                "Hmm ... Damn female kid ...! !! !! Pranking an adult 💢💢 I need correction ...💢"
                    .n)
              ..onPressed = () {
                exit(0);
              }
              ..useParent(
                (child) => Theme(
                  data: ThemeData(primarySwatch: Colors.red),
                  child: child,
                ),
              ),
          ])
            ..gap = 16
            ..center
            ..scrollable
            ..n.center
            ..expanded,
        ]),
      ),
    );
  }
}
