import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nana/core/constants/theme_color.dart';
import 'package:nana/features/address/bloc/address_bloc.dart';
import 'package:nana/features/address/bloc/address_event.dart';
import 'package:nana/features/address/bloc/address_state.dart';
import 'package:nana/features/address/model/address_model.dart';

class AddAddressScreen extends StatefulWidget {
  final AddressModel? address;

  const AddAddressScreen({super.key, this.address});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final formKey = GlobalKey<FormState>();

  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();
  final provinceController = TextEditingController();
  final cityController = TextEditingController();
  final areaController = TextEditingController();
  final streetController = TextEditingController();
  final landmarkController = TextEditingController();

  bool isDefault = false;

  @override
  void initState() {
    super.initState();

    if (widget.address != null) {
      fullNameController.text = widget.address!.fullName;
      phoneController.text = widget.address!.phone;
      provinceController.text = widget.address!.province;
      cityController.text = widget.address!.city;
      areaController.text = widget.address!.area;
      streetController.text = widget.address!.street;
      landmarkController.text = widget.address!.landmark;
      isDefault = widget.address!.isDefault;
    }
  }

  @override
  void dispose() {
    fullNameController.dispose();
    phoneController.dispose();
    provinceController.dispose();
    cityController.dispose();
    areaController.dispose();
    streetController.dispose();
    landmarkController.dispose();

    super.dispose();
  }

  void saveAddress() {
    if (!formKey.currentState!.validate()) {
      return;
    }

    final address = AddressModel(
      id: widget.address?.id ?? '',
      fullName: fullNameController.text.trim(),
      phone: phoneController.text.trim(),
      province: provinceController.text.trim(),
      city: cityController.text.trim(),
      area: areaController.text.trim(),
      street: streetController.text.trim(),
      landmark: landmarkController.text.trim(),
      isDefault: isDefault,
    );

    if (widget.address == null) {
      context.read<AddressBloc>().add(AddAddress(address));
    } else {
      context.read<AddressBloc>().add(UpdateAddress(address));
    }
  }

  InputDecoration inputDecoration(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon, color: ThemeColor.primaryColor),
      filled: true,
      fillColor: Colors.grey.shade50,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: const Color.fromARGB(255, 230, 230, 230)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: const Color.fromARGB(255, 225, 225, 225)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: ThemeColor.primaryColor),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.address != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing ? 'Edit Address' : 'Add New Address',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocListener<AddressBloc, AddressState>(
        listener: (context, state) {
          if (state is AddressLoaded) {
            Navigator.pop(context);
          }

          if (state is AddressError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                TextFormField(
                  controller: fullNameController,
                  decoration: inputDecoration(
                    'Full Name',
                    Icons.person_outline,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your full name';
                    }

                    return null;
                  },
                ),

                SizedBox(height: 14),

                TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: inputDecoration(
                    'Phone Number',
                    Icons.phone_outlined,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your phone number';
                    }

                    if (value.trim().length < 10) {
                      return 'Enter a valid phone number';
                    }

                    return null;
                  },
                ),

                SizedBox(height: 14),

                TextFormField(
                  controller: provinceController,
                  decoration: inputDecoration('Province', Icons.map_outlined),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter province';
                    }

                    return null;
                  },
                ),

                SizedBox(height: 14),

                TextFormField(
                  controller: cityController,
                  decoration: inputDecoration(
                    'City',
                    Icons.location_city_outlined,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter city';
                    }

                    return null;
                  },
                ),

                SizedBox(height: 14),

                TextFormField(
                  controller: areaController,
                  decoration: inputDecoration('Area', Icons.place_outlined),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter area';
                    }

                    return null;
                  },
                ),

                SizedBox(height: 14),

                TextFormField(
                  controller: streetController,
                  decoration: inputDecoration(
                    'Street / Tole',
                    Icons.home_outlined,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter street or tole';
                    }

                    return null;
                  },
                ),

                SizedBox(height: 14),

                TextFormField(
                  controller: landmarkController,
                  decoration: inputDecoration(
                    'Landmark (Optional)',
                    Icons.flag_outlined,
                  ),
                ),

                SizedBox(height: 10),

                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: SwitchListTile(
                    value: isDefault,
                    onChanged: (value) {
                      setState(() {
                        isDefault = value;
                      });
                    },
                    activeThumbColor: ThemeColor.primaryColor,
                    title: Text(
                      'Set as default address',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      'Use this address for delivery',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),

                SizedBox(height: 25),

                BlocBuilder<AddressBloc, AddressState>(
                  builder: (context, state) {
                    final isLoading = state is AddressLoading;

                    return SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: isLoading ? null : saveAddress,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ThemeColor.primaryColor,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: isLoading
                            ? SizedBox(
                                height: 22,
                                width: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                isEditing ? 'Update Address' : 'Save Address',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
