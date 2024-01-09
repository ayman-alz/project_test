import 'package:flutter/material.dart';
import 'package:project_test/Model/note.dart';
import 'package:project_test/components/cards.dart';
import 'package:project_test/components/crud.dart';
import 'package:project_test/constants/linksApi.dart';
import 'package:project_test/main.dart';

import '../notes/edit.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Crud _crud = Crud();

  getNote() async {
    var response = await _crud.postRequest(linkViewNote, {
      "id": sharedPref.getString("id") ,
    });


    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  Text("Home"),
      actions: [
        IconButton(onPressed: () {
          sharedPref.clear();
          Navigator.of(context).pushNamedAndRemoveUntil("login", (route) => false);
        }, icon: const Icon(Icons.exit_to_app))
      ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("addnote");
        },
        child:  Icon(Icons.add) ,
      ),
      body: Container(
        padding:  EdgeInsets.all(10),
        child: ListView(
          children: [
            FutureBuilder(
              future: getNote(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data['status'] == 'success') {
                    return ListView.builder(
                      itemCount: snapshot.data['data'].length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, i) {
                        return Cards(
                          onDelete: () async {
                          var response = await _crud.postRequest (linkDeleteNote , {
                            "id" : snapshot.data['data'][i]['note_id'].toString(),
                            "imagename" : snapshot.data['data'][i]['note_image'].toString()
                          }) ;
                          setState(() {

                          });

                          if (response['status']== ['success'] ) {
                            Navigator.of(context).pushReplacementNamed("home");
                          }


                          } ,
                          ontap: () {
                            Navigator.of(context).push(MaterialPageRoute(builder:
                                (context) => EditNote(notes:snapshot.data['data'][i] ,) ));
                          },
                          noteModel : NoteModel.fromJson(snapshot.data['data'][i]), title: '', content: '',

                        );
                      },
                    );
                  } else {
                    return Center(
                      child: Text(
                        "There are no photos",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    );
                  }
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: Text("Loading..."));
                }

                return Center(child: Text("Loading..."));
              },
            ),
          ],
        ),
      ),
    );
  }
}
