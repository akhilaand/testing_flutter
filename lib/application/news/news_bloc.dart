import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:testing_flutter/domain/news/i_news_repo.dart';

import '../../domain/core/failure/failures.dart';
import '../../domain/news/news_modal.dart';

part 'news_state.dart';
part 'news_event.dart';
part 'news_bloc.freezed.dart';

@injectable
class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final INewsRepo newsRepo;
  NewsBloc(this.newsRepo) : super(NewsState.initial()) {
    on<_GetNews>((event, emit) async {
      emit(state.copyWith(isLoading: true, newsFailureOrSuccess: const None(),articles: []));
      final Either<Failures, NewsModal> newsResult = await newsRepo.getNews();
      log(newsResult.toString());
      emit(newsResult.fold(
          (failure) => state.copyWith(
              isLoading: false, newsFailureOrSuccess: Some(Left(failure))),
          (success) => state.copyWith(
              articles: success.articles,
              isLoading: false,
              newsFailureOrSuccess: Some(Right(success)))));
    });
  }
}
