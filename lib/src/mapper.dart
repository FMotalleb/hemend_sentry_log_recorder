import 'package:hemend_logger/hemend_logger.dart';
import 'package:sentry/sentry.dart';

typedef LevelMapper = SentryLevel Function(int level);
typedef ParamsExtractor = List<dynamic> Function(LogRecordEntity);

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
