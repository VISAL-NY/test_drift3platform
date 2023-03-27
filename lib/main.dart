import 'package:drift/drift.dart' as dr;
import 'package:flutter/material.dart';
import 'package:test_drift/database.dart';
import 'package:test_drift/shared.dart' as imp;



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  MyDatabase database=MyDatabase(imp.constructDb().executor);
  runApp(
    MyApp(database: database,)
  );
}

class MyApp extends StatefulWidget {
  MyDatabase database;
  MyApp({required this.database});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
    List<String> myNameList=[];
  final _controller=TextEditingController();

  @override
  void initState() { 
    super.initState();  
  }

  Future<List<String>> getdata() async{
    final result= await widget.database.select(widget.database.employee).get();
    result.forEach((element) {myNameList.add(element.name);});
    return myNameList;
  }



    Future<List<String>> limitemployee(int limit)async {
      final result= await (widget.database.select(widget.database.employee)..orderBy([(t)=>dr.OrderingTerm(expression: t.id,mode: dr.OrderingMode.desc)])..limit(limit)).get();
      result.forEach((element) {myNameList.add(element.name);});
      return myNameList;
    }




    @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 2,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width:500,
                      child: TextField(
                        controller: _controller,
                        decoration: const InputDecoration(
                          hintText: 'Enter name',
                          border: OutlineInputBorder(

                          )
                        ),
                      ),
                    ),
                    ElevatedButton(onPressed: (){
                      setState(() {
                        widget.database.into(widget.database.employee).insert(EmployeeCompanion.insert(name: _controller.text));
                        print(_controller.text);
                        myNameList.clear();
                      
                      });
                    }, child: const Text('Add Item')),
                  ],
                )
            ),
            Expanded(
              flex: 7,
                child: Container(
                  child: FutureBuilder
                  (
                    future: limitemployee(5),
                    builder:(context,snapshot){
                      if(snapshot.hasData){
                        return ListView.builder(
                          itemCount: myNameList.length,
                          itemBuilder: (context,index){
                              return ListTile(
                                title: Text(myNameList[index]),
                              );
                          }
                          );
                      }
                      return Container();
                    } ,
                  )
                )

            )


          ],
        ),
      ),
    );
  }
}
