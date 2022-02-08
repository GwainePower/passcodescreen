import 'package:flutter/material.dart';

import '../widgets/keyboard.dart';
import '../widgets/circle.dart';

class PasscodeScreen extends StatefulWidget {
  const PasscodeScreen({Key? key}) : super(key: key);

  @override
  _PasscodeScreenState createState() => _PasscodeScreenState();
}

class _PasscodeScreenState extends State<PasscodeScreen> {
  String enteredPasscode = '';
  final int passwordDigits = 4;
  final String title = 'Please enter PIN code';

  List<Widget> _buildCircles() {
    var list = <Widget>[];
    for (int i = 0; i < passwordDigits; i++) {
      list.add(
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 12),
          child: Circle(
            filled: i < enteredPasscode.length,
          ),
        ),
      );
    }
    return list;
  }

  _buildKeyboard() => Stack(children: [
        Keyboard(
          onKeyboardTap: _onKeyboardButtonPressed,
        ),
        Positioned(
          bottom: 15,
          right: 38,
          child: _buildDeleteButton(),
        ),
        Positioned(
          bottom: 15,
          left: 24,
          child: _buildFingerprintButton(),
        ),
      ]);

  _onKeyboardButtonPressed(String text) {
    if (text == Keyboard.deleteButton) {
      _onDeleteButtonPressed();
      return;
    }
    setState(() {
      if (enteredPasscode.length < passwordDigits) {
        enteredPasscode += text;
        if (enteredPasscode.length == passwordDigits) {
          print(enteredPasscode);
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Entered $enteredPasscode',
                textAlign: TextAlign.center,
              ),
            ),
          );
        }
      }
    });
  }

  _onDeleteButtonPressed() {
    if (enteredPasscode.isNotEmpty) {
      setState(() {
        enteredPasscode =
            enteredPasscode.substring(0, enteredPasscode.length - 1);
      });
    }
  }

  Widget _buildDeleteButton() => IconButton(
        onPressed: _onDeleteButtonPressed,
        icon: Icon(
          Icons.backspace_outlined,
          size: 40,
          color: enteredPasscode.isEmpty ? Colors.grey : Colors.black87,
        ),
      );

  Widget _buildFingerprintButton() => IconButton(
        onPressed: () {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Used a fingerprint auth type',
                textAlign: TextAlign.center,
              ),
            ),
          );
        },
        icon: const Icon(
          Icons.fingerprint_rounded,
          size: 40,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => const SimpleDialog(
                    clipBehavior: Clip.none,
                    title: Text(
                      'https://github.com/GwainePower',
                      textAlign: TextAlign.center,
                    ),
                    titlePadding: EdgeInsets.all(10),
                  ),
                );
              },
              icon: const Icon(
                Icons.help_outline_rounded,
                size: 30,
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 26),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 40),
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _buildCircles(),
              ),
            ),
            _buildKeyboard(),
          ],
        ),
      ),
    );
  }
}
