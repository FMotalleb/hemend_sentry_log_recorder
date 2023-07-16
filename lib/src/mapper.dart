import 'package:hemend_logger/hemend_logger.dart';
import 'package:sentry/sentry.dart';

/// Used to map log levels into sentry log level
typedef LevelMapper = SentryLevel Function(int level);

/// extracts params from Log record for sentry template
typedef ParamsExtractor = List<dynamic> Function(LogRecordEntity);

/// Used to map log levels into sentry log level
SentryLevel defaultSentryLevelMapper(
  int level,
) =>
    switch (level) {
      <= 700 => SentryLevel.debug,
      > 700 && <= 800 => SentryLevel.info,
      > 800 && <= 900 => SentryLevel.warning,
      > 900 && <= 1000 => SentryLevel.error,
      > 1000 => SentryLevel.fatal,
      _ => SentryLevel.fatal,
    };
