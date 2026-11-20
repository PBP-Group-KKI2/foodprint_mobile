class Article {
  const Article({
    required this.id,
    required this.title,
    required this.categoryLabel,
    required this.excerpt,
    required this.author,
    required this.views,
    required this.likeCount,
    required this.commentCount,
    required this.createdAt,
  });

  final int id;
  final String title;
  final String categoryLabel;
  final String excerpt;
  final String author;
  final int views;
  final int likeCount;
  final int commentCount;
  final DateTime createdAt;

  factory Article.fromJson(Map<String, dynamic> json) => Article(
    id: json['id'] as int,
    title: json['title'] as String,
    categoryLabel: json['category_label'] as String,
    excerpt: json['excerpt'] as String,
    author: json['author'] as String,
    views: json['views'] as int,
    likeCount: json['like_count'] as int,
    commentCount: json['comment_count'] as int,
    createdAt: DateTime.parse(json['created_at'] as String),
  );
}
