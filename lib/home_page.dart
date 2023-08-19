import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/create_data.dart';
import 'package:flutter_practice/response.dart';
import 'bottom_sheet.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

   bool isLoading=false;

   final TextEditingController _nameTextEditingController=TextEditingController();
   final TextEditingController _positionTextEditingController=TextEditingController();
   final TextEditingController _contractTextEditingController=TextEditingController();




  Future<void> deleteData(var id)async {
    FirebaseFirestore.instance.collection('user').doc(id).delete();
  }

  Future<void> updateData(var id)async{

    final json={
      'name':_nameTextEditingController.text.trim(),
      'position':_positionTextEditingController.text.trim(),
      'contract':_contractTextEditingController.text.trim(),
    };



    isLoading=true;
    setState(() {});
    FirebaseFirestore.instance.collection('user').doc(id).update(json);
    isLoading=false;
    setState(() {});
  }






  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CRUD In FireBase'),
      ),

      body: StreamBuilder(
        stream:FirebaseFirestore.instance.collection('user').snapshots() ,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if(snapshot.connectionState==ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if(snapshot.hasError){
            return Center(
              child:Text('Error:${snapshot.error}') ,
            );
          }
          final documents = snapshot.data!.docs;

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
                itemCount: documents.length,
                itemBuilder: (context,index){
                  final doc=documents[index];
                  final name=doc['name'];
                  final position=doc['position'];
                  final contract=doc['contract'];
                  final docId = doc.id;

                  return Card(
                    child:ListTile(
                        title: Text("$name"),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10,),
                            Text("$position"),
                            SizedBox(height: 5,),
                            Text("$contract"),
                          ],
                        ),
                        trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              IconButton(onPressed: (){
                                showDialog(
                                    context: context,
                                    builder: (context){
                                      return AlertDialog(
                                        title: Text("UpDate Data"),
                                        content: Column(
                                          children: [
                                            TextFormField(
                                              controller: _nameTextEditingController,
                                              decoration: const InputDecoration(
                                                  hintText: 'Name'
                                              ),
                                            ),
                                            const SizedBox(height: 15,),
                                            TextFormField(
                                              controller: _positionTextEditingController,
                                              decoration: const InputDecoration(
                                                  hintText: 'Position'
                                              ),
                                            ),
                                            const SizedBox(height: 15,),
                                            TextFormField(
                                              controller: _contractTextEditingController,
                                              decoration: const InputDecoration(
                                                  hintText: 'Contract Number'
                                              ),
                                            ),
                                            const SizedBox(height: 15,),
                                            SizedBox(
                                              width: double.infinity,
                                              child: Visibility(
                                                visible:isLoading==false,
                                                replacement: const Center(child: CircularProgressIndicator(),),
                                                child: ElevatedButton(
                                                    onPressed: (){
                                                     updateData(docId);
                                                    },
                                                    child: const Text("Save")
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    }

                                );

                              }, icon: const Icon(Icons.edit,color: Colors.green,)),
                              SizedBox(width: 10,),
                              IconButton(onPressed: (){
                                showDialog(
                                    context: context,
                                    builder: (context){
                                      return AlertDialog(
                                        title: Text("Do You Have Delete!"),
                                        content: Text("Are You Deleted"),
                                        actions: [
                                          TextButton(
                                              onPressed: (){
                                                Navigator.of(context).pop();
                                              },
                                              child: Text("Cancel")),
                                          TextButton(
                                              onPressed: (){
                                                deleteData(docId);
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text("Ok")
                                          )
                                        ],
                                      );
                                    }
                                );




                              }, icon: Icon(Icons.delete,color: Colors.redAccent,)),
                            ])





                    ) ,
                  );
                }
            ),
          );
        },

      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>const CreateData()));
        },
        child: const Icon(Icons.add),
      ),
    );





  }





}



