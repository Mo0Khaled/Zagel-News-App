import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zagel_news_app/features/news/domain/entities/article_entity.dart';
import 'package:zagel_news_app/features/news/presentation/logic/get_articles_by_ctegory_provider.dart';
import 'package:zagel_news_app/injection_container.dart';
import 'package:zagel_news_app/features/news/domain/repositories/article_repository.dart';

class HomePageRiver extends StatelessWidget {
  const HomePageRiver({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Zagel News'),
      ),
      body: Consumer(builder: (context, ref, child) {
        final AsyncValue<List<ArticleEntity>> articles =
            ref.watch(articlesByCategoryProvider);

        ref.listen<AsyncValue<void>>(articlesByCategoryProvider,
            (previous, next) {
          next.whenOrNull(error: (error, x) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(error.toString())));
          });
        });
        final loading = articles is AsyncLoading<void>;
        if (loading == true) {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        } else {
          return ListView(
            children: [
              Text(articles.value!.length.toString()),
              for (final article in articles.value!)
                ListTile(
                  title: Text(article.author ?? ""),
                  subtitle: Text(article.content ?? ""),
                ),
            ],
          );
        }
      }),
    );
  }
}
