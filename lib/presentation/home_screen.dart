import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_flutter/application/news/news_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      BlocProvider.of<NewsBloc>(context).add(const NewsEvent.getNews());
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text("News App"),
      ),
      body: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (state.articles.isNotEmpty) {
              return ListView.separated(
                  padding: const EdgeInsets.all(10),
                  itemCount: state.articles.length,
                  separatorBuilder: (context, index) => const Divider(
                        height: 10,
                        indent: 5,
                        endIndent: 5,
                      ),
                  itemBuilder: ((context, index) => ListTile(
                    leading: CircleAvatar(backgroundImage: NetworkImage(state.articles[index].urlToImage.toString())),
                        title: Text(state.articles[index].title),
                        subtitle: Text(state.articles[index].description),
                      )));
            } else {
              return const Text("NO data");
            }
          }
        },
      ),
    );
  }
}
