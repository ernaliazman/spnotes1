
import 'package:projectapp/models/event_info.dart';
import 'package:projectapp/resources/color.dart';
import 'package:projectapp/screens/create_screen.dart';
import 'package:projectapp/screens/edit_screen.dart';
import 'package:projectapp/utils/storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


import '../authenticate/google_signin.dart';
import '../file/file_screen.dart';
import '../file/student_lists.dart';
import '../file/view_screen_supervisors.dart';
import '../login/login.dart';
import 'create_screen.dart';
import 'edit_screen.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Storage storage = Storage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.red,
        iconTheme: IconThemeData(
          color: Colors.grey, //change your color here
        ),
        title: Text(
          'Supervisor Dashboard',
          style: TextStyle(
            color: CustomColor.white,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.face),
            onPressed: (){
              Navigator.push(context,MaterialPageRoute(builder:(context) => StudentList()),);
            },
            
            ),
          IconButton(
            icon: Icon(Icons.drive_folder_upload),
            onPressed: (){
              Navigator.push(context,MaterialPageRoute(builder:(context) => FileScreen()),);
            },
            
            ),
             IconButton(
            icon: Icon(Icons.cloud),
            onPressed: (){
              Navigator.push(context,MaterialPageRoute(builder:(context) => ViewScreenSupervisor()),);
            },
            
            ),
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              signOut();
               Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => Login(),
                              ),
                            );
            })
        ],
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: CustomColor.red,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CreateScreen(),
            ),
          );
        },
      ),

      body: Padding(
        padding: const EdgeInsets.only(
          left: 16.0,
          right: 16.0,
        ),
        child: Container(
          padding: EdgeInsets.only(top: 8.0),
          color: Colors.white,
    
          child: StreamBuilder(
            stream: storage.retrieveEvents(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.docs.length > 0) {
                  return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> eventInfo = snapshot.data.docs[index].data();

                      EventInfo event = EventInfo.fromMap(eventInfo);

                      DateTime startTime = DateTime.fromMillisecondsSinceEpoch(event.startTimeInEpoch);
                      DateTime endTime = DateTime.fromMillisecondsSinceEpoch(event.endTimeInEpoch);

                      String startTimeString = DateFormat.jm().format(startTime);
                      String endTimeString = DateFormat.jm().format(endTime);
                      String dateString = DateFormat.yMMMMd().format(startTime);

                      return Padding(
                        padding: EdgeInsets.only(bottom: 16.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => EditScreen(event: event),
                              ),
                            );
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                  bottom: 16.0,
                                  top: 16.0,
                                  left: 16.0,
                                  right: 16.0,
                                ),
                                decoration: BoxDecoration(
                                  color: CustomColor.white_red.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      event.name,
                                      style: TextStyle(
                                        color: CustomColor.red,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      event.description,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.black38,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                                      child: Text(
                                        event.link,
                                        style: TextStyle(
                                          color: CustomColor.dark_blue.withOpacity(0.5),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 50,
                                          width: 5,
                                          color: CustomColor.white_red,
                                        ),
                                        SizedBox(width: 10),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              dateString,
                                              style: TextStyle(
                                                color: CustomColor.red,
                                                fontFamily: 'OpenSans',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                letterSpacing: 1.5,
                                              ),
                                            ),
                                            Text(
                                              '$startTimeString - $endTimeString',
                                              style: TextStyle(
                                                color: CustomColor.red,
                                                fontFamily: 'OpenSans',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                letterSpacing: 1.5,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 22),
                              // Row(
                              //   children: [
                              //     Container(
                              //         child: ElevatedButton.icon(
                              //           icon: const Icon(Icons.drive_folder_upload),
                              //           onPressed: ()  {
                              //             Navigator.push(
                              //               context,
                              //               MaterialPageRoute(builder: (context) =>  FileScreen()),
                              //             );
                              //           },
                              //           label: Text("Upload File",
                              //             style: TextStyle(color: Colors.white),
                              //           ),

                              //         ),
                              //     ),
                              //     SizedBox(width: 130),
                              //     Container(
                              //       alignment: Alignment.centerRight,
                              //       child: ElevatedButton.icon(
                              //         icon: const Icon(Icons.cloud),
                              //         onPressed: ()  {
                              //           Navigator.push(
                              //             context,
                              //             MaterialPageRoute(builder: (context) =>  ViewScreen()),
                              //           );
                              //         },
                              //         label: Text("View File",
                              //         style: TextStyle(color: Colors.white),
                              //       ),

                              //       ),
                              //     ),
                              //   ],
                              // ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Column(
                    children: [
                      Center(
                        child: Text(
                          'No Events',
                          style: TextStyle(
                            color: Colors.black38,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                      SizedBox(height: 22),
                      // Row(
                      //   children: [
                      //     Container(
                      //       child: ElevatedButton.icon(
                      //         icon: const Icon(Icons.drive_folder_upload),
                      //         onPressed: ()  {
                      //           Navigator.push(
                      //             context,
                      //             MaterialPageRoute(builder: (context) =>  FileScreen()),
                      //           );
                      //         },
                      //         label: Text("Upload File",
                      //           style: TextStyle(color: Colors.white),
                      //         ),

                      //       ),
                      //     ),
                      //     SizedBox(width: 110),
                      //     Container(
                      //       alignment: Alignment.centerRight,
                      //       child: ElevatedButton.icon(
                      //         icon: const Icon(Icons.cloud),
                      //         onPressed: ()  {
                      //           Navigator.push(
                      //             context,
                      //             MaterialPageRoute(builder: (context) =>  ViewScreen()),
                      //           );
                      //         },
                      //         label: Text("View File",
                      //           style: TextStyle(color: Colors.white),
                      //         ),

                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ],
                  );
                }
              }
              return Column(
                children: [
                  CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(CustomColor.sea_blue),
                  ),

                ],
              );
            },
          ),
        ),
      ),
    );
  }
}