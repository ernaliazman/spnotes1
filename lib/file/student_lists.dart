import 'package:flutter/material.dart';
import 'package:projectapp/resources/color.dart';
import 'package:projectapp/screens/dashboard_screen.dart';

class StudentList extends StatefulWidget {
  @override
  _StudentListState createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.red,
        iconTheme: IconThemeData(
          color: Colors.grey, //change your color here
        ),
        title: Column(
          children: [
            Text(
              'Student List',
              style: TextStyle(
                color: CustomColor.white,
                fontSize: 22,
              ),
            ),
          ],
        ),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DashboardScreen()),
                  );
                },
                child: Icon(Icons.home),
              )),
        ],
      ),
      body: ListView(
          children: const <Widget>[
            Card(
              child: ListTile(
                leading: Icon(Icons.face),
                title: Text('204236/HANISAH BINTI NAZARUDIIN'),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.face),
                title: Text('203522/NUR ERNA ALIA BINTI AZMAN'),
              ),
            ),
          ]

      ),
    );
  }


}