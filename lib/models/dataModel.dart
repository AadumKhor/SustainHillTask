class DataModel {
  final String userId;
  final String postId;
  final String title;
  final String body;

  DataModel({this.body, this.postId, this.title, this.userId});

  factory DataModel.fromJSON(Map<String, dynamic> json) {
    return new DataModel(
        body: json['body'],
        title: json['title'],
        postId: json['id'].toString(),
        userId: json['userId'].toString());
  }
}
