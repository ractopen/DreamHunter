import 'package:flutter/material.dart';

/// An `InheritedWidget` that provides a `ValueNotifier<String>` to its
/// descendants.
///
/// This is used to propagate messages throughout the app, such as the network
/// connectivity status.
class MessageProvider extends InheritedWidget {
  const MessageProvider({
    super.key,
    required this.message,
    required super.child,
  });

  /// A `ValueNotifier` that holds the message to be displayed.
  final ValueNotifier<String> message;

  /// Returns the `MessageProvider` from the widget tree.
  static MessageProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MessageProvider>();
  }

  /// Determines whether the widget should be rebuilt when the `MessageProvider`
  /// is updated.
  @override
  bool updateShouldNotify(MessageProvider oldWidget) {
    return message != oldWidget.message;
  }
}
