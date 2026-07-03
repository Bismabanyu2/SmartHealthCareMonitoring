import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/health_data_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveHealthData(HealthData data) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    print("===== SAVE =====");
    print("UID = $uid");
    print(data.toMap());

    final doc = await _db
        .collection("users")
        .doc(uid)
        .collection("health_records")
        .add(data.toMap());

    print("Saved ID = ${doc.id}");
  }

  Future<HealthData?> getLatestHealthData() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    final snapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("health_records")
        .get();

    print("Jumlah data = ${snapshot.docs.length}");

    if (snapshot.docs.isEmpty) {
      print("Tidak ada data");
      return null;
    }

    for (var doc in snapshot.docs) {
      print("${doc.id} -> ${doc.data()["date"]}");
    }

    // Urutkan berdasarkan field date
    final docs = snapshot.docs.toList();

    docs.sort((a, b) {
      final da = DateTime.parse(a["date"]);
      final db = DateTime.parse(b["date"]);

      return db.compareTo(da);
    });

    print("===== HASIL SORT =====");

    for (var d in docs) {
      print("${d.id} -> ${d["date"]}");
    }

    print("TERBARU = ${docs.first.id}");

    return HealthData.fromMap(docs.first.data());
  }
}
