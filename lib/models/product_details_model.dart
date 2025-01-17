// To parse this JSON data, do
//
//     final productDetailsModel = productDetailsModelFromJson(jsonString);

import 'dart:convert';

ProductDetailsModel productDetailsModelFromJson(String str) => ProductDetailsModel.fromJson(json.decode(str));

String productDetailsModelToJson(ProductDetailsModel data) => json.encode(data.toJson());

class ProductDetailsModel {
  int productId;
  String name;
  String description;
  Category category;
  num averageRating;
  List<ProductImage> productImages;
  List<ProductVariant> productVariants;

  ProductDetailsModel({
    required this.productId,
    required this.name,
    required this.description,
    required this.category,
    required this.averageRating,
    required this.productImages,
    required this.productVariants,
  });

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) => ProductDetailsModel(
        productId: json["product_id"],
        name: json["name"],
        description: json["description"],
        category: Category.fromJson(json["category"]),
        averageRating: json["average_rating"],
        productImages: List<ProductImage>.from(json["product_images"].map((x) => ProductImage.fromJson(x))),
        productVariants: List<ProductVariant>.from(json["product_variants"].map((x) => ProductVariant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "name": name,
        "description": description,
        "category": category.toJson(),
        "average_rating": averageRating,
        "product_images": List<dynamic>.from(productImages.map((x) => x.toJson())),
        "product_variants": List<dynamic>.from(productVariants.map((x) => x.toJson())),
      };
}

class Category {
  int id;
  String name;
  dynamic parentName;
  List<dynamic> children;

  Category({
    required this.id,
    required this.name,
    required this.parentName,
    required this.children,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        parentName: json["parent_name"],
        children: List<dynamic>.from(json["children"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "parent_name": parentName,
        "children": List<dynamic>.from(children.map((x) => x)),
      };
}

class ProductImage {
  String productImage;
  int displayOrder;
  bool isCoverImage;

  ProductImage({
    required this.productImage,
    required this.displayOrder,
    required this.isCoverImage,
  });

  factory ProductImage.fromJson(Map<String, dynamic> json) => ProductImage(
        productImage: json["product_image"],
        displayOrder: json["display_order"],
        isCoverImage: json["is_cover_image"],
      );

  Map<String, dynamic> toJson() => {
        "product_image": productImage,
        "display_order": displayOrder,
        "is_cover_image": isCoverImage,
      };
}

class ProductVariant {
  int productVariantId;
  String weightInGrams;
  String actualPrice;
  String sellingPrice;
  String cgstRate;
  String sgstRate;
  String sku;
  int stockQty;
  bool isAvailable;
  num discountPercentage;

  ProductVariant({
    required this.productVariantId,
    required this.weightInGrams,
    required this.actualPrice,
    required this.sellingPrice,
    required this.cgstRate,
    required this.sgstRate,
    required this.sku,
    required this.stockQty,
    required this.isAvailable,
    required this.discountPercentage,
  });

  factory ProductVariant.fromJson(Map<String, dynamic> json) => ProductVariant(
        productVariantId: json["product_variant_id"],
        weightInGrams: json["weight_in_grams"],
        actualPrice: json["actual_price"],
        sellingPrice: json["selling_price"],
        cgstRate: json["cgst_rate"],
        sgstRate: json["sgst_rate"],
        sku: json["sku"],
        stockQty: json["stock_qty"],
        isAvailable: json["is_available"],
        discountPercentage: json["discount_percentage"],
      );

  Map<String, dynamic> toJson() => {
        "product_variant_id": productVariantId,
        "weight_in_grams": weightInGrams,
        "actual_price": actualPrice,
        "selling_price": sellingPrice,
        "cgst_rate": cgstRate,
        "sgst_rate": sgstRate,
        "sku": sku,
        "stock_qty": stockQty,
        "is_available": isAvailable,
        "discount_percentage": discountPercentage,
      };
}
