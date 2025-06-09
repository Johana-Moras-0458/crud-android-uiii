import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getPeople() async {
  List people = [];
  CollectionReference collectionReferencePeople = db.collection("people");
  QuerySnapshot queryPeople = await collectionReferencePeople.get();
  for (var doc in queryPeople.docs) {
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    final person = {"name": data["name"], "uid": doc.id};
    people.add(person);
  }
  return people;
}

Future<void> addPeople(String name) async {
  await db.collection("people").add({"name": name});
}

Future<void> updatePeople(String uid, String newName) async {
  await db.collection("people").doc(uid).set({"name": newName});
}

Future<void> deletePeople(String uid) async {
  await db.collection("people").doc(uid).delete();
}

// === NUEVAS FUNCIONES PARA LA COLECCIÓN "peluches" ===

Future<List> getPeluches() async {
  List peluches = [];
  CollectionReference peluchesRef = db.collection("peluches");
  QuerySnapshot queryPeluches = await peluchesRef.get();

  for (var doc in queryPeluches.docs) {
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    final peluche = {
      "uid": doc.id,
      "id_peluche": data["id_peluche"],
      "id_proveedor": data["id_proveedor"],
      "id_sucursal": data["id_sucursal"],
      "nombre": data["nombre"],
      "color": data["color"],
      "precio": data["precio"],
      "tamaño": data["tamaño"],
      "tipo_de_tela": data["tipo_de_tela"]
    };
    peluches.add(peluche);
  }

  return peluches;
}

Future<void> addPeluche(Map<String, dynamic> pelucheData) async {
  await db.collection("peluches").add(pelucheData);
}

Future<void> updatePeluche(String uid, Map<String, dynamic> pelucheData) async {
  await db.collection("peluches").doc(uid).set(pelucheData);
}

Future<void> deletePeluche(String uid) async {
  await db.collection("peluches").doc(uid).delete();
}
