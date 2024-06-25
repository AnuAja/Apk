import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ap/login_page.dart';

void main() {
  testWidgets('LoginPage has a title and login button',
      (WidgetTester tester) async {
    // Build LoginPage and trigger a frame.
    await tester.pumpWidget(const MaterialApp(home: LoginPage()));

    // Verify the title is present
    expect(find.text('KASHIRO'), findsOneWidget);

    // Verify the presence of phone and password fields
    expect(find.byKey(const Key('phoneField')), findsOneWidget);
    expect(find.byKey(const Key('passwordField')), findsOneWidget);

    // Verify the presence of login button
    expect(find.byKey(const Key('loginButton')), findsOneWidget);
  });

  testWidgets('LoginPage shows error message when credentials are invalid',
      (WidgetTester tester) async {
    // Build LoginPage and trigger a frame.
    await tester.pumpWidget(const MaterialApp(home: LoginPage()));

    // Enter invalid credentials
    await tester.enterText(find.byKey(const Key('phoneField')), 'invalid');
    await tester.enterText(
        find.byKey(const Key('passwordField')), 'wrongpassword');

    // Tap the login button
    await tester.tap(find.byKey(const Key('loginButton')));
    await tester.pump();

    // Verify the error message is shown
    expect(find.text('Nomor Ponsel atau Password salah'), findsOneWidget);
  });

  testWidgets('LoginPage shows success message when credentials are valid',
      (WidgetTester tester) async {
    // Build LoginPage and trigger a frame.
    await tester.pumpWidget(const MaterialApp(home: LoginPage()));

    // Enter valid credentials
    await tester.enterText(find.byKey(const Key('phoneField')), '123456');
    await tester.enterText(find.byKey(const Key('passwordField')), 'password');

    // Tap the login button
    await tester.tap(find.byKey(const Key('loginButton')));
    await tester.pump();

    // Verify the success message is shown
    expect(find.text('Login berhasil!'), findsOneWidget);
  });
}
