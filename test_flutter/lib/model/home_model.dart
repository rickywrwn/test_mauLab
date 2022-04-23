class Home {
  final int? id_candidate;
  final int? birthday;
  final int? expired;
  final String? name;
  final String? gender;
  final String? photo_candidate;

  //blog
  final int? id_blog;
  final int? create_at;
  final String? title;
  final String? subTitle;
  final String? content;
  final String? author;
  final String? photo_blog;
  final String? tag;

  Home(
      {this.id_candidate,
      this.birthday,
      this.expired,
      this.name,
      this.gender,
      this.photo_candidate,
      this.id_blog,
      this.create_at,
      this.title,
      this.subTitle,
      this.content,
      this.author,
      this.photo_blog,
      this.tag});

  factory Home.fromJson(Map<String?, dynamic> json) {
    return Home(
        id_candidate: json['id'] as int?,
        birthday: json['birthday'] as int?,
        expired: json['expired'] as int?,
        name: json['name'] as String?,
        gender: json['gender'] == "m" ? "Male" : "Female",
        photo_candidate: json['photo'] as String?,
        id_blog: json['id'] as int?,
        create_at: json['create_at'] as int?,
        title: json['title'] as String?,
        subTitle: json['subTitle'] as String?,
        content: json['content'] as String?,
        author: json['author'] as String?,
        photo_blog: json['photo'] as String?,
        tag: json['tag'] as String?);
  }
}
