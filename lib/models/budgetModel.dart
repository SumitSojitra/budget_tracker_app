import 'dart:typed_data';

class BudgetModel{
  int? id;
  String category_name;
  Uint8List category_image;

  BudgetModel({this.id,required this.category_image,required this.category_name,});

  factory BudgetModel.sql({required Map data}){
    return BudgetModel(category_image: data['category_image'], category_name: data['category_name']);
  }
}