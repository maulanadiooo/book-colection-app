import 'dart:convert';
import 'dart:typed_data';

import 'package:booking_book/constant/book_category.dart';
import 'package:booking_book/constant/function.dart';
import 'package:booking_book/main.dart';
import 'package:booking_book/models/book_model.dart';
import 'package:booking_book/models/category_book.dart';
import 'package:booking_book/objectbox.g.dart';
import 'package:booking_book/reuseable/app_bar.dart';
import 'package:booking_book/reuseable/button.dart';
import 'package:booking_book/reuseable/modal_dialog.dart';
import 'package:booking_book/reuseable/text_field.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddBookView extends StatefulWidget {
  const AddBookView({super.key, required this.onSuccessAdd});

  final void Function(bool) onSuccessAdd;

  @override
  State<AddBookView> createState() => _AddBookViewState();
}

class _AddBookViewState extends State<AddBookView> {
  final TextEditingController isbnController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController publishDateController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  final Box<BookModel> bookBox = store.box<BookModel>();

  String selectedBook = "";
  String selectedValue = "";
  bool coverShow = false;
  String? imageBase64;
  Uint8List? imageBytes;

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
        padding: EdgeInsets.only(top: mQ.padding.top, left: 20, right: 20),
        child: Column(
          children: [
            const CustomAppBar(text: "Tambah Buku"),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: InputTextField(
                        controller: isbnController,
                        labelText: "ISBN",
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: InputTextField(
                        controller: titleController,
                        labelText: "Judul",
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: InputTextField(
                        controller: descriptionController,
                        labelText: "Deskripsi",
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        bottom: 12,
                        top: 10,
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Kategori",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 70,
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.grey), // Dekorasi border
                        borderRadius:
                            BorderRadius.circular(12), // Dekorasi border radius
                      ),
                      child: DropdownButton(
                        padding: const EdgeInsets.all(20),
                        hint: Text(
                          selectedValue,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        items: bookCategories
                            .map((categoy) => DropdownMenuItem<String>(
                                  value: categoy.id.toString(),
                                  child: Text(
                                    categoy.categoryName,
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ))
                            .toList(),
                        onChanged: ((value) {
                          setState(() {
                            CategoryBook book = bookCategories.firstWhere(
                                (element) => element.id.toString() == value);
                            selectedBook = value!;
                            selectedValue = book.categoryName;
                          });
                        }),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: InputTextField(
                        controller: publishDateController,
                        labelText: "Tanggal Rilis",
                        hintText: "Klik untuk memilih tanggal",
                        fillColorCustom: Colors.black,
                        ontapTextField: () async {
                          DateTime? result = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.parse(
                                "1900-01-01"), // awal pilih di tahun 1900
                            lastDate: DateTime.now(),
                          );
                          if (result != null) {
                            setState(() {
                              publishDateController.text = result
                                  .toString()
                                  .split(" ")[0]; // hanya ambil tanggal
                            });
                          }
                        },
                        enabled: false,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: InputTextField(
                        controller: priceController,
                        labelText: "Harga",
                        inputType: TextInputType.number,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        top: 20,
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Cover Buku",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: pickImage,
                      child: Center(
                        child: Container(
                          margin: const EdgeInsets.only(top: 10),
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                width: 1,
                                color: Colors.black54,
                              )),
                          child: (imageBytes == null)
                              ? const Center(
                                  child: Icon(
                                    Icons.image,
                                    size: 100,
                                    color: Colors.black54,
                                  ),
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.memory(
                                    imageBytes!,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        top: 20,
                      ),
                      child: CustomButton(
                        text: "Tambah Buku",
                        onTap: () {
                          if (isbnController.text.isEmpty ||
                              titleController.text.isEmpty ||
                              selectedValue == "" ||
                              priceController.text.isEmpty) {
                            modalDialogGlobal(
                              context: context,
                              title: "Informasi",
                              contentBody: "Semua field wajib diisi",
                              buttonText: "OK",
                              tapButton: () {
                                Navigator.pop(context);
                              },
                            );
                            return;
                          }
                          String titleSubstring;
                          if (titleController.text.length >= 3) {
                            titleSubstring =
                                titleController.text.substring(0, 3);
                          } else {
                            // Jika panjang string kurang dari 3 karakter, kembalikan string asli
                            titleSubstring = titleController.text;
                          }

                          if (double.tryParse(priceController.text) == null) {
                            modalDialogGlobal(
                              context: context,
                              title: "Informasi",
                              contentBody:
                                  "Harga hanya bisa diisi dengan angka",
                              buttonText: "OK",
                              tapButton: () {
                                Navigator.pop(context);
                              },
                            );
                            return;
                          }
                          String randomString =
                              "${titleSubstring.toUpperCase()}${generateRandomString(6)}";
                          QueryBuilder<BookModel> builder = bookBox.query(
                              BookModel_.isbn.equals(isbnController.text));
                          Query<BookModel> query = builder.build();
                          if (query.find().isNotEmpty) {
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
                          bookBox.put(
                            BookModel(
                              isbn: isbnController.text,
                              bookCode: randomString,
                              title: titleController.text,
                              description: descriptionController.text,
                              category: selectedValue,
                              publishedDate: publishDateController.text,
                              price: double.parse(priceController.text),
                              hardCover: imageBase64,
                            ),
                          );
                          widget.onSuccessAdd(true);
                          modalDialogGlobal(
                            context: context,
                            title: "Sukses",
                            contentBody: "Berhasil menambahkan data buku",
                            buttonText: "OK",
                            tapButton: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 30,
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
