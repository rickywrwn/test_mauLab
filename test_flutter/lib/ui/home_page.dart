import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:test_flutter/bloc/candidate/candidate_bloc.dart';
import 'dart:async';

import 'package:test_flutter/bloc/home/home_bloc.dart';
import 'package:test_flutter/model/home_model.dart';
import 'package:test_flutter/ui/blog_detail_page.dart';
import 'package:test_flutter/ui/candidate_detail_page.dart';

class homePageContainer extends StatefulWidget {
  @override
  State createState() => new homePage();
}

class homePage extends State<homePageContainer> {
  List<Home> dataSearch = [];

  TextEditingController search = TextEditingController();

  @override
  void initState() {
    super.initState();
    this.setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    HomeBloc homeBloc = BlocProvider.of<HomeBloc>(context);

    showAlertDialog(BuildContext context) {
      // set up the button
      Widget okButton = TextButton(
        child: Text("OK"),
        onPressed: () {
          homeBloc.onLoad();
          Navigator.pop(context);
        },
      );

      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text("Information"),
        content: Text("Something's wrong, please try again"),
        actions: [
          okButton,
        ],
      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: Text("Home"),
        ),
        body: Container(
            color: Colors.white,
            child: BlocListener<HomeBloc, HomeState>(
              listener: (context, state) {
                // TODO: implement listener

                if (state is LoadingState) {
                  context.loaderOverlay.show();
                } else {
                  context.loaderOverlay.hide();
                }

                if (state is GetFailureState || state is GetHomeFailedState) {
                  print("kene");
                  showAlertDialog(context);
                }
              },
              child: SingleChildScrollView(child: BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  print(state);

                  if (state is HomeInitial) {
                    homeBloc.onLoad();
                  }

                  if (state is GetHomeSuccessState) {
                    if (search.text == "") {
                      dataSearch = state.dataHome;
                    }

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(children: [
                        TextField(
                          controller: search,
                          onChanged: (value) {
                            setState(() {
                              print(state);
                              print(value);
                              dataSearch = state.dataHome
                                  .where((i) => (i.name?.toLowerCase().contains(value) ?? false) || (i.title?.toLowerCase().contains(value) ?? false))
                                  .toList();

                              print(dataSearch);
                            });
                          },
                          textInputAction: TextInputAction.search,
                          decoration: InputDecoration(border: OutlineInputBorder(), hintText: 'Cari berdasarkan filter', labelText: 'Search'),
                        ),
                        Container(
                            child: ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                                onTap: () {
                                  if (dataSearch[index].title == null) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => BlocProvider(
                                                  create: (context) => CandidateBloc(),
                                                  child: candidateDetailPage(dataCandidate: dataSearch[index]),
                                                )));
                                  } else {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => blogDetailPage(dataBlog: dataSearch[index])));
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                                    decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 1)),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Flexible(
                                            flex: 1,
                                            child: () {
                                              if (dataSearch[index].title == null) {
                                                //candidate
                                                var candidate = dataSearch[index];
                                                return Image.network(candidate.photo_candidate!, height: 100, fit: BoxFit.fitHeight,
                                                    errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                                  return Text("No Image");
                                                });
                                              } else {
                                                var blog = dataSearch[index];
                                                return Image.network(blog.photo_blog!, fit: BoxFit.fitWidth,
                                                    errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                                  return Text("No Image");
                                                });
                                              }
                                            }()),
                                        Flexible(
                                            flex: 4,
                                            child: () {
                                              if (dataSearch[index].title == null) {
                                                //candidate
                                                var candidate = dataSearch[index];

                                                var birthday = DateTime.fromMicrosecondsSinceEpoch(candidate.birthday!);
                                                var exp = DateTime.fromMillisecondsSinceEpoch(candidate.expired! * 1000);
                                                return Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                                    children: [
                                                      Text("Name: " + candidate.name!),
                                                      Text("Gender: " + candidate.gender!),
                                                      Text("Birthday: " + birthday.toString()),
                                                      Text("expired: " + exp.toString())
                                                    ],
                                                  ),
                                                );
                                              } else {
                                                var blog = dataSearch[index];
                                                var date = DateTime.fromMillisecondsSinceEpoch(blog.create_at! * 1000);
                                                return Column(
                                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                                      child: Text(
                                                        blog.title!,
                                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                                                      child: Text(
                                                        blog.subTitle!,
                                                        style: TextStyle(fontSize: 16),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                                                      child: Text(
                                                        "Author : " + blog.author!,
                                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                                      child: Text(
                                                        "Tags : " + blog.tag!,
                                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                                      child: Text(
                                                        "Date : " + date.toString(),
                                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              }
                                            }())
                                      ],
                                    ),
                                  ),
                                ));
                          },
                          itemCount: dataSearch.length,
                        ))
                      ]),
                    );
                  } else {
                    return Text("");
                  }
                },
              )),
            )));
  }
}
