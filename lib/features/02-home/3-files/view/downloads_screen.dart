import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phonoi_app/core/utils/widgets/snackbars_widgets.dart';

import '../../../../generated/l10n.dart';

class DownloadsScreen extends StatefulWidget {
  const DownloadsScreen({super.key});

  @override
  State<DownloadsScreen> createState() => _DownloadsScreenState();
}

class _DownloadsScreenState extends State<DownloadsScreen> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _usersStream =
        FirebaseFirestore.instance.collection('users').doc(user?.uid).collection("videos").snapshots();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
          ),
        ),
        title: Text(
          S.of(context).downloads,
          style: TextStyle(fontSize: 22),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () => showSnackBar(S.of(context).we_develop_it, 3, context),
                child: Container(
                  height: 87,
                  width: double.infinity,
                  decoration: BoxDecoration(color: Color(0xffCAD6FF), borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.language,
                        color: Color(0xff8C52FF),
                        size: 56,
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        S.of(context).last_website,
                        style: TextStyle(fontSize: 14, color: Color(0xff8C52FF)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 26),
            StreamBuilder<QuerySnapshot>(
              stream: _usersStream,
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Expanded(
                    flex: 6,
                    child: Column(
                      children: [
                        SizedBox(height: 26),
                        Container(
                          height: 550,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.black,
                            border: Border.all(
                              color: const Color(0xff9B9B9B),
                              width: 1,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 95,
                                height: 74,
                                child: Icon(Icons.download, size: 80),
                              ),
                              Text(
                                S.of(context).downloads_is_empty,
                                style: TextStyle(fontSize: 20),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.deepPurple,
                    ),
                  );
                }

                return Expanded(
                  flex: 6,
                  child: Center(
                    child: Container(
                        width: double.infinity,
                        child: ListView.separated(
                          itemBuilder: (context, index) {
                            Map<String, dynamic> data = snapshot.data!.docs[index].data() as Map<String, dynamic>;
                            return ListTile(
                              leading: Container(
                                width: 100,
                                height: 150,
                                child: CachedNetworkImage(imageUrl: "${data['thumbnail']}"),
                              ),
                              title: Text(data['title'] ?? "khaleel@gmail.com"),
                              subtitle: Text(data['video'] == "Video" ? S.of(context).videos : S.of(context).musics ?? "Video"),
                            );
                          },
                          itemCount: snapshot.data!.docs.length,
                          separatorBuilder: (BuildContext context, int index) => SizedBox(height: 10.0),
                        )),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
