
class DataModel{
  String name;
  String image;
  String price;

  DataModel.fromJson(Map<String,dynamic> json)
      : name = json['name'],
        image=json['logo_url'],
        price=json['price'];

  //a method that convert object to json
  Map<String, dynamic> toJson() => {
    'name': name,
    'logo_url': image,
    'price':price
  };

}