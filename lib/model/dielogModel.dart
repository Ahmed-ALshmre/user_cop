class DelogM{
  String arTitle;
  String enTitle;
  String imageDelog;
  String code;
  DelogM({this.arTitle,this.enTitle});

  DelogM.fromJson(Map<String, dynamic> json) {
    arTitle = json['artitle'];
    enTitle = json['entitle'];
    code = json['code'];
    imageDelog = json['thumbnailUrl'];
  }
  // ignore: missing_return
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['artitle'] = this.arTitle;
    data['entitle'] = this.enTitle;
    data['code'] = this.code;
    data['thumbnailUrl'] = this.imageDelog;
  }
  }