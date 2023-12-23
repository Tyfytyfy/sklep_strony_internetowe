import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:sklep_strony_internetowe/src/models/customer.dart';
import 'package:sklep_strony_internetowe/src/models/new_products.dart';
import 'package:sklep_strony_internetowe/src/models/offer.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  // get image

  Future<String> getImageUrl(String imageName) async {
    try {
      Reference ref = FirebaseStorage.instance.ref().child(imageName);
      String url = await ref.getDownloadURL();
      print("URL do obrazu: $url");
      return url;
    } catch (e) {
      print("Błąd pobierania URL: ${e.toString()}");
      return '';
    }
  }

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
      DateTime endDate, String image) async {
    return await offerCollection.add({
      'produkt': product,
      'promocja': discount,
      'dataP': startDate,
      'dataK': endDate,
      'zdjecie': image,
    });
  }

  Future<Iterable<Offer>> _offerListFromSnapshot(QuerySnapshot snapshot) async {
    List<Offer> offers = [];

    for (var doc in snapshot.docs) {
      String imageName = doc['zdjecie'] ?? '';
      String imageUrl = await getImageUrl(imageName);

      offers.add(Offer(
        doc['produkt'] ?? '',
        (doc['promocja'] ?? 0).toDouble(),
        (doc['dataP'] as Timestamp).toDate(),
        (doc['dataK'] as Timestamp).toDate(),
        imageUrl,
      ));
    }

    return offers;
  }

  Stream<Iterable<Offer>> get offers {
    return offerCollection.snapshots().asyncMap((snapshot) async {
      return _offerListFromSnapshot(snapshot);
    });
  }

  final CollectionReference newProductsCollection =
      FirebaseFirestore.instance.collection('nowosci');

  Future updateNewProductsData(
      String product, DateTime startDate, String image) async {
    return await newProductsCollection
        .add({'produkt': product, 'dataP': startDate, 'zdjecie': image});
  }

  Future<Iterable<NewProducts>> _newProductsListFromSnapshot(
      QuerySnapshot snapshot) async {
    List<NewProducts> newProducts = [];

    for (var doc in snapshot.docs) {
      String imageName = doc['zdjecie'] ?? '';
      String imageUrl = await getImageUrl(imageName);
      newProducts.add(NewProducts(doc['produkt'] ?? '',
          (doc['dataP'] as Timestamp).toDate(), imageUrl));
    }

    return newProducts;
  }

  Stream<Iterable<NewProducts>> get newProducts {
    return newProductsCollection
        .snapshots()
        .asyncMap(_newProductsListFromSnapshot);
  }
}
