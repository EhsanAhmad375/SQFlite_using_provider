import '../Model/DateModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Provider/Data_provider.dart';

class Home extends StatelessWidget {
  final String email;

  Home({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(
      builder: (context, dataProvider, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Home"),
          ),
          body: FutureBuilder<List<DataModel>>(
            future: dataProvider.getDataByEmail(email),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData) {
                List<DataModel> dataList = snapshot.data!;
                return ListView.builder(
                  itemCount: dataList.length,
                  itemBuilder: (context, index) {
                    DataModel data = dataList[index];
                    return Column(
                      children: [
                        
                        ListTile(title: Text('Welcome to ${data.name}',style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),),
                        subtitle: Text('Email   ${data.email}'),
                        leading: Text('ID   ${data.id}'),
                        trailing: Text('Age.  ${data.age}'),
                        )
                      ],
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return Center(child: Text('No data'));
              }
            },
          ),
        );
      },
    );
  }
}
