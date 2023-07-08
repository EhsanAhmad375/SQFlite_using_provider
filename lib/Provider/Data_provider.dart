import '../View/Home.dart';
import '../SQL/DBHelper.dart';
import '../Model/DateModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';


class DataProvider with ChangeNotifier {
// late  DBHelper dbHelper;
TextEditingController emailController=TextEditingController();
TextEditingController passwordController=TextEditingController();
  final dbHelper=DBHelper();
  List<DataModel> _datalist = [];

  List<DataModel> get datalist => _datalist;


  Future<void> registerData(DataModel dataModel) async {
    await dbHelper.register(dataModel);
    fetchData(); // Fetch updated data
  }

  Future<List<DataModel>> fetchData() async {
    _datalist = await dbHelper.getDataList();
    notifyListeners();
    return _datalist;
  }

Future<void> deleteData(int id) async {
  await dbHelper.deleteData(id);
  fetchData(); // Fetch updated data
}




// Now LoggedIn using email and password
  bool loggedIn = false;

  Future<void> login(String username, String password ,BuildContext context) async {
    final dbHelper = DBHelper();
    final loggedIn = await dbHelper.checkLogin(username, password);

    if (loggedIn) {
      
      this.loggedIn = true;
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Home(email: emailController.text)));
      notifyListeners();
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Login Failed'),
          content: Text('Invalid email or password.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }
Future<List<DataModel>> getDataByEmail(String email) async {
    List<DataModel> result = await dbHelper.getDataByEmail(email);
    return result;
  }
}

