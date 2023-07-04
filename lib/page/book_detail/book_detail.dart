// ignore_for_file: sized_box_for_whitespace

import 'dart:convert';
import 'dart:typed_data';

import 'package:booking_book/constant/book_category.dart';
import 'package:booking_book/constant/function.dart';
import 'package:booking_book/main.dart';
import 'package:booking_book/models/book_model.dart';
import 'package:booking_book/models/category_book.dart';
import 'package:booking_book/reuseable/app_bar.dart';
import 'package:booking_book/reuseable/button.dart';
import 'package:booking_book/reuseable/modal_dialog.dart';
import 'package:booking_book/reuseable/text_field.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../objectbox.g.dart';

class BookDetail extends StatefulWidget {
  const BookDetail(
      {super.key, required this.book, required this.onSuccessUpdate});

  final BookModel book;
  final void Function(bool) onSuccessUpdate;

  @override
  State<BookDetail> createState() => _BookDetailState();
}

class _BookDetailState extends State<BookDetail> {
  final TextEditingController codeBukuController = TextEditingController();
  final TextEditingController isbnController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController publishDateController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final Box<BookModel> bookBox = store.box<BookModel>();

  bool isDetailSelected = false;
  String? coverBook;
  String? imageBase64;
  Uint8List? imageBytes;

  @override
  void initState() {
    super.initState();
    codeBukuController.text = widget.book.bookCode;
    isbnController.text = widget.book.isbn;
    titleController.text = widget.book.title;
    descriptionController.text = widget.book.description ?? "";
    publishDateController.text = widget.book.publishedDate ?? "";
    priceController.text = widget.book.price.toInt().toString();
    categoryController.text = widget.book.category;
    coverBook = widget.book.hardCover ?? "";
  }

