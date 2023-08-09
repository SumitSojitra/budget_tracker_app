import 'dart:typed_data';

import 'package:budget_tracker_app/models/budgetModel.dart';
import 'package:budget_tracker_app/views/Globals/globals.dart';
import 'package:budget_tracker_app/views/components/helper/Helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  TextEditingController categoryNameController = TextEditingController();

  ByteData? byteImg;
  int? select;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Page 1"),
        actions: [
          IconButton(
              onPressed: () async {
                Uint8List categoryimg =
                    Uint8List.fromList(byteImg!.buffer.asUint8List());

                BudgetModel model = BudgetModel(
                    category_image: categoryimg,
                    category_name: categoryNameController.text);

                int? res = await DbHelper.dbHelper.addCategory(model: model);

                if (res! >= 1) {
                  Get.snackbar("Budget Tracker App",
                      "Data is Successfully added at $res");
                } else {
                  Get.snackbar("Budget Tracker App", "Data is add failer");
                }
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: TextFormField(
                controller: categoryNameController,
                decoration: InputDecoration(
                  hintText: "Enter Category",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            Expanded(
                flex: 9,
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                    ),
                    itemCount: Globals.allImages.length,
                    itemBuilder: (context, i) => GestureDetector(
                      onTap: (){
                        setState(() async{
                          byteImg = await rootBundle.load(Globals.allImages[i]);
                          select = i;
                        });
                      },
                      child: Container(
                            height: 200,
                            decoration: BoxDecoration(border: Border.all(width: 2,color:(select==i)?Colors.red:Colors.transparent),
                                image: DecorationImage(
                                    image: AssetImage(Globals.allImages[i]),
                                    fit: BoxFit.cover)),
                          ),
                    )))
          ],
        ),
      ),
    );
  }
}
