import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projectapp/models/event_info.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:projectapp/models/file.dart';

final CollectionReference mainCollection = FirebaseFirestore.instance.collection('event');
final DocumentReference documentReference = mainCollection.doc('test');
final FirebaseStorage storage = FirebaseStorage.instance.ref('files') as FirebaseStorage;

class Storage {
  Future<void> storeEventData(EventInfo eventInfo) async {
    DocumentReference documentReferencer = documentReference.collection('events').doc(eventInfo.id);

    Map<String, dynamic> data = eventInfo.toJson();

    print('DATA:\n$data');

    await documentReferencer.set(data).whenComplete(() {
      print("Event added to the database, id: {${eventInfo.id}}");
    }).catchError((e) => print(e));
  }

  Future<void> updateEventData(EventInfo eventInfo) async {
    DocumentReference documentReferencer = documentReference.collection('events').doc(eventInfo.id);

    Map<String, dynamic> data = eventInfo.toJson();

    print('DATA:\n$data');

    await documentReferencer.update(data).whenComplete(() {
      print("Event updated in the database, id: {${eventInfo.id}}");
    }).catchError((e) => print(e));
  }

  Future<void> deleteEvent({required String id}) async {
    DocumentReference documentReferencer = documentReference.collection('events').doc(id);

    await documentReferencer.delete().catchError((e) => print(e));

    print('Event deleted, id: $id');
  }

  Future<void> delete(File file) async {
    try {
      await FirebaseStorage.instance.ref('file');
    } catch (e) {
      print(e);
    }
  }

  Stream<QuerySnapshot> retrieveEvents() {
    Stream<QuerySnapshot> myClasses = documentReference.collection('events').orderBy('start').snapshots();

    return myClasses;
  }

   Future<QuerySnapshot<Map<String, dynamic>>> retrieveEventStudents(String email) async {

    QuerySnapshot<Map<String, dynamic>> myClasses = await documentReference.collection('events').orderBy('start').where('emails',arrayContains: email).get();
    print(myClasses.docs.length);
    return myClasses;
  }

  static UploadTask? uploadFile(String destination, File file){
    try{
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putFile(file);
    }on FirebaseException catch (e){
      return null;
    }
  }

  static Future<void> deleteFile(Files file) async{
    if(file.ref !=null){
      final ref = FirebaseStorage.instance.ref('file');


      ref.delete().whenComplete(() => print("Deleted"));
    }

  }

  static Future<List<String>> _getDownloadLinks(List<Reference> refs) =>
  Future.wait(refs.map((ref) => ref.getDownloadURL()).toList());

  static Future<List<Files>> listAll(String path) async{
    final ref = FirebaseStorage.instance.ref(path);
    final result= await ref.listAll();

    final urls = await _getDownloadLinks(result.items);

    return urls
    .asMap()
        .map((index, url){
          final ref = result.items[index];
          final name = ref.name;
          final file = Files(ref: ref, name: name, url: url);

          return MapEntry(index, file);
    })
        .values
        .toList();

  }

}

 


  // Future<QuerySnapshot<Map<String, dynamic>>> validate (String email) async {

  //   QuerySnapshot<Map<String, dynamic>> myClasses = await documentReference.collection('lists').orderBy('start').where('emails',arrayContains: email).get();
  //   print(myClasses.docs.length);
  //   validateRole(myClasses);
  //   // return myClasses;
  // }

