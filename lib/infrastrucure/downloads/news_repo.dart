import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:testing_flutter/domain/core/failure/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:testing_flutter/domain/core/strings.dart';
import 'package:testing_flutter/domain/news/i_news_repo.dart';
import 'package:testing_flutter/domain/news/news_modal.dart';
import 'package:testing_flutter/infrastrucure/api_key.dart';

@LazySingleton(as: INewsRepo)
class NewsRepo implements INewsRepo {
  @override
  Future<Either<Failures, NewsModal>> getNews() async {
    try {
      final response = await Dio(BaseOptions()).get("$baseUrl$apiKey");
      if (response.statusCode == 200 || response.statusCode == 201) {
        final mappedData = NewsModal.fromJson(response.data);
        return Right(mappedData);
      } else {
        return const Left(Failures.serverFailure());
      }
    } catch (e) {
      print(e.toString());
      return const Left(Failures.clientFailure());
    }
  }
}
