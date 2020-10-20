import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sdmitplacement/view/auth/bloc/authbloc_bloc.dart';

class Semdetails extends StatefulWidget {
  final int sem;

  Semdetails({this.sem});
  @override
  _SemdetailsState createState() => _SemdetailsState();
}

class _SemdetailsState extends State<Semdetails> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // ignore: missing_return
      onWillPop: () {
        BlocProvider.of<AuthblocBloc>(context).add(Detailsevent());
      },
      child: Scaffold(
        body: Container(
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: widget.sem,
                itemBuilder: (BuildContext context, int index) {
                  int index1 = index + 1;
                  return Padding(
                    padding: EdgeInsets.all(10.0),
                    child: TextField(
                      decoration: InputDecoration(hintText: "Sem$index1"),
                    ),
                  );
                },
              ),
              GestureDetector(
                onTap: () async {
                  Future.delayed(Duration(seconds: 6)).then((value) {
                    for (var i = 0; i < 6; i++) {
                      print(i);
                    }
                    BlocProvider.of<AuthblocBloc>(context).add(Userauthsuccess());
                  });
                  
                },
                child: Text("update"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
