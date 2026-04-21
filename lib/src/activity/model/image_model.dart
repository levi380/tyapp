/// web_list : "banner/1767074071567.jpg"
/// app_list : "banner/1767074074131.jpg"
/// share_img : "banner/1767074082461.jpg"
/// web_main : "banner/1767074090358.jpg"
/// app_main : "banner/1767074096679.jpg"

class ImageModel {
  ImageModel({
    this.webList,
    this.h5List,
    this.h5Share,
    this.webMain,
    this.h5Main,
  });

  ImageModel.fromJson(dynamic json) {
    webList = json['web_list'];
    h5List = json['h5_list'];
    h5Share = json['h5_share'];
    webMain = json['web_main'];
    h5Main = json['h5_main'];
  }

  String? webList;
  String? h5List;
  String? h5Share;
  String? webMain;
  String? h5Main;
}