  Future<void> pickImage() async {
    final imagePicker = ImagePicker();
    XFile? pickedImage = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedImage != null) {
      Uint8List uint8 = await pickedImage.readAsBytes();
      setState(() {
        imageBytes = uint8;
        imageBase64 = base64Encode(uint8);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mQ = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.only(
          top: mQ.padding.top,
          left: 20,
          right: 20,
        ),
        child: Column(
          children: [
            CustomAppBar(
              text: widget.book.title,
            ),
            const SizedBox(
              height: 40,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isDetailSelected = false;
                            });
                          },
                          child: Container(
                            width: 100,
                            decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.black),
                              borderRadius: BorderRadius.circular(12),
                              color: (!isDetailSelected)
                                  ? Colors.green
                                  : Colors.transparent,
                            ),
                            padding: const EdgeInsets.all(10),
                            child: Center(
                              child: Text(
                                "Profil",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: (!isDetailSelected)
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isDetailSelected = true;
                            });
                          },
                          child: Container(
                            width: 100,
                            decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.black),
                              borderRadius: BorderRadius.circular(12),
                              color: (isDetailSelected)
                                  ? Colors.green
                                  : Colors.transparent,
                            ),
                            padding: const EdgeInsets.all(10),
                            child: Center(
                              child: Text(
                                "Detail",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: (isDetailSelected)
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    (!isDetailSelected)
                        ? Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              vertical: 20,
                              horizontal: 10,
                            ),
                            decoration: BoxDecoration(
                              border:
                                  Border.all(width: 1, color: Colors.black54),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              children: [
                                (widget.book.hardCover != null &&
                                        widget.book.hardCover != "")
                                    ? Container(
                                        width: 200,
                                        height: 200,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          child: Image.memory(
                                            base64Decode(
                                                widget.book.hardCover!),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      )
                                    : Container(
                                        width: 200,
                                        height: 200,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          child: const Icon(
                                            Icons.image,
                                            size: 200,
                                          ),
                                        ),
                                      ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  widget.book.title,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                ),
                                (widget.book.description != null &&
                                        widget.book.description != "")
                                    ? Container(
                                        margin: const EdgeInsets.only(
                                          top: 10,
                                        ),
                                        child: Text(
                                          widget.book.description!,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black,
                                            fontSize: 20,
                                          ),
                                          textAlign: TextAlign.center,
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      )
                                    : const SizedBox()
                              ],
                            ),
                          )
                        : Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              vertical: 20,
                              horizontal: 10,
                            ),
                            decoration: BoxDecoration(
                              border:
                                  Border.all(width: 1, color: Colors.black54),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                RowDetail(
                                  title: "Judul: ",
                                  value: titleController.text,
                                  onTapEdit: () {
                                    modalDialogGlobal(
                                      context: context,
                                      customBody: Container(
                                        width: double.infinity,
                                        child: Column(
                                          children: [
                                            InputTextField(
                                              controller: titleController,
                                              labelText: "Judul Buku",
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            CustomButton(
                                              text: "Tutup",
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                RowDetail(
                                  title: "Kode: ",
                                  value: codeBukuController.text,
                                  onTapEdit: () {
                                    modalDialogGlobal(
                                      context: context,
                                      customBody: Container(
                                        width: double.infinity,
                                        child: Column(
                                          children: [
                                            InputTextField(
                                              controller: codeBukuController,
                                              labelText: "Edit Kode Buku",
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            CustomButton(
                                              text: "Tutup",
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                RowDetail(
                                  title: "Harga: ",
                                  value:
                                      "IDR ${formatNumber().format(int.parse(priceController.text)).toString()}",
                                  onTapEdit: () {
                                    modalDialogGlobal(
                                      context: context,
                                      customBody: Container(
                                        width: double.infinity,
                                        child: Column(
                                          children: [
                                            InputTextField(
                                              controller: priceController,
                                              labelText: "Harga",
                                              inputType: TextInputType.number,
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            CustomButton(
                                              text: "Tutup",
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                RowDetail(
                                  title: "Kategori: ",
                                  value: categoryController.text,
                                  onTapEdit: () {
                                    modalDialogGlobal(
                                      context: context,
                                      customBody: Container(
                                        width: double.infinity,
                                        child: Column(
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(
                                                bottom: 12,
                                                top: 10,
                                              ),
                                              child: const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Kategori",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.black54,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: double.infinity,
                                              height: 70,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors
                                                        .grey), // Dekorasi border
                                                borderRadius: BorderRadius.circular(
                                                    12), // Dekorasi border radius
                                              ),
                                              child: DropdownButton(
                                                padding:
                                                    const EdgeInsets.all(20),
                                                hint: Text(
                                                  categoryController.text,
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black54,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                items: bookCategories
                                                    .map((categoy) =>
                                                        DropdownMenuItem<
                                                            String>(
                                                          value: categoy.id
                                                              .toString(),
                                                          child: Text(
                                                            categoy
                                                                .categoryName,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                        ))
                                                    .toList(),
                                                onChanged: ((value) {
                                                  setState(() {
                                                    CategoryBook
                                                        book =
                                                        bookCategories.firstWhere(
                                                            (element) =>
                                                                element.id
                                                                    .toString() ==
                                                                value);
                                                    categoryController.text =
                                                        book.categoryName;
                                                    Navigator.pop(context);
                                                  });
                                                }),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            CustomButton(
                                              text: "Tutup",
                                              colorButton: Colors.transparent,
                                              colorText: Colors.black,
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                RowDetail(
                                  title: "Tanggal Rilis: ",
                                  value: publishDateController.text,
                                  onTapEdit: () async {
                                    DateTime? result = await showDatePicker(
                                      context: context,
                                      initialDate:
                                          (publishDateController.text != "")
                                              ? DateTime.parse(
                                                  publishDateController.text)
                                              : DateTime.now(),
                                      firstDate: DateTime.parse(
                                          "1900-01-01"), // awal pilih di tahun 1900
                                      lastDate: DateTime.now(),
                                    );
                                    if (result != null) {
                                      setState(() {
                                        publishDateController.text =
                                            result.toString().split(" ")[0];
                                      });
                                    }
                                  },
                                ),
                                RowDetail(
                                  title: "ISBN: ",
                                  value: isbnController.text,
                                  onTapEdit: () {
                                    modalDialogGlobal(
                                      context: context,
                                      customBody: Container(
                                        width: double.infinity,
                                        child: Column(
                                          children: [
                                            InputTextField(
                                              controller: isbnController,
                                              labelText: "ISBN",
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            CustomButton(
                                              text: "Tutup",
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                (coverBook != "" || imageBytes != null)
                                    ? GestureDetector(
                                        onTap: pickImage,
                                        child: Container(
                                          width: 200,
                                          height: 200,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            child: (imageBytes == null)
                                                ? Image.memory(
                                                    base64Decode(coverBook!),
                                                    fit: BoxFit.fill,
                                                  )
                                                : Image.memory(
                                                    imageBytes!,
                                                    fit: BoxFit.fill,
                                                  ),
                                          ),
                                        ),
                                      )
                                    : GestureDetector(
                                        onTap: pickImage,
                                        child: Container(
                                          width: 200,
                                          height: 200,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            child: const Icon(
                                              Icons.image,
                                              size: 200,
                                            ),
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                          ),
                    Container(
                      margin: const EdgeInsets.only(
                        top: 20,
                      ),
                      child: CustomButton(
                        text: "Simpan",
                        onTap: () {
                          modalDialogGlobal(
                              context: context,
                              title: "Ubah Data",
                              contentBody:
                                  "Apa anda yakin ingin mengubah data ini ?",
                              buttonText: "OK",
                              tapButton: () {
                                Navigator.pop(context);
                                QueryBuilder<BookModel> builderIsbn =
                                    bookBox.query(
                                  BookModel_.isbn
                                      .equals(isbnController.text)
                                      .and(BookModel_.id
                                          .notEquals(widget.book.id)),
                                );
                                Query<BookModel> queryIsbn =
                                    builderIsbn.build();
                                if (queryIsbn.find().isNotEmpty) {
                                  modalDialogGlobal(
                                    context: context,
                                    title: "Gagal",
                                    contentBody: "ISBN telah terdaftar",
                                    buttonText: "OK",
                                    tapButton: () {
                                      Navigator.pop(context);
                                    },
                                  );
                                  return;
                                }

                                QueryBuilder<BookModel> builderBookCode =
                                    bookBox.query(
                                  BookModel_.isbn
                                      .equals(isbnController.text)
                                      .and(BookModel_.id
                                          .notEquals(widget.book.id)),
                                );
                                Query<BookModel> queryBookCode =
                                    builderBookCode.build();
                                if (queryBookCode.find().isNotEmpty) {
                                  modalDialogGlobal(
                                    context: context,
                                    title: "Gagal",
                                    contentBody: "Kode buku telah terdaftar",
                                    buttonText: "OK",
                                    tapButton: () {
                                      Navigator.pop(context);
                                    },
                                  );
                                  return;
                                }

                                bookBox.put(BookModel(
                                  id: widget.book.id,
                                  bookCode: codeBukuController.text,
                                  category: categoryController.text,
                                  description: descriptionController.text,
                                  hardCover: coverBook,
                                  isbn: isbnController.text,
                                  price:
                                      double.tryParse(priceController.text) ??
                                          0,
                                  publishedDate: publishDateController.text,
                                  title: titleController.text,
                                ));
                                modalDialogGlobal(
                                  context: context,
                                  title: "Sukses",
                                  contentBody: "Data telah diupdate",
                                  buttonText: "OK",
                                  tapButton: () {
                                    widget.onSuccessUpdate(true);
                                    Navigator.pop(context);
                                  },
                                );
                              },
                              cancelButtonText: "Batal",
                              isActiveCancelButton: true,
                              tapButtonCancel: () {
                                Navigator.pop(context);
                              });
                        },
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class RowDetail extends StatelessWidget {
  const RowDetail({
    super.key,
    required this.title,
    required this.value,
    this.onTapEdit,
  });

  final String title;
  final String value;
  final void Function()? onTapEdit;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: Colors.black,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.black,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: onTapEdit,
            child: const Icon(
              Icons.edit,
              color: Colors.green,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}
