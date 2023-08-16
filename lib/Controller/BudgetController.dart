import 'package:get/get.dart';

import '../views/components/helper/Helper.dart';

class budgetController extends GetxController {
  int? id;

  void delete({required int val}) {
    DbHelper.dbHelper.DeleteData(id: val);
  }
}
