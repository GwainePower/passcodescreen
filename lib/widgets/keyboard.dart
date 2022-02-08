import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef KeyboardTapFunction = void Function(String text);

class Keyboard extends StatelessWidget {
  final KeyboardTapFunction onKeyboardTap;
  final _focusNode = FocusNode();
  static String deleteButton = 'keyboard_delete_button';

  Keyboard({
    Key? key,
    required this.onKeyboardTap,
  }) : super(key: key);

  Widget _buildKeyboardDigit(String text) => Container(
        margin: const EdgeInsets.all(4),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: Colors.transparent,
            onTap: () => onKeyboardTap(text),
            child: SizedBox(
              child: Center(
                child: Text(
                  text,
                  style: const TextStyle(color: Colors.black87, fontSize: 35),
                  semanticsLabel: text,
                ),
              ),
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    List<String> keyboardItems = List.filled(10, '0');
    keyboardItems = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0'];
    final screenSize = MediaQuery.of(context).size;
    final keyboardHeight = screenSize.height / 2;
    final keyboardWidth = screenSize.width * 9 / 10;
    final keyboardSize = Size(keyboardWidth, keyboardHeight);
    return Container(
      alignment: Alignment.bottomCenter,
      margin: const EdgeInsets.only(top: 40),
      width: keyboardSize.width,
      height: keyboardSize.height,
      child: RawKeyboardListener(
        focusNode: _focusNode,
        autofocus: true,
        onKey: (event) {
          if (event is RawKeyUpEvent) {
            if (keyboardItems.contains(event.data.keyLabel)) {
              onKeyboardTap(event.logicalKey.keyLabel);
              return;
            }
            if (event.logicalKey.keyLabel == 'Backspace' ||
                event.logicalKey.keyLabel == 'Delete') {
              onKeyboardTap(Keyboard.deleteButton);
              return;
            }
          }
        },
        child: AlignedGrid(
          keyboardSize: keyboardSize,
          children: List.generate(10, (index) {
            return _buildKeyboardDigit(keyboardItems[index]);
          }),
        ),
      ),
    );
  }
}

class AlignedGrid extends StatelessWidget {
  final double runSpacing = 5;
  final double spacing = 5;
  final int listSize;
  final columns = 3;
  final List<Widget> children;
  final Size keyboardSize;

  const AlignedGrid(
      {Key? key, required this.children, required this.keyboardSize})
      : listSize = children.length,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final primarySize = keyboardSize.width > keyboardSize.height
        ? keyboardSize.height
        : keyboardSize.width;
    final itemSize = (primarySize - runSpacing * (columns - 1)) / columns;
    return Wrap(
      runSpacing: 5,
      spacing: 5,
      alignment: WrapAlignment.center,
      children: children
          .map((item) => SizedBox(
                width: itemSize,
                height: itemSize / 1.8,
                child: item,
              ))
          .toList(growable: false),
    );
  }
}
