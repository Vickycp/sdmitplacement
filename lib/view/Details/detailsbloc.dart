import 'dart:async';

import 'package:rxdart/subjects.dart';

class Detailsbloc {
  final _puc = BehaviorSubject<String>();
  final _sslc = BehaviorSubject<String>();
  final _dob = BehaviorSubject<String>();
  final _sem = BehaviorSubject<dynamic>();
  Stream<String> get puc => _puc.stream.transform(pucvalidate);
  Stream<String> get sslc => _sslc.stream.transform(sslcvalidate);
  Stream<String> get dob => _dob.stream.transform(dobvalidate);
  Stream<dynamic> get sem => _sem.stream.transform(semvalidate);

  Function(String) get pucsink => _puc.sink.add;
  Function(String) get sslcsink => _sslc.sink.add;
  Function(String) get dobsink => _dob.sink.add;
  Function(dynamic) get semsink => _sem.sink.add;
  final pucvalidate = StreamTransformer<String, String>.fromHandlers(
    handleData: (puc, sink) {
      print(puc);
      bool isEmail(pu) {
        String p = r'^([1-9]([0-9])?|0)(\.[0-9]{1,2})$';

        RegExp regExp = new RegExp(p);

        return regExp.hasMatch(pu);
      }

      if (isEmail(puc)) {
        sink.add(puc);
      } else {
        sink.addError("not valid percent");
      }
    },
  );
  final sslcvalidate = StreamTransformer<String, String>.fromHandlers(
    handleData: (sslc, sink) {
      bool isEmail(sslc) {
        String p = r'^([1-9]([0-9])?|0)(\.[0-9]{1,2})$';

        RegExp regExp = new RegExp(p);

        return regExp.hasMatch(sslc);
      }

      if (isEmail(sslc)) {
        sink.add(sslc);
      } else {
        sink.addError("not valid percent");
      }
    },
  );

  final dobvalidate = StreamTransformer<String, String>.fromHandlers(
    handleData: (dob, sink) {
      bool isEmail(dob) {
        String p =
            r'^([0-2][0-9]|(3)[0-1])(\/)(((0)[0-9])|((1)[0-2]))(\/)\d{4}$';

        RegExp regExp = new RegExp(p);

        return regExp.hasMatch(dob);
      }

      if (isEmail(dob)) {
        sink.add(dob);
      } else {
        sink.addError("not valid dob");
      }
    },
  );

  final semvalidate = StreamTransformer<dynamic,dynamic>.fromHandlers(
    handleData: (sem, sink) {
  

      if (sem>=1) {
        sink.add(sem);
      } else {
        sink.addError("not valid dob");
      }
    },
  );

  void dispose() {
    _puc.close();
    _sslc.close();
    _dob.close();
    _sem.close();
  }
}
