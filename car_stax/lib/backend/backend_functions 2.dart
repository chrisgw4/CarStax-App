import 'dart:ffi';
import 'dart:io';

import 'package:car_stax/backend/uris.dart';
import 'package:car_stax/main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
// import 'package:car_stax/auth/auth.dart';


// Parse cookie
Cookie parsedCookie = Cookie("","");
String? sessionCookie;


Future<http.Response> backend_logout(cookie) async {

  final response = await http.post(
      logout_uri,
      headers: {
        'Content-Type': 'application/json',
        if (cookie != null) 'Cookie':cookie,
      },
  );

  return response;
}


// Will login a user with checking from the backend
Future<http.Response> backend_login(String email, String password) async {
  Map<String, String> dataToSend = {
    "email":email,
    "password":password
  };

  String jsonPayload = jsonEncode(dataToSend);

  final response = await http.post(
      login_uri,
      body: jsonPayload,
      headers: {'Content-Type': 'application/json'}
  );


  if (response.statusCode == 200) {
    // Get the cookie
    sessionCookie = response.headers['set-cookie'];

    // Parse cookie
    parsedCookie = Cookie.fromSetCookieValue(sessionCookie!);

    print(parsedCookie);
  }


  print(jsonDecode(response.body));

  return response;
  return jsonDecode(response.body);
}



// Will register a user in the backend using the signup api
Future<Map<String, dynamic>> backend_register({required String email, required String password,
  required String companyName, required String firstName,
  required String lastName, required String userType}) async {

  Map<String, String> dataToSend = {
    "email":email,
    "password":password,
    "companyName":companyName,
    "firstName":firstName,
    "lastName":lastName,
    "userType":userType,
  };

  String jsonPayload = jsonEncode(dataToSend);

  final response = await http.post(
      register_uri,
      body: jsonPayload,
      headers: {'Content-Type': 'application/json'}
  );

  print(response.body);

  print("Registering");

  print(response.statusCode);

  return jsonDecode(response.body);

}


void backend_forgot_password({required String email}) {
  Map<String, String> dataToSend = {"email":email};

  String jsonPayload = jsonEncode(dataToSend);

  print("Do forgot password logic");
}



Future<Map<String, dynamic>> backend_add_car({
  required String lPlate, required String rentalStatus,
  required String currentRental, required int year,
  required String color, required String make,
  required String model, required int mileage,
  required String repairStatus, required var warningLightIndicators,
  required String VIN, required String carType
  }) async {

  Map dataToSend = {
    "licensePlate":lPlate, "rentalStatus":rentalStatus.toLowerCase(),
    "currentRental":currentRental, "year":year,
    "color":color, "make":make, "model":model,
    "mileage":mileage, "repairStatus":repairStatus,
    "warningLightIndicators":warningLightIndicators,
    "vehicleIdentificationNumber":VIN, "carType":carType.toLowerCase()
  };


  String jsonPayload = jsonEncode(dataToSend);
  final response = await http.post(
      add_car_uri,
      body: jsonPayload,
      headers: {
        'Authorization': 'Bearer ' + parsedCookie.value, // Cookie value for Car apis
        'Content-Type': 'application/json',
      }
  );

  print("Add Car Function");
  print(response.body);
  return jsonDecode(response.body);
}


void backend_delete_car({
  required String carId
}) async {


  Map dataToSend = {
    "id":carId,
  };

  // New Link needs to be
  // farrukhanwar.site/apis/Car/carId
  // Uri.parse(delete_car_uri.origin + delete_car_uri.path + carId),

  String jsonPayload = jsonEncode(dataToSend);

  final response = await http.delete(
      Uri.parse(delete_car_uri.origin + delete_car_uri.path + carId),
      body: jsonPayload,
      headers: {
        'Authorization': 'Bearer ' + parsedCookie.value,
        // Cookie value for Car apis
        'Content-Type': 'application/json',
      }
  );

  print("Delete Car Function");
  print(response.body);
}



void backend_edit_car({
  required String lPlate, required String rentalStatus,
  required String currentRental, required int year,
  required String color, required String make,
  required String model, required int mileage,
  required String repairStatus, required var warningLightIndicators,
  required String VIN, required String carType,
  required String carId
}) async {


  Map dataToSend = {
    "licensePlate":lPlate,
    "rentalStatus":rentalStatus.toLowerCase(),
    "year":year,
    "color":color,
    "make":make,
    "model":model,
    "mileage":mileage,
    "repairStatus":repairStatus,
    "warningLightIndicators":warningLightIndicators,
    "vehicleIdentificationNumber":VIN,
    "carType":carType.toLowerCase()
  };

  // New Link needs to be
  // farrukhanwar.site/apis/Car/carId
  // Uri.parse(delete_car_uri.origin + edit_car_uri.path + carId),

  String jsonPayload = jsonEncode(dataToSend);

  final response = await http.patch(
      Uri.parse(delete_car_uri.origin + edit_car_uri.path + carId),
      body: jsonPayload,
      headers: {
        'Authorization': 'Bearer ' + parsedCookie.value,
        // Cookie value for Car apis
        'Content-Type': 'application/json',
      }
  );

  print("Edit Car Function");
  print(response.body);
}


Future<Map> backend_get_cars() async {

  // New Link needs to be
  // farrukhanwar.site/apis/Car/carId
  // Uri.parse(delete_car_uri.origin + edit_car_uri.path + carId),


  final response = await http.get(
      get_cars_uri,
      headers: {
        'Authorization': 'Bearer ' + parsedCookie.value,
        // Cookie value for Car apis
        'Content-Type': 'application/json',
      }
  );

  // print("Get Cars Function");
  // print(response.body);
  return jsonDecode(response.body);
}