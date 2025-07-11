import 'package:cornerstone_app/core/http/dio_manager.dart';
import 'package:cornerstone_app/core/http/http_manager.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    DioManager().init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text('hello'.tr()),
            TextButton(
              onPressed: () async {
                await DioManager().post<dynamic>(
                  '/public/authenticate/login?loginAction=login&userName=2024003178&userPass=zrvIYrhZ',
                );

                final uri = Uri.parse(HttpManager.baseUrl);
                final cookies = await DioManager().cookieJar.loadForRequest(
                  uri,
                );
                debugPrint('🍪 Cookies salvos: $cookies');
              },
              child: Text('login'.tr()),
            ),
            TextButton(
              onPressed: () async {
                final Response response = await DioManager().get<dynamic>(
                  'https://ciccc.ampeducator.ca/web/studentPortal/courses/getGrades?courseID=7129',
                );
                debugPrint(response.data);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      response.data.toString().substring(
                        response.data.toString().length - 100,
                      ),
                    ),
                  ),
                );
              },
              child: Text('get data'.tr()),
            ),
          ],
        ),
      ),
    );
  }
}
