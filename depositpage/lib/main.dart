import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
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
  List<DepositHistory> deposithistory = [];
  bool loading = false;
  Deposit? countries;
  String avilablebalane="25.152";
  String overallbalance= "120.154";
  String cryptoaddress = "";
  Color mycolor = Colors.red;

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
        deposithistory = [];
        deposithistory = dataClass.depositHistory!;
        items = dataClass.deposit!;
        print(items?.length);
        loading = true;
      });

    });
  }
  @override
  Widget build(BuildContext context) {

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    return Scaffold(
      appBar:AppBar( backgroundColor: Colors.white,title:
                         Center(
                            child: Image.asset("assets/images/splash.png",height: 40,alignment: Alignment.center)
                          ),
        iconTheme: IconThemeData(color: Colors.black),

      ),



      drawer: Drawer(
        elevation: 20.0,
        child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountName: Text("javatpoint"),
                  accountEmail: Text("javatpoint@gmail.com"),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.yellow,
                    child: Text("abc"),
                  ),
                ),
                ListTile(
                  title: new Text("Inbox"),
                  leading: new Icon(Icons.mail),
                ),
                Divider( height: 0.1,),
                ListTile(
                  title: new Text("Primary"),
                  leading: new Icon(Icons.inbox),
                ),
                ListTile(
                  title: new Text("Social"),
                  leading: new Icon(Icons.people),
                ),
                ListTile(
                  title: new Text("Promotions"),
                  leading: new Icon(Icons.local_offer),
                )
              ],
            ),
          ),
        ),

      body: Container(
        height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(10),
              child: loading ?  SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Row(

                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:[
                        Text("Deposit",style: TextStyle(fontSize: 25,color: Colors.black,fontWeight: FontWeight.bold),),
                          dropdownitem(),
                      ],
                    ),
                    SizedBox(height: 10),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(overallbalance,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                        Text(avilablebalane,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold))
                      ],
                    ),

                    SizedBox(height: 10),

                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Text("Total Balance"),
                         Text("Avilable Balance")
                       ],
                     ),
                    SizedBox(height: 20),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(40.0),
                            bottomRight: Radius.circular(40.0),
                            topLeft: Radius.circular(40.0),
                            bottomLeft: Radius.circular(40.0)),
                      ),
                      child: Container(
           padding: EdgeInsets.all(5),
                        child:Row(
                          
                          children: [
                            Expanded(
                              flex: 10,
                              child: Center(widthFactor: 1,
                                child: Text(cryptoaddress,style: TextStyle(color: Colors.black),)
                      ),
                            ),
                            Expanded(flex: 1,child: Icon(Icons.copy))
                          ],
                        )
                        ,)

                    ),

                     Container
                       (alignment: Alignment.center,width: 200,height: 200,child:CachedNetworkImage(
                     imageUrl: dropdownvalue,
                     placeholder: (context, url) => CircularProgressIndicator(),
                     errorWidget: (context, url, error) => Icon(Icons.error),
                   ),

                     )
                    
                    ,

                    Container(
                      width: MediaQuery.of(context).size.width,
                      child:  Text("Deposit History",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),) ,
                    ),

                    Container(
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, position) {
                            bool iscolor = false;
                            if(deposithistory[position].status == "Completed"){
                              iscolor= true;
                            }
                          return HistoryCard(deposithistory[position],iscolor);
                        },
                        itemCount: deposithistory.length,
                      )
                    ),


                  ],

                ),
              ) : _fetchData(context)

      ),
    );
    
  }

  Widget HistoryCard(DepositHistory depositHistory, bool iscolor){
    return Card(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 60,
          child: Row(
            children: [
              Expanded(child:Image.network(depositHistory.currencyImage!,height: 40,width: 40,),flex: 0, ),
              Expanded(flex: 2,child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 5,),
                  Text(depositHistory.amount!,style: TextStyle(fontSize: 12),),
                  SizedBox(height: 5,),
                  Text(depositHistory.currencySymbol!,style: TextStyle(fontSize: 12),)
                ],
              ),

              ),
              SizedBox(width: 5,),
              Expanded(child: Container(
                height: 30,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: iscolor ? Colors.green : Colors.red,
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40.0),
                      bottomRight: Radius.circular(40.0),
                      topLeft: Radius.circular(40.0),
                      bottomLeft: Radius.circular(40.0)),
                ),
                child: Center(child: Text(depositHistory.status!,style: TextStyle(color: Colors.white),)),
              ) ,flex: 2,),
              Expanded(child: Center(child:Text(depositHistory.datetime!,style: TextStyle(fontSize: 12),),),flex: 3,)
            ],
          ),
        ),
    );
  }

  Widget _fetchData(BuildContext context)  {
    // show the loading dialog
          return Dialog(
            // The background color
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  // The loading indicator
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 15,
                  ),
                  // Some text
                  Text('Loading...')
                ],
              ),
            ),
          );
        }


  Widget dropdownitem(){

    // List of items in our dropdown menu
    return DropdownButtonHideUnderline(
    child:
       DropdownButton(
         hint: Container(
             decoration: BoxDecoration(
                 color: Colors.blue,
                 borderRadius: BorderRadius.all(
                   Radius.circular(5.0),
                 )),
             width: 80,
             height: 45,
             alignment: Alignment.center,

             child: Text("Select Item",style: TextStyle(fontSize: 12,color: Colors.white))
         ),
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
                   print(value.qrcode);
                   dropdownvalue = value.qrcode!;
                   cryptoaddress = value.cryptoAddress!;
                });
         },
      )
    );

  }
}
