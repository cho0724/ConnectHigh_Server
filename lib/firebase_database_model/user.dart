import 'dart:core';

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class loginUser {
  String ID;
  String PW;
  String realName;
  String nickName;
  String createdTime;
  String mySchool;
  String email;
  String phoneNumber;
  String eduOfficeCode;
  List<String>? anonyMessage;
  int boolAdmin;
  int boolCertificated;
  int postCount;
  int replCount;

  loginUser(
    this.ID,
    this.nickName,
    this.PW,
    this.realName,
    this.mySchool,
    this.email,
    this.phoneNumber,
    this.eduOfficeCode,
    this.anonyMessage,
    this.boolAdmin,
    this.boolCertificated,
    this.createdTime,
    this.postCount,
    this.replCount,
  );

  loginUser.fromSnapshot(DataSnapshot snapshot)
      : ID = (snapshot.value! as Map<String, dynamic>)['ID'],
        PW = (snapshot.value! as Map<String, dynamic>)['PW'],
        realName = (snapshot.value! as Map<String, dynamic>)['realName'],
        nickName = (snapshot.value! as Map<String, dynamic>)['nickName'],
        mySchool = (snapshot.value! as Map<String, dynamic>)['myschool'],
        email = (snapshot.value! as Map<String, dynamic>)['email'],
        phoneNumber = (snapshot.value! as Map<String, dynamic>)['phoneNumber'],
        eduOfficeCode = (snapshot.value! as Map<String, dynamic>)['eduOfficeCode'],
        anonyMessage =
            (snapshot.value! as Map<List<String>, dynamic>?)?['anonyMessage'] ??
                '',
        boolAdmin =
            (snapshot.value! as Map<List<String>, dynamic>)['boolAdmin'],
        createdTime =
            (snapshot.value! as Map<List<String>, dynamic>)['createTime'],
        boolCertificated =
            (snapshot.value! as Map<List<String>, dynamic>)['boolCertificated'],
        postCount =
            (snapshot.value! as Map<List<String>, dynamic>)['postCount'],
        replCount =
            (snapshot.value! as Map<List<String>, dynamic>)['replCount'];

  toJson() {
    return {
      'ID': ID,
      'realName': realName,
      'PW': PW,
      'nickName': nickName,
      'mySchool': mySchool,
      'email': email,
      'phoneNumber': phoneNumber,
      'eduOfficeCode' : eduOfficeCode,
      'anonyMessage': anonyMessage,
      'boolAdmin': boolAdmin,
      'createdTime': createdTime,
      'boolCertificated': boolCertificated,
      'postCount': postCount,
      'replCount': replCount,
    };
  }
}
