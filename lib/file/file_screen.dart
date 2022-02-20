import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:projectapp/file/view_screen_student.dart';
import 'package:projectapp/file/view_screen_supervisors.dart';
import 'dart:io';
import 'package:projectapp/utils/storage.dart';

class FileScreen extends StatefulWidget {
  @override
  _FileScreenState createState() => _FileScreenState();
}

class _FileScreenState extends State<FileScreen> {

  var tcVisibility = false;
  UploadTask? task;
  File? file;

  @override
  Widget build(BuildContext context) {
    final fileName = file != null ? basename(file!.path): 'No file Selected';

    return Scaffold(
      appBar: AppBar(
        title: const Text('File Upload'),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () => selectFile(),
                label: const Text('Select File'),
                icon: const Icon(Icons.attach_file),
              ),
              SizedBox(height: 8),
              Text(fileName,
                style: TextStyle(fontSize: 16),
              ),
              ElevatedButton.icon(
                onPressed: () => uploadFile(),
                label: const Text('Upload File'),
                icon: const Icon(Icons.cloud_upload),
              ),
              Visibility(
                  visible: tcVisibility,
                  child: Text(
                    'SUCCESSFULLY ADDED',
                    style: TextStyle(color: Colors.green),
                  )),
            ],
          ),
        ),
      ),
    );
  }


  Future selectFile() async{
    final result =await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path!;

    setState(() => file = File(path));


  }
  Future uploadFile() async{

    if (file == null) return;
    final fileName = basename(file!.path);
    final destination ='files/$fileName';

    task = Storage.uploadFile(destination, file!);

    if (task == null) return;

    final snapshot = await task!.whenComplete(() => ViewScreenStudent());
    final urlDownload = await snapshot.ref.getDownloadURL();

    setState(() {
      tcVisibility = true;
    });
      print('Download-Link: $urlDownload');

  }
}
