import 'package:flutter/material.dart';

class E2EKeys {
  const E2EKeys._();

  static Key page(String name) => Key('page.$name');

  static Key input(String form, String field) => Key('input.$form.$field');

  static Key button(String action) => Key('button.$action');

  static Key modal(String name) => Key('modal.$name');

  static Key card(String contentType, String idOrIndex) =>
      Key('card.$contentType.$idOrIndex');
}
