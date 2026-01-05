import 'package:fakestorefake/database/hive_types.dart';
import 'package:fakestorefake/model/category_model.dart';
import 'package:hive/hive.dart';

part 'product_model.g.dart';

// @HiveType(typeId: HiveTypes.productModel)
// class ProductModel {
//   @HiveField(0)
//   ProductData? data;

//   ProductModel({this.data});

//   factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
//     data: json["data"] == null ? null : ProductData.fromJson(json["data"]),
//   );

//   Map<String, dynamic> toJson() => {"data": data?.toJson()};
// }

// @HiveType(typeId: HiveTypes.productData)
// class ProductData {
//   @HiveField(0)
//   List<Product>? products;

//   ProductData({this.products});

//   factory ProductData.fromJson(Map<String, dynamic> json) => ProductData(
//     products: json["products"] == null
//         ? []
//         : List<Product>.from(json["products"]!.map((x) => Product.fromJson(x))),
//   );

//   Map<String, dynamic> toJson() => {
//     "products": products == null
//         ? []
//         : List<dynamic>.from(products!.map((x) => x.toJson())),
//   };
// }

@HiveType(typeId: HiveTypes.product)
class Product {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? title;
  @HiveField(2)
  int? price;
  @HiveField(3)
  String? description;
  @HiveField(4)
  List<String>? images;
  @HiveField(5)
  Category? category;

  Product({
    this.id,
    this.title,
    this.price,
    this.description,
    this.images,
    this.category,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    title: json["title"],
    price: json["price"],
    description: json["description"],
    images: json["images"] == null
        ? []
        : List<String>.from(json["images"]!.map((x) => x)),
    category: json["category"] == null
        ? null
        : Category.fromJson(json["category"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "price": price,
    "description": description,
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
    "category": category?.toJson(),
  };
}
