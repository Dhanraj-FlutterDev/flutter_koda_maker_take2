import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_koda_maker_take2/states_page.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    home: TaskTwo(),
  ));
}

class TaskTwo extends StatefulWidget {
  @override
  _TaskTwoState createState() => _TaskTwoState();
}

class _TaskTwoState extends State<TaskTwo> {

  Map mapResponse;
  List listOfCountrys;

  Map data = {
    "country_id": "101",
  };


  Future<void> getCountryData() async {
    var response = await http.post(
      'http://15.207.218.57/gujaratis-online/public/api/countries',
      body: data,
    );
    if(response.statusCode == 200){
      setState(() {
        mapResponse = jsonDecode(response.body);
        listOfCountrys = mapResponse['country'];
      });
      print(mapResponse);

    }
    return print('something went wrong');
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCountryData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Country'),
      ),
      body: Center(
        child: mapResponse == null ? Container() :
            ListView.builder(
              itemCount: listOfCountrys == null ? 0 : listOfCountrys.length,
                itemBuilder: (context,index){
                return ListTile(
                  title: Text(listOfCountrys[index]['name']),
                  trailing: Icon(Icons.arrow_forward_ios_outlined),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context)=> StatePage(
                          countryName: listOfCountrys[index]['name'],
                          countryId: listOfCountrys[index]['id'],)));
                  },
                );
                }
            )
      ),
    );
  }
}
