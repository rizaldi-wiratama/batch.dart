// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

// Package imports:
import 'package:test/test.dart';

// Project imports:
import 'package:batch/src/log/log_configuration.dart';
import 'package:batch/src/log/logger.dart';
import 'package:batch/src/log/logger_provider.dart';

void main() {
  test('Test LoggerProvider', () {
    final logger = Logger.loadFromConfig(LogConfiguration());

    expect(log.trace, isNotNull);
    expect(log.debug, isNotNull);
    expect(log.info, isNotNull);
    expect(log.warn, isNotNull);
    expect(log.error, isNotNull);
    expect(log.fatal, isNotNull);

    expect(log == logger, isTrue);
  });
}
