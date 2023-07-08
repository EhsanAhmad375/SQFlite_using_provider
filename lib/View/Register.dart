import '../SQL/DBHelper.dart';
import '../Model/DateModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Provider/Data_provider.dart';
import '../Widget/TextFeildCustom.dart';

class Register extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    print('build');
    return Scaffold(
      appBar: AppBar(
        title: Text('Sqflite provider'),
      ),
      body: Consumer<DataProvider>(
        builder: (context, dataProvider, _) {
          return FutureBuilder<List<DataModel>>(
            future: dataProvider.fetchData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<DataModel> dataList = snapshot.data!;
                return ListView.builder(
                  itemCount: dataList.length,
                  itemBuilder: (context, index) {
                    DataModel data = dataList[index];
                    return ListTile(
                      title: Text('Name        =>${data.name} $index'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Email           =>${data.email}'),
                          Text('Password   =>${data.password}'),
                        ],
                      ),
                      leading: Text('ID  =>${data.id}'),
                      onLongPress: () {
                        int? id = data.id;
                        if (id != null) {
                          dataProvider.deleteData(id);
                        }
                      },
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => onBottomSheet(context),
        child: Icon(Icons.add),
      ),
    );
  }

  void onBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(
                  height: 16,
                ),
                TextFeildCustom(
                  textController: nameController,
                  hintText: 'Name',
                ),
                SizedBox(
                  height: 15,
                ),
                TextFeildCustom(
                  textController: ageController,
                  hintText: 'Age',
                ),
                SizedBox(
                  height: 15,
                ),
                TextFeildCustom(
                  textController: emailController,
                  hintText: 'e-mail Adress',
                ),
                SizedBox(
                  height: 15,
                ),
                TextFeildCustom(
                  textController: passwordController,
                  hintText: 'Password'),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(onPressed: () {
                      Navigator.of(context).pop();
                    }, child: Text('Cancel')),
                    ElevatedButton(
                        onPressed: () {
                          DataModel newData = DataModel(
                            name: nameController.text,
                            age: int.parse(ageController.text.toString()),
                            email: emailController.text,
                            password: passwordController.text,
                          );
                          Provider.of<DataProvider>(context, listen: false)
                              .registerData(newData);
                        
                        
                          nameController.clear();
                          ageController.clear();
                          emailController.clear();
                          passwordController.clear();
                          Navigator.of(context).pop();
                        
                        },
                        child: Text('Register Account'))
                  ],
                )
              ],
            ),
          
          );
          
        });
  }
}
