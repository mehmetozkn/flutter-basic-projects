import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    CollectionReference moviesRef = _firestore.collection('movies');
    TextEditingController nameController = TextEditingController();
    TextEditingController yearController = TextEditingController();
    TextEditingController ratingController = TextEditingController();
    var babaRef = moviesRef.doc('Baba');

    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text("Firestore CRUD İşlemleri"),
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '',
                style: TextStyle(fontSize: 24),
              ),
              ElevatedButton(
                onPressed: () async {
                  // Documentten veriyi çeker.
                  dynamic response = await babaRef.get();
                  var map = response.data();
                  print(map['name']);
                },
                child: Text("GET DATA"),
              ),
              ElevatedButton(
                child: Text("GET QUERYSNAPSHOT"),
                onPressed: () async {
                  // Collectiondan veriyi çeker.
                  var response = await moviesRef.get();
                  var list = response.docs;
                  print(list[1].data());
                },
              ),
              StreamBuilder<DocumentSnapshot>(
                // Documentin snapshotunu dinleme.
                // builder = Streamdan veri aktığında metodu çalıştırır.
                // stream = neyi dinlediğimizin bilgisi, hangi streami.
                stream: babaRef.snapshots(),
                builder: (BuildContext context, AsyncSnapshot asynSnap) {
                  return Text(
                    "${asynSnap.data.data()}",
                    style: (TextStyle(fontSize: 20)),
                  );
                },
              ),
              SizedBox(
                height: 40,
              ),
              StreamBuilder<QuerySnapshot>(
                // Collectionun snapshotunu dinleme.
                // builder = Streamdan veri aktığında metodu çalıştırır.
                // stream = neyi dinlediğimizin bilgisi, hangi streami.
                stream: moviesRef.snapshots(),
                builder: (BuildContext context, AsyncSnapshot asynSnap) {
                  if (asynSnap.hasError) {
                    return Center(
                      child: Text("Bir Hata Oluştu."),
                    );
                  } else {
                    if (asynSnap.hasData) {
                      List<DocumentSnapshot> listOfDocSnapshot =
                          asynSnap.data.docs;
                      return Flexible(
                        child: ListView.builder(
                          itemCount: listOfDocSnapshot.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: ListTile(
                                title: Text(
                                  "${(listOfDocSnapshot[index].data() as Map)['name']}",
                                  style: (TextStyle(fontSize: 20)),
                                ),
                                subtitle: Text(
                                  "${(listOfDocSnapshot[index].data() as Map)['year']}",
                                  style: (TextStyle(fontSize: 15)),
                                ),
                                trailing: IconButton(
                                  onPressed: () async {
                                    // veri silme
                                    await listOfDocSnapshot[index]
                                        .reference
                                        .delete();
                                  },
                                  icon: Icon(Icons.delete),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 110.0),
                child: Form(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: nameController,
                        decoration:
                            InputDecoration(hintText: 'Film Adını Giriniz'),
                      ),
                      TextFormField(
                        controller: yearController,
                        decoration:
                            InputDecoration(hintText: 'Film Yılını Giriniz'),
                      ),
                      TextFormField(
                        controller: ratingController,
                        decoration: InputDecoration(
                            hintText: 'Film Reytingini  Giriniz'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Text('Add'),
        onPressed: () async {
          print(nameController.text);
          //Text alanlarındaki verilerden bir map oluşturulması.
          Map<String, dynamic> movieData = {
            'name': nameController.text,
            'year': yearController.text,
            'rating': ratingController.text,
          };
          // veriyi yazmak istenilen referansa ulaşıp ilgili metodu çağırılması
          // id ile name aynı kabul ettik !
          await moviesRef.doc(yearController.text).set(movieData);
        },
      ),
    );
  }
}
