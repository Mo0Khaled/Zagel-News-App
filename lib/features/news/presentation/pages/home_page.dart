import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zagel_news_app/features/news/domain/repositories/article_repository.dart';
import 'package:zagel_news_app/features/news/presentation/logic/news_cubit.dart';
import 'package:zagel_news_app/injection_container.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Zagel News'),
      ),
      body: BlocProvider(
        create: (_) =>
        sl<NewsCubit>()
          ..getArticlesByCategory(category_type.sports),
        child: BlocBuilder<NewsCubit, NewsState>(
          builder: (context, state) {
            return Center(
              child: Text(state.toString()),
            );
          },
        ),
      ),
    );
  }
}
