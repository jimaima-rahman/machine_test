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

// final wetherProvider = FutureProvider<WeatherModel>((ref) async {
//   return ref.read(apiProvider).getWeather(
//       query: ref.watch(texteditingProvider).text == ''
//           ? 'kozhikode'
//           : ref.watch(texteditingProvider).text);
// });

final texteditingProvider = StateProvider<TextEditingController>((ref) {
  return TextEditingController();
});

final wetherProvider = FutureProvider<WeatherModel>((ref) async {
  try {
    return await ref.read(apiProvider).getWeather(
          query: ref.watch(texteditingProvider).text == ''
              ? 'kozhikode'
              : ref.watch(texteditingProvider).text,
        );
  } on DioException catch (e) {
    // DioError is thrown for HTTP errors, handle it appropriately
    log("DioError: ${e.message}");
    throw Exception("Failed to fetch weather data. Please check your input.");
  } catch (e) {
    // Handle other errors
    log("Error: $e");
    throw Exception("Something went wrong while fetching weather data.");
  }
});

// import 'dart:convert';
// import 'dart:developer';

// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../model/weather_model.dart';

// class ApiService {
//   final Dio dio = Dio();

//   Future<WeatherModel> getWeather({required String query}) async {
//     try {
//       Response response = await dio.get(
//         "http://api.weatherapi.com/v1/forecast.json?key=d1926ffe8d4944878a854930231307&q=$query",
//       );
//       log("getWeather ${response.statusCode}");

//       if (response.statusCode == 200) {
//         var jsonResponse = json.decode(response.data.toString());
//         return weatherModelFromJson(jsonResponse);
//       } else {
//         throw DioException(
//           requestOptions: RequestOptions(
//             path: response.requestOptions.path,
//             method: response.requestOptions.method,
//             baseUrl: response.requestOptions.baseUrl,
//             connectTimeout: response.requestOptions.connectTimeout,
//             receiveTimeout: response.requestOptions.receiveTimeout,
//             sendTimeout: response.requestOptions.sendTimeout,
//             receiveDataWhenStatusError: response.requestOptions.receiveDataWhenStatusError,
//             followRedirects: response.requestOptions.followRedirects,
//             validateStatus: response.requestOptions.validateStatus,
//             headers: response.requestOptions.headers,
//             contentType: response.requestOptions.contentType,
//             responseType: response.requestOptions.responseType,
//             extra: response.requestOptions.extra,
//           ),
//           response: Response(
//             statusCode: response.statusCode!,
//             statusMessage: response.statusMessage!,
//             data: response.data,
//             headers: response.headers,
//           ),
//         );
//       }
//     } on DioException catch (e) {
//       log("DioException: ${e.message}");
//       if (e.response != null) {
//         throw e;
//       } else {
//         throw Exception("Network error. Please check your internet connection.");
//       }
//     } catch (e) {
//       log("Error: $e");
//       throw Exception("Something went wrong while fetching weather data.");
//     }
//   }
// }

// final apiProvider = Provider<ApiService>((ref) {
//   return ApiService();
// });

// final texteditingProvider = StateProvider<TextEditingController>((ref) {
//   return TextEditingController();
// });

// final wetherProvider = FutureProvider<WeatherModel>((ref) async {
//   try {
//     return await ref.read(apiProvider).getWeather(
//       query: ref.watch(texteditingProvider).text == '' ? 'kozhikode' : ref.watch(texteditingProvider).text,
//     );
//   } on DioException catch (e) {
//     log("DioException: ${e.message}");
//     if (e.response != null) {
//       if (e.response!.statusCode == 400) {
//         throw Exception("Invalid request. Please check your input.");
//       } else if (e.response!.statusCode == 401) {
//         throw Exception("Unauthorized. Please check your API key.");
//       } else {
//         throw Exception("Failed to fetch weather data. Status code: ${e.response!.statusCode}");
//       }
//     } else {
//       throw Exception("Network error. Please check your internet connection.");
//     }
//   } catch (e) {
//     log("Error: $e");
//     throw Exception("Something went wrong while fetching weather data.");
//   }
// });
