// ignore: unused_import
import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import './User.dart';


class Api {

    Future<List<User>> getData() async{
        log('is called');
        Uri url = Uri.parse('https://683ae32143bb370a86740c46.mockapi.io/Ass');
        http.Response response = await http.get(url);
        if(response.statusCode == 200){
          List<dynamic> data = jsonDecode(response.body);
          List<User> users = data.map((item) => User.fromJson(item)).toList();
          log(users.length.toString());
          return users;
        }else {
           throw Exception('Failed to load users: ${response.statusCode}');
        }
        
    }

}