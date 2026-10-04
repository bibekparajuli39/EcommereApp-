import 'package:nana/features/address/model/address_model.dart';

abstract class AddressEvent {}

class LoadAddresses extends AddressEvent {}

class AddAddress extends AddressEvent {
  final AddressModel address;

  AddAddress(this.address);
}

class DeleteAddress extends AddressEvent {
  final String addressId;

  DeleteAddress(this.addressId);
}

class SetDefaultAddress extends AddressEvent {
  final String addressId;

  SetDefaultAddress(this.addressId);
}

class UpdateAddress extends AddressEvent {
  final AddressModel address;

  UpdateAddress(this.address);
}
