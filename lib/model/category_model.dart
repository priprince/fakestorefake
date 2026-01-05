import 'package:fakestorefake/database/hive_types.dart';
import 'package:hive/hive.dart';
part 'category_model.g.dart';

// @HiveType(typeId: HiveTypes.categoryData)
// class CategoryData {
//   @HiveField(0)
//   List<Category>? categories;

//   CategoryData({this.categories});

//   factory CategoryData.fromJson(Map<String, dynamic> json) => CategoryData(
//     categories: json["categories"] == null
//         ? []
//         : List<Category>.from(
//             json["categories"]!.map((x) => Category.fromJson(x)),
//           ),
//   );

//   Map<String, dynamic> toJson() => {
//     "categories": categories == null
//         ? []
//         : List<dynamic>.from(categories!.map((x) => x.toJson())),
//   };
// }

@HiveType(typeId: HiveTypes.category)
class Category {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? image;

  Category({this.id, this.name, this.image});

  factory Category.fromJson(Map<String, dynamic> json) =>
      Category(id: json["id"], name: json["name"], image: json["image"]);

  Map<String, dynamic> toJson() => {"id": id, "name": name, "image": image};
}
