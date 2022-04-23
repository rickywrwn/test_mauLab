// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:test_flutter/bloc/candidate/candidate_bloc.dart';

import 'package:test_flutter/bloc/home/home_bloc.dart';
import 'package:test_flutter/model/home_model.dart';

class candidateDetailPage extends StatelessWidget {
  final Home dataCandidate;

  const candidateDetailPage({Key? key, required this.dataCandidate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CandidateBloc candidateBloc = BlocProvider.of<CandidateBloc>(context);

    showAlertDialog(BuildContext context) {
      // set up the button
      Widget okButton = TextButton(
        child: Text("OK"),
        onPressed: () {
          candidateBloc.onLoad(dataCandidate.id_candidate.toString());
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
          title: Text("Detail Blog"),
          centerTitle: true,
        ),
        body: BlocListener<CandidateBloc, CandidateState>(
          listener: (context, state) {
            print(state);
            // TODO: implement listener

            if (state is LoadingCandidateState) {
              context.loaderOverlay.show();
            } else {
              context.loaderOverlay.hide();
            }

            if (state is GetCandidateFailureState || state is GetCandidateFailedState) {
              showAlertDialog(context);
            }
          },
          child: Container(
            color: Colors.white,
            child: BlocBuilder<CandidateBloc, CandidateState>(
              builder: (context, state) {
                var birthday = DateTime.fromMicrosecondsSinceEpoch(dataCandidate.birthday!);
                var exp = DateTime.fromMillisecondsSinceEpoch(dataCandidate.expired! * 1000);

                if (state is CandidateInitial) {
                  candidateBloc.onLoad(dataCandidate.id_candidate.toString());
                }
                if (state is GetSuccessState) {
                  return SingleChildScrollView(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Image.network(dataCandidate.photo_candidate!, height: 150, fit: BoxFit.fitHeight,
                          errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                        return Text("No Image");
                      }),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: Text(
                          "Name : " + dataCandidate.name!,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                        child: Text(
                          "Email : " + state.dataEmail[0].email!,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                        child: Text(
                          "Phone : " + state.dataEmail[0].phone!,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                        child: Text(
                          "Gender : " + dataCandidate.gender!,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                        child: Text(
                          "Birthday : " + birthday.toString(),
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                        child: Text(
                          "Address : " + state.dataAddress[0].address! + ", " + state.dataAddress[0].city! + ", " + state.dataAddress[0].city!,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                        child: Text(
                          "Zipcode : " + state.dataAddress[0].zip_code.toString(),
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                        child: Text(
                          "Expired : " + exp.toString(),
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                        child: Text(
                          "Experience",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                        child: Text(
                          "Job Title : " + state.dataExperience[0].job_title!,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                        child: Text(
                          "Company Name : " + state.dataExperience[0].company_name!,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                        child: Text(
                          "Industry : " + state.dataExperience[0].industry!,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                        child: Text(
                          "Status : " + state.dataExperience[0].status!,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ));
                } else {
                  return Text("");
                }
              },
            ),
          ),
        ));
  }
}
