import 'package:cookie_jar/cookie_jar.dart';
import 'package:cornerstone_app/core/http/http_manager.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';

class DioManager implements HttpManager {
  static final DioManager _instance = DioManager._();
  factory DioManager() => _instance;
  late final Dio dio;
  late CookieJar cookieJar;

  DioManager._();

  @override
  Future init() async {
    dio = Dio(
      BaseOptions(
        baseUrl: HttpManager.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        validateStatus: (status) {
          return status != null && status < 300 ||
              status != null && status == 302;
        },
        headers: {
          // 'Content-Type': 'application/json',
          // 'Accept': 'application/json',
        },
      ),
    );

    final appDocDir = await getApplicationDocumentsDirectory();
    cookieJar = PersistCookieJar(
      storage: FileStorage('${appDocDir.path}/.cookies'),
    );

    dio.interceptors.add(CookieManager(cookieJar));

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Exemplo: adicionar token
          // options.headers['Authorization'] = 'Bearer SEU_TOKEN';
          debugPrint('[DIO] ➜ Request: ${options.uri}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          debugPrint('[DIO] ✅ Response: ${response.statusCode}');
          return handler.next(response);
        },
        onError: (error, handler) {
          debugPrint('[DIO] ❌ Error: ${error.message}');
          return handler.next(error);
        },
      ),
    );
  }

  @override
  Future<dynamic> get<T>(String path, {Map<String, dynamic>? query}) async {
    return await dio.get<T>(path, queryParameters: query);
  }

  @override
  Future<dynamic> post<T>(String path, {data}) async {
    return await dio.post<T>(path, data: data);
  }
}
