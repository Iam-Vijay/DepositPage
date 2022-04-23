import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'api_utils.dart';
import 'DataClass.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
 
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}



class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}



class _MyHomePageState extends State<MyHomePage> {
  String dropdownvalue = 'Item 1';

  api_utils apiutils = new api_utils();
  List<Deposit>? items = [];
  bool loading = false;
  Deposit? countries;

  @override
  void initState() {
    super.initState();
   getSpinner();
  }
  void getSpinner(){
    apiutils.getSpinner("1").then((DataClass dataClass){
      print(dataClass.username);
      setState(() {
        items = [];
        items = dataClass.deposit!;
        print(items?.length);
        loading = true;
      });

    });
  }
  @override
  Widget build(BuildContext context) {
    String dropdownvalue = 'Item 1';

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
   ;
    return Material(

      child: SafeArea(

        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
               Card(
                      shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0)),
                        child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,

                    children: <Widget>[

                      Expanded(child: Icon(Icons.menu ,color: Colors.blue,size: 40,),flex: 1,),
                      Expanded(
                        flex: 10,
                        child: Center(
                          child: Image.asset("assets/images/splash.png",height: 40,alignment: Alignment.center)
                        ),
                      )
                    ],
                  ),
                ),


              Row(
               
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:[
                  Text("Deposit",style: TextStyle(fontSize: 25,color: Colors.black,fontWeight: FontWeight.bold),),
                  loading ?
                  dropdownitem():Text("data"),
                ],
              ),

            ],

          ),
        ),
      ),
    );
  }


  Widget dropdownitem(){

    // List of items in our dropdown menu
    return DropdownButtonHideUnderline(
    child:
       DropdownButton(
        items: items!
            .map((value) => DropdownMenuItem(
          child: Container(
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(
                    Radius.circular(5.0),
                  )),
              width: 80,
              height: 45,
              alignment: Alignment.center,

              child: Text(value.currencySymbol!,style: TextStyle(fontSize: 16,color: Colors.white))
          ),
          value: value,
        ))
            .toList(),
        value: countries,
         icon: Visibility (visible:false, child: Icon(Icons.arrow_downward)),
         onChanged: (Deposit? value) {
                setState(() {
                   countries = value!;
                });
         },
      )
    );

  }
}
