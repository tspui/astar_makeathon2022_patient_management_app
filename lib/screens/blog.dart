import 'package:astar/widgets/blogcard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({Key? key}) : super(key: key);

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final doctoremail = routeArgs['email'];

    final Stream<QuerySnapshot> patients =
    FirebaseFirestore.instance.collection('blog').snapshots();
    return Scaffold(
      body: ListView(
        children: [
          StreamBuilder<QuerySnapshot>(
              stream: patients,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text('Loading');
                }
                final data = snapshot.requireData;
                return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  physics: ScrollPhysics(),
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: data.size,
                    itemBuilder: (context, index) {
                      return BlogCard(id: snapshot.data?.docs[index].id, name: data.docs[index]['author'], date: data.docs[index]['date'], content: data.docs[index]['content'], title: data.docs[index]['title']);

                    },
                  ),
                );
              })
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){addBlog(context, doctoremail);},
    backgroundColor: Color(0xff006400),
    child: const Icon(Icons.edit),
    ),
    );
  }
}

void addBlog(BuildContext context, String? doctoremail) {

  Navigator.pushNamed(context, '/blogadd', arguments: {
    "doctoremail": doctoremail
  });
}