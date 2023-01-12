import 'cache_helper.dart';

class CacheKeysManger {
  static String getLanguageFromCache() =>
      CacheHelper.getData(key: 'lang') ?? 'ar';

  static String getPrinterFromCache() =>
      CacheHelper.getData(key: 'printer') ?? 'NO';

  static String getPrinterWidthPaperFromCache() =>
      CacheHelper.getData(key: 'printerWidthPaper') ?? '80';

  static String getCurrencyFromCache() =>
      CacheHelper.getData(key: 'currency') ?? 'USD';

  static String getUserTokenFromCache() =>
      CacheHelper.getData(key: 'userToken') ?? "NO";

  static bool geIsFirstTimeFromCache() =>
      CacheHelper.getData(key: 'isFirstTime') ?? true;

  static String geEmailFromCache() => CacheHelper.getData(key: 'email') ?? "NO";

  static String gePasswordFromCache() =>
      CacheHelper.getData(key: 'password') ?? "NO";

  static bool geIsUpdateToOnlineFromCache() =>
      CacheHelper.getData(key: 'isUpdateToOnline') ?? true;
}
