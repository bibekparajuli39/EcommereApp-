class AddressModel {
  final String id;
  final String fullName;
  final String phone;
  final String province;
  final String city;
  final String area;
  final String street;
  final String landmark;
  final bool isDefault;

  AddressModel({
    required this.id,
    required this.fullName,
    required this.phone,
    required this.province,
    required this.city,
    required this.area,
    required this.street,
    required this.landmark,
    required this.isDefault,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullName': fullName,
      'phone': phone,
      'province': province,
      'city': city,
      'area': area,
      'street': street,
      'landmark': landmark,
      'isDefault': isDefault,
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      id: map['id'] ?? '',
      fullName: map['fullName'] ?? '',
      phone: map['phone'] ?? '',
      province: map['province'] ?? '',
      city: map['city'] ?? '',
      area: map['area'] ?? '',
      street: map['street'] ?? '',
      landmark: map['landmark'] ?? '',
      isDefault: map['isDefault'] ?? false,
    );
  }
}
