import 'package:objectbox/objectbox.dart';

@Entity()
class BookModel {
  int id;
  String bookCode;
  String isbn;
  String title;
  String? description;
  String category;
  String? publishedDate;
  double price;
  String? hardCover;

  BookModel({
    this.id = 0,
    this.bookCode = "",
    this.isbn = "",
    this.title = "",
    this.description = "",
    this.category = "",
    this.publishedDate = "",
    this.price = 0,
    this.hardCover = "",
  });

  // factory BookModel.fromJson(Map<String, dynamic> json) {
  //   return BookModel(
  //     bookCode: json['bookCode'],
  //     isbn: json['isbn'],
  //     title: json['title'],
  //     category: json['category'],
  //     price: json['price'],
  //     description: json['description'],
  //     publishedDate: json['publishedDate'],
  //     hardCover: json['hardCover'],
  //   );
  // }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'bookCode': bookCode,
  //     'isbn': isbn,
  //     'title': title,
  //     'description': description ?? "",
  //     'category': category,
  //     'publishedDate': publishedDate ?? "",
  //     'price': price,
  //     'hardCover': hardCover ?? "",
  //   };
  // }
}
