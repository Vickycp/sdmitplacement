import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sdmitplacement/view/Details/detailsbloc.dart';
import 'package:sdmitplacement/view/auth/bloc/authbloc_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class Details extends StatefulWidget {
  Details();
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  Detailsbloc _detailsbloc = Detailsbloc();
  int _val;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 40.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.blueGrey, Colors.lightBlueAccent]),
        ),
        child: ListView(
          children: [
            Column(
              children: [
                Text(
                  "welcom username",
                  style: GoogleFonts.getFont(
                    'Lato',
                    fontSize: 20.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                        labelText: "Address", hintText: "enter your address"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: StreamBuilder(
                      stream: _detailsbloc.puc,
                      builder: (context, snapshot) {
                        return TextField(
                          keyboardType: TextInputType.number,
                          onChanged: _detailsbloc.pucsink,
                          decoration: InputDecoration(
                            labelText: "PUC",
                            hintText: "puc %",
                            errorText: snapshot.error,
                          ),
                        );
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: StreamBuilder<Object>(
                      stream: _detailsbloc.sslc,
                      builder: (context, snapshot) {
                        return TextField(
                          onChanged: _detailsbloc.sslcsink,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              labelText: "SSLC",
                              hintText: "sslc %",
                              errorText: snapshot.error),
                        );
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    keyboardType: TextInputType.phone,
                    decoration:
                        InputDecoration(labelText: "Phone", hintText: "Phone"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: StreamBuilder(
                      stream: _detailsbloc.dob,
                      builder: (context, snapshot) {
                        return TextField(
                          onChanged: _detailsbloc.dobsink,
                          keyboardType: TextInputType.datetime,
                          decoration: InputDecoration(
                              labelText: "DOB",
                              hintText: "XX/MM/YYY",
                              errorText: snapshot.error),
                        );
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButton(
                    focusColor: Colors.black,
      

                    isExpanded: true,
                    hint: Text("select sem"),
                    value: _val,
                    onChanged: (value) {
                      
                      setState(() {
                        _val = value;
                      });
                    },
                    items: [1, 2, 3, 4, 5, 6, 7, 8].map((e) {
                      return DropdownMenuItem(
                          value: e, child: Text(e.toString()));
                    }).toList(),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Future.delayed(Duration(seconds: 3)).then((value) {
                      BlocProvider.of<AuthblocBloc>(context)
                          .add(SemDetailsevent(sem: _val));
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 40,
                    width: 150,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Text("update"),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
