if (isAndroid()) print('当前为 Android 设备');
if (isWeb()) print('当前为 Web 环境');

double width = screenWidth(context);
double height = screenHeight(context);

bool tablet = isTablet(context);

final deviceInfo = await getDeviceInfo();
final appInfo = await getAppInfo();