DateTime? parseNullableDateTime(dynamic value) {
  if (value == null) {
    return null;
  }

  return DateTime.tryParse(value.toString());
}

DateTime parseRequiredDateTime(dynamic value) {
  return parseNullableDateTime(value) ?? DateTime.fromMillisecondsSinceEpoch(0);
}
