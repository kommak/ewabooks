

class BookModel {
  int? id;
  String? title;
  String? author;
  String? year;
  double? rating;
  String? image;
  String? isfav;
  BookModel({this.id,this.title,this.author,this.year,this.rating,this.image,this.isfav});


  BookModel.fromJson(Map<String, dynamic> json) {
    id = json['id']??0;
    title = json['title'].toString();
    author = json['author'].toString();
    year = json['year'].toString();
    image = json['image'].toString();
    rating = json['rating']??0;
    isfav = json['isfav'].toString();
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['author'] = this.author;
    data['year'] = this.year;
    data['image'] = this.image;
    data['rating'] = this.rating;
    data['isfav'] = this.isfav;
    return data;
  }


}