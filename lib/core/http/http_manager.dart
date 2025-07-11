abstract class HttpManager {
  static final String baseUrl = "https://ciccc.ampeducator.ca/web";

  Future init();
  Future<dynamic> get<T>(String path, {Map<String, dynamic>? query});
  Future<dynamic> post<T>(String path, {dynamic data});
}
