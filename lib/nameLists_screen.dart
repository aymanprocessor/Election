import 'package:election/helper/dbHelper.dart';
import 'package:flutter/material.dart';
import 'package:election/model/namelist_model.dart';

class NameList extends StatelessWidget {
  ElectionProvider electionProvider = new ElectionProvider();
  List<NamaListModel> lists = [
    NamaListModel("ayman1", 1),
    NamaListModel("ayman2", 1),
    NamaListModel("ayman3", 1),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("القرعة"),
        centerTitle: true,
      ),
      body: StreamBuilder<List<NamaListModel>>(
          stream: Stream.periodic(Duration(seconds: 1)).asyncMap((event) {
            return electionProvider.getAllName();
            //return lists;
          }),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (!snapshot.hasData || snapshot.data.length == 0) {
              return Center(child: Text('No Data'));
            }
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext, index) {
                  return Card(
                    child: ListTile(
                      leading: Text(
                        snapshot.data[index].id.toString(),
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      title: Text(
                        snapshot.data[index].name,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onPressed: () {},
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: Colors.green,
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  );
                });
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          electionProvider.insert(NamaListModel("ayman", 1));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
