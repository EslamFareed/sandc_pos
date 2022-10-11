import 'cache_helper.dart';

class CacheKeysManger {
  static String getLanguageFromCache() =>
      CacheHelper.getData(key: 'lang') ?? 'en';
  static String getCurrencyFromCache() =>
      CacheHelper.getData(key: 'currency') ?? 'USD';

  static String getUserTokenFromCache() =>
      CacheHelper.getData(key: 'userToken') ?? "NO";

  // static String getFirebaseUserTokenFromCache() =>
  //     CacheHelper.getData(key: 'firebaseToken') ?? "NO";

  // static int getUserIdFromCache() => CacheHelper.getData(key: 'userId') ?? "NO";
}
