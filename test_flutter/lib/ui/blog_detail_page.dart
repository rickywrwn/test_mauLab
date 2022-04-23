import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:test_flutter/bloc/home/home_bloc.dart';
import 'package:test_flutter/model/home_model.dart';

class blogDetailPage extends StatelessWidget {
  final Home dataBlog;

  const blogDetailPage({Key? key, required this.dataBlog}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var date = DateTime.fromMillisecondsSinceEpoch(dataBlog.create_at! * 1000);
    return Scaffold(
        appBar: AppBar(
          title: Text("Detail Blog"),
          centerTitle: true,
        ),
        body: Container(
          color: Colors.white,
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.network(dataBlog.photo_candidate!, height: 150, fit: BoxFit.fitHeight,
                  errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                return Text("No Image");
              }),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Text(
                  dataBlog.title!,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Text(
                  dataBlog.content!,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Text(
                  "Author : " + dataBlog.author!,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                child: Text(
                  "Tags : " + dataBlog.tag!,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                child: Text(
                  "Date : " + date.toString(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ],
          )),
        ));
  }
}
