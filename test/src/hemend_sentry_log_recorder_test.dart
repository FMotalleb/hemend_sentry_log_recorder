// ignore_for_file: prefer_const_constructors
import 'package:hemend_sentry_log_recorder/hemend_sentry_log_recorder.dart';
import 'package:test/test.dart';

void main() {
  group(
    'HemendSentryLogRecorder',
    () {
      test(
        'can be instantiated',
        () {
          expect(HemendSentryLogRecorder(), isNotNull);

          expect(
            () => HemendSentryLogRecorder(
              sentryParamsExtractor: (_) => [],
            ),
            throwsA(TypeMatcher<AssertionError>()),
          );

          expect(
            () => HemendSentryLogRecorder(
              sentryTemplate: '',
            ),
            throwsA(TypeMatcher<AssertionError>()),
          );

          expect(
            () => HemendSentryLogRecorder(
              sentryTemplate: '',
              sentryParamsExtractor: (_) => [],
            ),
            isNotNull,
          );
        },
      );
    },
  );
}
