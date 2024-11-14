import 'package:flutter/material.dart';
import 'package:untitled/Pages/user.dart';
import 'package:untitled/Pages/initialPage.dart';
import 'package:untitled/Pages/LoginPage.dart';
import 'package:untitled/Pages/ConversePage.dart';
import 'package:untitled/Pages/Client.dart';
class Client {
  final String title;
  final String IdClientC;
  final String phoneNumber; // Добавьте поле phoneNumber
  final String address;
  final String IdGadgetC; // Добавьте поле IdGadgetC
  Client({required this.title, required this.IdClientC, this.phoneNumber = "", this.address = "", required this.IdGadgetC});
}
