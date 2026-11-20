import 'package:material_ui/material_ui.dart';

import 'package:foodprint_mobile/models/article.dart';
import 'package:foodprint_mobile/services/api_service.dart';
import 'package:foodprint_mobile/theme/app_theme.dart';
import 'package:foodprint_mobile/utils/date_format.dart';
import 'package:foodprint_mobile/widgets/left_drawer.dart';
import 'package:foodprint_mobile/widgets/state_views.dart';

class ArticlesPage extends StatefulWidget {
  const ArticlesPage({super.key});

  @override
  State<ArticlesPage> createState() => _ArticlesPageState();
}

class _ArticlesPageState extends State<ArticlesPage> {
  late Future<List<Article>> _articles;

  @override
  void initState() {
    super.initState();
    _articles = ApiService.fetchArticles();
  }

  void _reload() {
    setState(() {
      _articles = ApiService.fetchArticles();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Educational Hub')),
      drawer: const LeftDrawer(),
      body: FutureBuilder<List<Article>>(
        future: _articles,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const LoadingView();
          }
          if (snapshot.hasError) {
            return ErrorView(error: snapshot.error!, onRetry: _reload);
          }
          final articles = snapshot.data!;
          if (articles.isEmpty) {
            return const EmptyView(
              icon: Icons.menu_book_outlined,
              message: 'No articles have been published yet.',
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: articles.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) =>
                _ArticleCard(article: articles[index]),
          );
        },
      ),
    );
  }
}

class _ArticleCard extends StatelessWidget {
  const _ArticleCard({required this.article});

  final Article article;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              article.categoryLabel.toUpperCase(),
              style: const TextStyle(
                color: AppColors.green600,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 4),
            Text(article.title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(article.excerpt, maxLines: 3, overflow: TextOverflow.ellipsis),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Text(
                    '${article.author} · ${formatDate(article.createdAt)}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                _Stat(icon: Icons.favorite_border, value: article.likeCount),
                _Stat(
                  icon: Icons.chat_bubble_outline,
                  value: article.commentCount,
                ),
                _Stat(icon: Icons.visibility_outlined, value: article.views),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.icon, required this.value});

  final IconData icon;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: Row(
        children: [
          Icon(icon, size: 16, color: AppColors.inkSoft),
          const SizedBox(width: 4),
          Text('$value', style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}
