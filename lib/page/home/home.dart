import 'dart:convert';

import 'package:booking_book/main.dart';
import 'package:booking_book/models/book_model.dart';
import 'package:booking_book/page/add_book/add_book.dart';
import 'package:booking_book/page/book_detail/book_detail.dart';
import 'package:booking_book/reuseable/app_bar.dart';
import 'package:booking_book/reuseable/modal_dialog.dart';
import 'package:booking_book/reuseable/text_field.dart';
import 'package:flutter/material.dart';
import 'package:objectbox/objectbox.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final Box<BookModel> bookBox = store.box<BookModel>();
  final TextEditingController searchController = TextEditingController();
  List<BookModel> books = [];
  List<BookModel> resultSearch = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() {
    books = bookBox.getAll();
    resultSearch = books;
  }

  void searchBook(String keywords) {
    List<BookModel> result = [];
    if (keywords.isNotEmpty) {
      for (BookModel book in books) {
        if (book.title.toLowerCase().contains(keywords.toLowerCase())) {
          result.add(books.firstWhere((element) => element.id == book.id));
        }
      }
      resultSearch = result;
    } else {
      resultSearch = books;
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
              text: "Koleksi Buku",
              icon: Icons.add,
              canGoback: false,
              ontapIcon: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AddBookView(
                      onSuccessAdd: (success) {
                        if (success) {
                          setState(() {
                            getData();
                          });
                        }
                      },
                    ),
                  ),
                );
              },
            ),
            InputTextField(
              controller: searchController,
              labelText: "",
              hintText: "Cari Buku",
              onChanged: ((keyword) {
                setState(() {
                  searchBook(keyword);
                });
              }),
              suffixIcon: Icons.search,
              isSuffixActive: true,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: resultSearch.length,
                  itemBuilder: (c, i) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BookDetail(
                              book: resultSearch[i],
                              onSuccessUpdate: ((updated) {
                                if (updated) {
                                  setState(() {
                                    getData();
                                  });
                                }
                              }),
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(
                          bottom: 20,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            width: 1,
                            color: Colors.black54,
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            (resultSearch[i].hardCover != "" &&
                                    resultSearch[i].hardCover != null)
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.memory(
                                      base64Decode(resultSearch[i].hardCover!),
                                      width: 50,
                                      height: 50,
                                    ),
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: const Icon(
                                      Icons.image,
                                      size: 50,
                                    ),
                                  ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                resultSearch[i].title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            GestureDetector(
                              onTap: () {
                                modalDialogGlobal(
                                    context: context,
                                    title: "Hapus Data",
                                    contentBody:
                                        "Apa anda yakin ingin menghapus data ini ?",
                                    buttonText: "OK",
                                    tapButton: () {
                                      bookBox.remove(resultSearch[i].id);
                                      setState(() {
                                        getData();
                                      });
                                      Navigator.pop(context);
                                    },
                                    cancelButtonText: "Batal",
                                    isActiveCancelButton: true,
                                    tapButtonCancel: () {
                                      Navigator.pop(context);
                                    });
                              },
                              child: const Icon(
                                Icons.delete_forever,
                                color: Colors.red,
                                size: 30,
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
