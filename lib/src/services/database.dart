import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sklep_strony_internetowe/src/models/customer.dart';
import 'package:sklep_strony_internetowe/src/models/new_products.dart';
import 'package:sklep_strony_internetowe/src/models/offer.dart';

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

  final CollectionReference offerCollection =
      FirebaseFirestore.instance.collection('promocje');

  Future updateOfferData(String product, double discount, DateTime startDate,
      DateTime endDate) async {
    return await offerCollection.add({
      'produkt': product,
      'promocja': discount,
      'dataP': startDate,
      'dataK': endDate,
    });
  }

  Iterable<Offer> _offerListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Offer(
        doc['produkt'] ?? '',
        (doc['promocja'] ?? 0).toDouble(),
        (doc['dataP'] as Timestamp).toDate(),
        (doc['dataK'] as Timestamp).toDate(),
      );
    }).toList();
  }

  Stream<Iterable<Offer>> get offers {
    return offerCollection.snapshots().map(_offerListFromSnapshot);
  }

  final CollectionReference newProductsCollection =
      FirebaseFirestore.instance.collection('nowosci');

  Future updateNewProductsData(
    String product,
    DateTime startDate,
  ) async {
    return await newProductsCollection.add({
      'produkt': product,
      'dataP': startDate,
    });
  }

  Iterable<NewProducts> _newProductsListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return NewProducts(
          doc['produkt'] ?? '', (doc['dataP'] as Timestamp).toDate());
    }).toList();
  }

  Stream<Iterable<NewProducts>> get newProducts {
    return newProductsCollection.snapshots().map(_newProductsListFromSnapshot);
  }
}
