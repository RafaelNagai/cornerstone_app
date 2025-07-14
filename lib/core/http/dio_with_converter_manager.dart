import 'package:cornerstone_app/core/http/http_manager.dart';
import 'package:dio/dio.dart';

abstract class HttpWithConverterManager {
  Future<T> get<T extends GetterFromHtml>(String path, T model);
  Future<T> post<T extends GetterFromHtml>(String path, T model);
}

class DioWithConverterManager implements HttpWithConverterManager {
  final HttpManager dio;

  DioWithConverterManager({required this.dio});

  @override
  Future<T> get<T extends GetterFromHtml>(String path, T model) async {
    final Response response = await dio.get(path);
    final htmlScreen = response.data.toString();
    return model.getFromHtml(htmlScreen);
  }

  @override
  Future<T> post<T extends GetterFromHtml>(String path, T model) async {
    final Response response = await dio.get(path);
    final htmlScreen = response.data.toString();
    return model.getFromHtml(htmlScreen);
  }
}

abstract class GetterFromHtml<TModel> {
  TModel getFromHtml(String html);

  T getterFromHtml<T>(
    String html, {
    required String startWith,
    required String endWith,
    T Function(String)? converter,
  }) {
    final firstPart = html.split(startWith)[1];
    if (converter != null) {
      final valueToConvert = firstPart.split(endWith)[0];
      return converter(valueToConvert);
    }
    return firstPart.split(endWith)[0] as T;
  }
}
