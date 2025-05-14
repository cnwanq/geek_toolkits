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

# Geek UI Kit

一个现代化的 Flutter UI 组件库，提供丰富的组件和工具，帮助开发者快速构建高质量的应用程序。

## 特性

- 🎨 丰富的组件库
- 📱 完善的屏幕适配方案
- 🔌 灵活的插件系统
- 🎯 类型安全
- 📦 易于使用和扩展

## 安装

在 `pubspec.yaml` 中添加依赖：

```yaml
dependencies:
  ui_kit:
    path: packages/ui_kit
```

## 快速开始

### 1. 初始化应用

```dart
import 'package:ui_kit/ui_kit.dart';

void main() {
  runApp(
    GeekApp(
      title: '我的应用',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: HomePage(),
    ),
  );
}
```

### 2. 使用组件

```dart
import 'package:ui_kit/ui_kit.dart';

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          GeekButton(
            text: '点击我',
            onPressed: () {},
          ),
          GeekTextField(
            hintText: '请输入',
          ),
          GeekCard(
            child: Text('卡片内容'),
          ),
        ],
      ),
    );
  }
}
```

## 组件列表

### 基础组件

- `GeekButton` - 按钮组件
- `GeekTextField` - 输入框组件
- `GeekCard` - 卡片组件
- `GeekList` - 列表组件
- `GeekDialog` - 对话框组件
- `GeekBottomSheet` - 底部弹出框组件

### 状态组件

- `GeekLoading` - 加载指示器组件
- `GeekEmpty` - 空状态组件
- `GeekError` - 错误状态组件

### 展示组件

- `GeekTag` - 标签组件
- `GeekAvatar` - 头像组件
- `GeekBadge` - 徽章组件
- `GeekSwitch` - 开关组件

## 屏幕适配

### 1. 初始化

```dart
void main() {
  runApp(
    MaterialApp(
      home: Builder(
        builder: (context) {
          GeekScreen().init(context);
          return MyApp();
        },
      ),
    ),
  );
}
```

### 2. 使用扩展

```dart
Container(
  // 宽度适配
  width: 100.w,
  // 高度适配
  height: 100.h,
  // 边距适配
  margin: EdgeInsets.all(16).w,
  // 圆角适配
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(8).r,
  ),
  // 文字适配
  child: Text(
    'Hello',
    style: TextStyle(fontSize: 16).w,
  ),
)
```

### 3. 适配方法

- `.w` - 根据屏幕宽度适配
- `.h` - 根据屏幕高度适配
- `.r` - 根据屏幕宽高比适配（取较小值）
- `.m` - 根据屏幕宽高比适配（取较大值）
- `.wInt` - 根据屏幕宽度适配并四舍五入
- `.hInt` - 根据屏幕高度适配并四舍五入
- `.rInt` - 根据屏幕宽高比适配并四舍五入（取较小值）
- `.mInt` - 根据屏幕宽高比适配并四舍五入（取较大值）

## 插件系统

### 1. 创建插件

```dart
class MyPlugin implements GeekPlugin {
  @override
  String get name => 'MyPlugin';
  
  @override
  String get version => '1.0.0';
  
  @override
  GeekPluginPriority get priority => GeekPluginPriority.high;
  
  @override
  String? get description => '这是一个示例插件';
  
  @override
  Future<void> initialize() async {
    // 初始化逻辑
  }
  
  @override
  Future<void> dispose() async {
    // 清理逻辑
  }
}
```

### 2. 使用插件

```dart
GeekApp(
  title: '我的应用',
  plugins: [
    MyPlugin(),
  ],
  onPluginsInitialized: () {
    print('插件初始化完成');
  },
)
```

### 3. 插件优先级

- `GeekPluginPriority.highest` - 最高优先级
- `GeekPluginPriority.high` - 高优先级
- `GeekPluginPriority.normal` - 普通优先级
- `GeekPluginPriority.low` - 低优先级
- `GeekPluginPriority.lowest` - 最低优先级

## 主题定制

### 1. 使用主题

```dart
GeekApp(
  theme: ThemeData(
    primaryColor: Colors.blue,
    // 其他主题配置
  ),
  darkTheme: ThemeData(
    primaryColor: Colors.blue,
    brightness: Brightness.dark,
    // 其他暗色主题配置
  ),
)
```

### 2. 自定义组件样式

所有组件都支持通过主题进行样式定制，例如：

```dart
ThemeData(
  extensions: [
    GeekButtonTheme(
      // 按钮主题配置
    ),
    GeekTextFieldTheme(
      // 输入框主题配置
    ),
    // 其他组件主题配置
  ],
)
```

## 最佳实践

1. 屏幕适配
   - 使用 `.w` 适配宽度相关尺寸
   - 使用 `.h` 适配高度相关尺寸
   - 使用 `.r` 适配需要保持比例的尺寸
   - 使用 `.m` 适配需要放大效果的尺寸

2. 组件使用
   - 优先使用主题配置样式
   - 合理使用组件的自定义属性
   - 注意组件的生命周期管理

3. 插件开发
   - 合理设置插件优先级
   - 正确处理插件的初始化和销毁
   - 提供清晰的错误处理机制

## 贡献指南

1. Fork 项目
2. 创建特性分支
3. 提交更改
4. 推送到分支
5. 创建 Pull Request

## 许可证

MIT License
