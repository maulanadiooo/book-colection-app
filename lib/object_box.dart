import 'dart:io';

import 'package:booking_book/objectbox.g.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class ObjectBox {
  final Store store;

  ObjectBox._create(this.store);

  static Future<ObjectBox> create() async {
    Directory directory = await getApplicationDocumentsDirectory();
    Store store =
        await openStore(directory: p.join(directory.path, "books_crud"));

    return ObjectBox._create(store);
  }
}
