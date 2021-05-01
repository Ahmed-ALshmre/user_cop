class ItemModel {
  String titleAr;
  String nameCon;
  String titleEn;
  List <String> entitle;
  List <String> arTitle;
  List <String> conTitle;
  List<dynamic>imageList;
  List<dynamic> imageTrad;
  String code;
  String dateTime;
  String dateTimeEnd;
  String scienceImage;
  String thumbnailUrl;
  String price;
  int conter;
  String id;
  ItemModel(
      {this.titleEn,this.nameCon,
        this.titleAr,this.conter,
        this.imageList,
        this.dateTimeEnd,
        this.dateTime,
        this.scienceImage,
        this.entitle,
        this.arTitle,
        this.conTitle,
        this.code,
        this.imageTrad,
        this.id,
        this.price,
        this.thumbnailUrl,
      });
  ItemModel.fromJson(Map<String, dynamic> json) {
    titleEn = json['titleEn'];
    scienceImage = json['image'];
    dateTime = json['startS'];
    dateTimeEnd = json['endE'];
    nameCon = json['name_c'];
    titleAr = json['titleAr'];
    entitle = List.castFrom(json['entitle']);
    arTitle = List.castFrom(json['artitle']);
    conTitle = List.castFrom(json['listContry']);
    imageTrad = json['urls'];
    imageList = json['urls'];
    id = json['id'];
    conter = json['conter'];
    code = json['shortInfo'];
    thumbnailUrl = json['thumbnailUrl'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['titleEn'] = this.titleEn;
    data['startS'] = this.dateTime;
    data['endE'] = this.dateTimeEnd;
    data['image'] = this.scienceImage;
    data['name_c'] = this.nameCon;
    data['entitle'] = this.entitle;
    data['artitle'] = this.arTitle;
    data['listContry'] = this.conTitle;
    data['titleAr'] = this.titleAr;
    data['urls'] = this.imageTrad;
    data['urls'] = this.imageList;
    data['id'] = this.id;
    data['conter'] = this.conter;
    data['shortInfo'] = this.code;
    data['price'] = this.price;
    data['thumbnailUrl'] = this.thumbnailUrl;
    return data;
  }
}

class PublishedDate {
  String date;

  PublishedDate({this.date});

  PublishedDate.fromJson(Map<String, dynamic> json) {
    date = json['$date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$date'] = this.date;
    return data;
  }
}
