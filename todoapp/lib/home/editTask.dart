import 'package:flutter/material.dart';
import 'package:todoapp/models/task.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todoapp/service/database.dart';


class EditTask extends StatefulWidget {
  Task task;
  EditTask({required this.task});
  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  
  @override
  Widget build(BuildContext context) {
    Task task = widget.task;
    String text = task.text;
    String title = task.title;
    final FirebaseAuth auth = FirebaseAuth.instance;
      final User? user = auth.currentUser;
      final uid = user!.uid;
    Future<void> _showDelete(){
      
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('This Task Will Be Deleted',style: TextStyle(fontWeight: FontWeight.bold),),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RaisedButton.icon(
                      color: Colors.red,
                      onPressed: ()async{
                        Navigator.pop(context);
                        Navigator.pop(context);
                        await DatabaseService(uid: user.uid).deleteTaskData(widget.task.id);
                        
                      },
                      icon: Icon(Icons.delete,color: Colors.white,),
                      label: Text("Delete",style:TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(width: 10,),
                  RaisedButton.icon(
                  color: Colors.blueGrey,
                  onPressed: (){Navigator.pop(context);},
                  icon: Icon(Icons.cancel,color: Colors.white,),
                  label: Text("Cancel",style:TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ],
          );
        },
      );
    }

    
    return Form(
      child:Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Column(
          children:<Widget> [
            SizedBox(height: 20,),
            Text(
              "Edit",
              style: TextStyle(fontSize: 26,
              color: Colors.lightBlue,
              fontWeight: FontWeight.bold),
              ),
            SizedBox(height: 20,),
            TextFormField(
              initialValue: title,
              decoration: InputDecoration(
                prefixStyle: TextStyle(fontWeight: FontWeight.bold),
                prefix: Text(
                  "Title: ",
                  style: TextStyle(fontSize:18 ,fontWeight: FontWeight.bold),
                ),
                hintText: text,
                contentPadding: EdgeInsets.all(12.0),
                ),
                onChanged: (title) => DatabaseService(uid: user.uid).updateTaskData(widget.task.id,title, widget.task.text, widget.task.uid, widget.task.checked ),
            ),
            SizedBox(height: 20,),
            TextFormField(
              initialValue: text,
              decoration: InputDecoration(
                prefixStyle: TextStyle(fontWeight: FontWeight.bold),
                prefix: Text(
                  "Text: ",
                  style: TextStyle(fontSize:18 ,fontWeight: FontWeight.bold),
                ),
                hintText: text,
                contentPadding: EdgeInsets.all(12.0),
                ),
              onChanged: (text) => DatabaseService(uid: user.uid).updateTaskData(widget.task.id,widget.task.title, text, widget.task.uid, widget.task.checked ),
            ),
            SizedBox(height: 40,),
            RaisedButton.icon(
              color: Colors.red,
              onPressed: (){
                _showDelete();
              },
              icon: Icon(Icons.delete,color: Colors.white,),
              label: Text("Delete",style:TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 10,),
              RaisedButton.icon(
              color: Colors.blueGrey,
              onPressed: (){Navigator.pop(context);},
              icon: Icon(Icons.cancel,color: Colors.white,),
              label: Text("Cancel",style:TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 10,),
            
          ],
        ),
      ),
    );
  }
}