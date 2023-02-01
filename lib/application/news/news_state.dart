part of 'news_bloc.dart';

@freezed
class NewsState with _$NewsState {
  const factory NewsState(
          {required bool isLoading,
          required List<Article>articles,
          
          required Option<Either<Failures, NewsModal>> newsFailureOrSuccess}) =
      _NewsState;

  factory NewsState.initial() {
    return const NewsState(isLoading: false, newsFailureOrSuccess: None(),articles: []);
  }
}
