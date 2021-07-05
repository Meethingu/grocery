class Data {
  String name;
  String img_product;
  int actual_price;

  Data({this.name, this.actual_price, this.img_product});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];

    img_product = json['img_product'];
    actual_price = json['actual_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['img_product'] = this.img_product;

    data['actual_price'] = this.actual_price;
    return data;
  }
}
