import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sklep_strony_internetowe/src/models/customer.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  //collection reference

  final CollectionReference customerCollection =
      FirebaseFirestore.instance.collection('customers');

  Future updateUserData(String? email, String uid) async {
    return await customerCollection.add({'email': email, 'uid': uid});
  }

  // customers list from snapshot
  Iterable<Customer> _customerListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Customer(email: doc.get('email') ?? '');
    }).toList();
  }

  // Get customers stream
  Stream<Iterable<Customer>> get customers {
    return customerCollection.snapshots().map(_customerListFromSnapshot);
  }
}
