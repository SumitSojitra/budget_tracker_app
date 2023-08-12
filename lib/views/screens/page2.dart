import 'package:budget_tracker_app/models/budgetModel.dart';
import 'package:budget_tracker_app/views/components/helper/Helper.dart';
import 'package:flutter/material.dart';

class Page2 extends StatefulWidget {
  const Page2({super.key});

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {

   late Future<List<BudgetModel>>? getdata;


  @override
  void initState() {
    super.initState();

    getdata =  DbHelper.dbHelper.FetchAllCategory();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Read All Category..."),centerTitle: true,),
      body: FutureBuilder(
        future: getdata,
        builder: (context, snapshot) {
          if(snapshot.hasError){
            return Center(child: Text("${snapshot.error}"));
          }else if(snapshot.hasData){
            if(snapshot.data!.isEmpty){
              return Center(
                child: CircularProgressIndicator(),
              );
            }else{
             List<BudgetModel>? data =  snapshot.data;
              return ListView.builder(itemCount: data!.length,itemBuilder: (context, index) =>ListTile(leading: CircleAvatar(foregroundImage: AssetImage("${data[index].category_image}")),title: Text(data[index].category_name),subtitle: Text("${data[index].id}"),trailing: IconButton(icon: Icon(Icons.delete,),onPressed: (){},),) ,);
            }
          }
          return Center(
            child: CircularProgressIndicator(),
          );

        },
      ),
    );
  }
}
