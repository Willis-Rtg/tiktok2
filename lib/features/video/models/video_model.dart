class VideoModel {
  String title;
  String description;
  String fileUrl;
  String thumbnailUrl;
  DateTime createdAt;
  int likes;
  int comments;
  String uid;
  String creator;

  VideoModel({
    required this.title,
    required this.description,
    required this.fileUrl,
    required this.thumbnailUrl,
    required this.createdAt,
    required this.likes,
    required this.comments,
    required this.uid,
    required this.creator,
  });

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "description": description,
      "fileUrl": fileUrl,
      "thumbnailUrl": thumbnailUrl,
      "createdAt": createdAt,
      "likes": likes,
      "comments": comments,
      "uid": uid,
      "creator": creator,
    };
  }
}
