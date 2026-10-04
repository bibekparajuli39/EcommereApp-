import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nana/features/address/model/address_model.dart';

class AddressRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  AddressRepository(this.firestore, this.auth);

  CollectionReference get addressCollection {
    final user = auth.currentUser;

    if (user == null) {
      throw Exception('User is not logged in');
    }

    return firestore.collection('users').doc(user.uid).collection('addresses');
  }

  Future<void> addAddress(AddressModel address) async {
    final document = addressCollection.doc();

    if (address.isDefault) {
      final existingAddresses = await addressCollection.get();

      for (final doc in existingAddresses.docs) {
        await doc.reference.update({'isDefault': false});
      }
    }

    final newAddress = AddressModel(
      id: document.id,
      fullName: address.fullName,
      phone: address.phone,
      province: address.province,
      city: address.city,
      area: address.area,
      street: address.street,
      landmark: address.landmark,
      isDefault: address.isDefault,
    );

    await document.set(newAddress.toMap());
  }

  Future<List<AddressModel>> getAddresses() async {
    final snapshot = await addressCollection.get();

    return snapshot.docs.map((doc) {
      return AddressModel.fromMap(doc.data() as Map<String, dynamic>);
    }).toList();
  }

  Future<void> deleteAddress(String addressId) async {
    await addressCollection.doc(addressId).delete();
  }

  Future<void> setDefaultAddress(String addressId) async {
    final snapshot = await addressCollection.get();

    for (final doc in snapshot.docs) {
      await doc.reference.update({'isDefault': doc.id == addressId});
    }
  }

  Future<void> updateAddress(AddressModel address) async {
    if (address.isDefault) {
      final existingAddresses = await addressCollection.get();

      for (final doc in existingAddresses.docs) {
        if (doc.id != address.id) {
          await doc.reference.update({'isDefault': false});
        }
      }
    }

    await addressCollection.doc(address.id).update(address.toMap());
  }
}
