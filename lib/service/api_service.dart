import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/weather_model.dart';

class ApiService {
  final Dio dio = Dio();

  Future<WeatherModel> getWeather({required String query}) async {
    try {
      Response response = await dio.get(
          "http://api.weatherapi.com/v1/forecast.json?key=d1926ffe8d4944878a854930231307&q=$query");
      log("getWeather ${response.statusCode}");
      if (response.statusCode == 200) {
        var jsonResponse = json.encode(response.data);
        return weatherModelFromJson(jsonResponse);
      }
      throw Exception("something went wrong:${response.data}");
    } on DioException catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }
}

final apiProvider = Provider<ApiService>((ref) {
  return ApiService();
});

final wetherProvider = FutureProvider<WeatherModel>((ref) async {
  return ref.read(apiProvider).getWeather(
      query: ref.watch(texteditingProvider).text == ''
          ? 'kozhikode'
          : ref.watch(texteditingProvider).text);
});

final texteditingProvider = StateProvider<TextEditingController>((ref) {
  return TextEditingController();
});
