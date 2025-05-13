import 'package:flutter_test/flutter_test.dart';
import 'package:log_kit/log_kit.dart';

void main() {
  group('LogManager', () {
    late LogManager logManager;

    setUp(() {
      logManager = LogManager();
      logManager.init(
        debugEnabled: true,
        consoleEnabled: true,
        fileEnabled: false,
        tag: 'TestTag',
      );
    });

    test('单例模式测试', () {
      final instance1 = LogManager();
      final instance2 = LogManager();
      expect(instance1, equals(instance2));
    });

    test('初始化测试', () {
      expect(logManager, isNotNull);
    });

    test('设置标签测试', () {
      logManager.setTag('NewTag');
      // 由于日志输出是副作用，这里只能测试方法调用是否成功
      expect(() => logManager.setTag('NewTag'), returnsNormally);
    });

    test('调试日志开关测试', () {
      expect(() => logManager.setDebugEnabled(false), returnsNormally);
      expect(() => logManager.setDebugEnabled(true), returnsNormally);
    });

    test('控制台输出开关测试', () {
      expect(() => logManager.setConsoleEnabled(false), returnsNormally);
      expect(() => logManager.setConsoleEnabled(true), returnsNormally);
    });

    test('文件输出开关测试', () {
      expect(() => logManager.setFileEnabled(false), returnsNormally);
      expect(() => logManager.setFileEnabled(true), returnsNormally);
    });

    test('设置日志文件路径测试', () {
      expect(() => logManager.setLogFilePath('test.log'), returnsNormally);
    });

    test('日志记录测试', () {
      expect(() => logManager.debug('Debug message'), returnsNormally);
      expect(() => logManager.info('Info message'), returnsNormally);
      expect(() => logManager.warning('Warning message'), returnsNormally);
      expect(() => logManager.error('Error message'), returnsNormally);
    });

    test('带错误的日志记录测试', () {
      final error = Exception('Test error');
      final stackTrace = StackTrace.current;
      
      expect(() => logManager.debug('Debug message', error, stackTrace), returnsNormally);
      expect(() => logManager.info('Info message', error, stackTrace), returnsNormally);
      expect(() => logManager.warning('Warning message', error, stackTrace), returnsNormally);
      expect(() => logManager.error('Error message', error, stackTrace), returnsNormally);
    });
  });
} 