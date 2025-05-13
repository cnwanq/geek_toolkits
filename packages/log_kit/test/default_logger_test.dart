import 'package:flutter_test/flutter_test.dart';
import 'package:log_kit/log_kit.dart';

void main() {
  group('DefaultLogger', () {
    late DefaultLogger logger;

    setUp(() {
      logger = DefaultLogger('TestLogger');
    });

    test('创建实例测试', () {
      expect(logger, isNotNull);
    });

    test('默认标签测试', () {
      final defaultLogger = DefaultLogger();
      expect(defaultLogger, isNotNull);
    });

    test('日志记录测试', () {
      expect(() => logger.debug('Debug message'), returnsNormally);
      expect(() => logger.info('Info message'), returnsNormally);
      expect(() => logger.warning('Warning message'), returnsNormally);
      expect(() => logger.error('Error message'), returnsNormally);
    });

    test('带错误的日志记录测试', () {
      final error = Exception('Test error');
      final stackTrace = StackTrace.current;
      
      expect(() => logger.debug('Debug message', error, stackTrace), returnsNormally);
      expect(() => logger.info('Info message', error, stackTrace), returnsNormally);
      expect(() => logger.warning('Warning message', error, stackTrace), returnsNormally);
      expect(() => logger.error('Error message', error, stackTrace), returnsNormally);
    });
  });
} 