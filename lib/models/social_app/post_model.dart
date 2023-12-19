class PostModel {
  String ? name;
  String ? uId;
  String ? image;
  String ? datTime;
  String ? text;
  String ? postImage;

  PostModel({
    this.name,
    this.uId,
    this.image,
    this.datTime,
    this.text,
    this.postImage,
  });
  PostModel.fromJson(Map<String,dynamic>? json){
    name = json!['name'];
    uId = json['uId'];
    image = json['image'];
    datTime = json['datTime'];
    text = json['text'];
    postImage = json['postImage'];
  }

  Map<String,dynamic> toMap(){
    return {
      'name': name,
      'uId': uId,
      'image': image,
      'datTime': datTime,
      'text': text,
      'postImage': postImage,
    };
  }
}
