import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nana/features/address/bloc/address_event.dart';
import 'package:nana/features/address/bloc/address_state.dart';
import 'package:nana/features/address/repositories/address_repository.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  final AddressRepository repository;

  AddressBloc(this.repository) : super(AddressInitial()) {
    on<LoadAddresses>(_loadAddresses);
    on<AddAddress>(_addAddress);
    on<UpdateAddress>(_updateAddress);
    on<DeleteAddress>(_deleteAddress);
    on<SetDefaultAddress>(_setDefaultAddress);
  }

  Future<void> _loadAddresses(
    LoadAddresses event,
    Emitter<AddressState> emit,
  ) async {
    emit(AddressLoading());

    try {
      final addresses = await repository.getAddresses();

      emit(AddressLoaded(addresses));
    } catch (e) {
      emit(AddressError(e.toString()));
    }
  }

  Future<void> _addAddress(AddAddress event, Emitter<AddressState> emit) async {
    try {
      await repository.addAddress(event.address);

      final addresses = await repository.getAddresses();

      emit(AddressLoaded(addresses));
    } catch (e) {
      emit(AddressError(e.toString()));
    }
  }

  Future<void> _deleteAddress(
    DeleteAddress event,
    Emitter<AddressState> emit,
  ) async {
    try {
      await repository.deleteAddress(event.addressId);

      final addresses = await repository.getAddresses();

      emit(AddressLoaded(addresses));
    } catch (e) {
      emit(AddressError(e.toString()));
    }
  }

  Future<void> _setDefaultAddress(
    SetDefaultAddress event,
    Emitter<AddressState> emit,
  ) async {
    try {
      await repository.setDefaultAddress(event.addressId);

      final addresses = await repository.getAddresses();

      emit(AddressLoaded(addresses));
    } catch (e) {
      emit(AddressError(e.toString()));
    }
  }

  Future<void> _updateAddress(
    UpdateAddress event,
    Emitter<AddressState> emit,
  ) async {
    emit(AddressLoading());

    try {
      await repository.updateAddress(event.address);

      final addresses = await repository.getAddresses();

      emit(AddressLoaded(addresses));
    } catch (e) {
      emit(AddressError(e.toString()));
    }
  }
}
