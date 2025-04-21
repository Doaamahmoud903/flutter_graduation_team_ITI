class ProductModel {
  final String id;
  final String title;
  final String image;
  final String description;
  final String price;
  final String priceAfterDiscount;
  final String discount;
  final String rateAvg;

  ProductModel({
    required this.id,
    required this.title,
    required this.image,
    required this.description,
    required this.discount,
    required this.priceAfterDiscount,
    required this.price,
    required this.rateAvg,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['_id'].toString() ?? "",
      title: json['title'].toString() ?? "",
      image: json['imageCover']['secure_url'].toString() ?? "",
      description: json['description'].toString() ?? "",
      discount: json['discount'].toString() ?? "",
      priceAfterDiscount: json['priceAfterDiscount'].toString() ?? "",
      price: json['price'].toString() ?? "",
      rateAvg: json['rateAvg'].toString() ?? "",
    );
  }
}
