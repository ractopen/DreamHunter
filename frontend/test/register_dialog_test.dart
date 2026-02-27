import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dreamhunter/presentation/widget/register_dialog.dart';

void main() {
  testWidgets('RegisterDialog has essential fields', (WidgetTester tester) async {
    // We wrap it in a Scaffold and MaterialApp because the dialog uses theme/media query
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: RegisterDialog(
            onLoginRequested: () {},
            onRegisterSuccess: () {},
          ),
        ),
      ),
    );

    // Check for "Register" title
    expect(find.text('Register'), findsNWidgets(2)); // Title and Button

    // Check for TextFormFields by their label text
    expect(find.text('Display Name'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Confirm Password'), findsOneWidget);
    
    // Check for the "Already have an account? Login" button
    expect(find.text('Already have an account? Login'), findsOneWidget);
  });
}
