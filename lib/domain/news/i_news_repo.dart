import 'package:dartz/dartz.dart';
import 'package:testing_flutter/domain/core/failure/failures.dart';
import 'package:testing_flutter/domain/news/news_modal.dart';

abstract class INewsRepo {
  Future<Either<Failures, NewsModal>> getNews();
}
