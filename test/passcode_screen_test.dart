import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:passcodescreen/screens/passcode_screen.dart';

void main() {
  Widget screenWidget = const MediaQuery(
    data: MediaQueryData(),
    child: MaterialApp(
      home: PasscodeScreen(),
    ),
  );

  testWidgets('Тест экрана ввода пинкода', (WidgetTester tester) async {
    // Запускаем экран пин кода
    await tester.pumpWidget(screenWidget);

    // Набираем пинкод 1337
    await tester.tap(find.text('1'));
    await tester.pump();
    await tester.tap(find.text('3'));
    await tester.pump();
    await tester.tap(find.text('3'));
    await tester.pump();
    await tester.tap(find.text('7'));
    await tester.pump(const Duration(seconds: 1));

    // Находим SnackBar с сообщением о введении кода
    expect(find.text('Entered 1337'), findsOneWidget);

    // Пробуем нажать на иконку биометрии
    await tester.tap(find.byIcon(Icons.fingerprint_rounded));
    await tester.pump(const Duration(seconds: 1));

    // Ожидаем SnackBar с сообщением об ином варианте аутентификации
    expect(find.text('Used a fingerprint auth type'), findsOneWidget);

    // Проверяем цвет иконки бэкспейса при введенном пин коде - если цвет
    // black87, значит она активирована
    expect(
        (tester.firstWidget(find.byIcon(Icons.backspace_outlined)) as Icon)
            .color,
        Colors.black87);
    await tester.tap(find.byIcon(Icons.backspace_outlined));
    await tester.pump();
    await tester.tap(find.byIcon(Icons.backspace_outlined));
    await tester.pump();
    await tester.tap(find.byIcon(Icons.backspace_outlined));
    await tester.pump();
    await tester.tap(find.byIcon(Icons.backspace_outlined));
    await tester.pump();

    // После стирания пин кода проверяем цвет иконки бэкспейса -
    // если она серая, то значит успешно стерли введенный пин
    expect((tester.firstWidget(find.byType(Icon)) as Icon).color, Colors.grey);
  });
}
