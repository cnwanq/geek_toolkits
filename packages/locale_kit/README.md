<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->

# Locale Kit

一个简单易用的 Flutter 国际化工具包，支持多语言切换、文案翻译、自动翻译等功能。

## 特性

- 🌍 支持多语言切换
- 📝 支持文案翻译
- 🔄 支持自动翻译
- 🎯 支持参数替换
- 📦 支持自定义翻译文件
- 🔍 支持通过原文查找翻译
- 📱 支持字符串扩展方法
- 📊 内置日志记录

## 安装

在 `pubspec.yaml` 中添加依赖：

```yaml
dependencies:
  locale_kit: ^0.1.0
```

## 快速开始

### 1. 初始化

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // 初始化语言管理器
  await LocaleManager().init(
    config: LocaleConfig(
      defaultLocale: const Locale('en'),
      supportedLocales: const [
        Locale('en'), // English
        Locale('zh'), // Chinese
        Locale('ja'), // Japanese
        Locale('ko'), // Korean
        Locale('fr'), // French
        Locale('de'), // German
        Locale('es'), // Spanish
        Locale('ru'), // Russian
      ],
    ),
  );
  
  runApp(const MyApp());
}
```

### 2. 添加翻译文件

在 `assets/translations` 目录下创建翻译文件，例如：

```json
// assets/translations/en.json
{
  "hello": "Hello",
  "welcome": "Welcome, {name}!",
  "buttons": {
    "ok": "OK",
    "cancel": "Cancel"
  }
}

// assets/translations/zh.json
{
  "hello": "你好",
  "welcome": "欢迎，{name}！",
  "buttons": {
    "ok": "确定",
    "cancel": "取消"
  }
}
```

在 `pubspec.yaml` 中声明资源：

```yaml
flutter:
  assets:
    - assets/translations/
```

### 3. 使用翻译

#### 使用 TranslatedText 组件

```dart
TranslatedText(
  'hello',
  style: TextStyle(fontSize: 16),
)

// 带参数的翻译
TranslatedText(
  'welcome',
  params: {'name': 'John'},
)
```

#### 使用 AutoTranslatedText 组件

```dart
AutoTranslatedText(
  'Hello',
  sourceLocale: const Locale('en'),
)
```

#### 使用字符串扩展

```dart
// 获取当前语言的翻译
final text = 'hello'.tr;

// 获取指定语言的翻译
final text = 'hello'.trTo(const Locale('zh'));

// 从一种语言翻译到另一种语言
final text = 'hello'.trFromTo(
  const Locale('en'),
  const Locale('zh'),
);

// 带参数的翻译
final text = 'welcome'.trWithParams({
  'name': 'John',
});
```

### 4. 切换语言

```dart
// 切换到指定语言
await LocaleManager().setLocale(const Locale('zh'));

// 获取当前语言
final currentLocale = LocaleManager().currentLocale;

// 监听语言变化
LocaleManager().localeStream.listen((locale) {
  print('Language changed to: ${locale.languageCode}');
});
```

### 5. 添加自定义翻译

```dart
// 添加自定义翻译
TranslationsManager().addTranslations(
  const Locale('zh'),
  {
    'custom_key': '自定义翻译',
  },
);
```

## API 文档

### LocaleManager

语言管理器，负责管理语言切换和状态。

#### 属性

- `currentLocale`: 当前语言环境
- `localeStream`: 语言变化流

#### 方法

- `init()`: 初始化语言管理器
- `setLocale()`: 设置语言
- `getLocale()`: 获取语言
- `resetLocale()`: 重置语言

### TranslationsManager

翻译管理器，负责管理翻译文案。

#### 方法

- `get()`: 获取翻译
- `findTranslation()`: 查找翻译
- `addTranslations()`: 添加翻译

### TranslatedText

翻译文本组件。

#### 属性

- `key`: 翻译键名
- `params`: 替换参数
- `style`: 文本样式
- `textAlign`: 文本对齐方式
- `maxLines`: 最大行数
- `overflow`: 文本溢出处理方式

### AutoTranslatedText

自动翻译文本组件。

#### 属性

- `text`: 原文
- `sourceLocale`: 源语言环境
- `style`: 文本样式
- `textAlign`: 文本对齐方式
- `maxLines`: 最大行数
- `overflow`: 文本溢出处理方式

### String 扩展

- `tr`: 获取当前语言的翻译
- `trTo()`: 获取指定语言的翻译
- `trFromTo()`: 从源语言翻译到目标语言
- `trWithParams()`: 获取带参数的翻译

## 最佳实践

1. 使用键名方式管理翻译，便于维护和扩展
2. 将翻译文件按语言分类存放
3. 使用嵌套结构组织翻译键名
4. 使用参数替换处理动态内容
5. 监听语言变化及时更新界面

## 贡献

欢迎提交 Issue 和 Pull Request！

## 许可证

MIT License
