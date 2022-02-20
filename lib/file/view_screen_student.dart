import 'package:flutter/material.dart';
import 'package:spnotes1/models/file.dart';
import 'package:spnotes1/utils/storage.dart';

class ViewScreenStudent extends StatefulWidget {
  @override
  _ViewScreenStudentState createState() => _ViewScreenStudentState();
}

class _ViewScreenStudentState extends State<ViewScreenStudent> {
  late Future<List<Files>> futureFiles = Storage.listAll('files/');

  @override
  void iniState(){
    super.initState();

    futureFiles = Storage.listAll('files/');
  }

  Widget buildHeader(int length)=> ListTile(
      tileColor: Colors.redAccent,
      leading: Container(
        width: 52,
        height: 52,
        child: Icon(Icons.file_copy),
      )
  );

  Widget buildFile(BuildContext context, Files fileFirebase) => ListTile(
    leading: IconButton(onPressed: () { },
        icon: Icon(Icons.file_copy)),
    title: Text(
      fileFirebase.name,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        decoration: TextDecoration.underline,
        color: Colors.redAccent,
      ),
    ),

  );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View File'),
      ),
      body: FutureBuilder<List<Files>>(
        future: futureFiles = Storage.listAll('files/'),

        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                return Center(child: Text('Some error occured!'));
              } else {
                final files = snapshot.data!;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildHeader(0),
                    const SizedBox(height: 12),
                    Expanded(
                      child: ListView.builder(
                        itemCount: files.length,
                        itemBuilder: (context, index){
                          final file = files[index];
                          return buildFile(context, file);
                        },
                      ),
                    ),
                  ],
                );

              }
          }
        },
      ),
    );
  }

}
