import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateData extends StatefulWidget {
  const CreateData({Key? key}) : super(key: key);

  @override
  State<CreateData> createState() => _CreateDataState();
}

class _CreateDataState extends State<CreateData> {
  final TextEditingController _nameTextEditingController=TextEditingController();
  final TextEditingController _positionTextEditingController=TextEditingController();
  final TextEditingController _contractTextEditingController=TextEditingController();

  bool isLoading=false;

  Future<void> createUser() async {
     isLoading=true;
     setState(() {});
    final docUser=FirebaseFirestore.instance.collection('user').doc();
    final json={
      'name':_nameTextEditingController.text.trim(),
      'position':_positionTextEditingController.text.trim(),
      'contract':_contractTextEditingController.text.trim(),
    };

    await docUser.set(json);


     isLoading=false;
     setState(() {});
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Data"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child:
        Column(
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
                      createUser();
                    },
                    child: const Text("Save")
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
