import 'dart:async';

// ignore: implementation_imports
import 'package:hemend_async_log_recorder/src/contracts/log_sink.dart';
import 'package:hemend_logger/hemend_logger.dart';
import 'package:hemend_sentry_log_recorder/src/mapper.dart';
import 'package:sentry/sentry.dart';

/// {@template hemend_sentry_log_recorder}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class HemendSentryLogRecorder extends ILogSink {
  /// {@macro hemend_sentry_log_recorder}
  HemendSentryLogRecorder({
    LevelMapper levelMapper = defaultSentryLevelMapper,
    String? sentryTemplate,
    ParamsExtractor? sentryParamsExtractor,
  })  : assert(
          ((sentryTemplate == null) ^ (sentryParamsExtractor == null)) == false,
          '''if you want to use template you have to provide sentryParamsExtractor and wise versa''',
        ),
        _controller = StreamController() {
    _initSink(levelMapper, sentryTemplate, sentryParamsExtractor);
  }

  final StreamController<LogRecordEntity> _controller;

  void _initSink(
    LevelMapper levelMapper,
    String? template,
    ParamsExtractor? sentryParamsExtractor,
  ) {
    _controller.stream.listen(
      (record) async {
        if (record.error != null) {
          await Sentry.captureException(
            record.error,
            stackTrace: record.stackTrace,
            hint: Hint.withMap(
              {
                'logger': record.loggerName,
                'record_time': record.time,
              },
            ),
          );
        } else {
          await Sentry.captureMessage(
            record.message,
            level: levelMapper(record.level),
            template: template,
            params: sentryParamsExtractor?.call(record),
            hint: Hint.withMap(
              {
                'logger': record.loggerName,
                'record_time': record.time,
              },
            ),
          );
        }
      },
    );
  }

  @override
  void add(LogRecordEntity data) => _controller.add(data);

  @override
  Future<void> close() => _controller.close();

  @override
  bool get isClosed => _controller.isClosed;
}
