class ShippingInfo {
  late final int? id;
  final String? name;
  final int? phoneNumber;
  final String? streetAddress;
  final int? houseNo;
  final int? postcode;

  ShippingInfo({
    this.id,
    this.name,
    this.phoneNumber,
    this.streetAddress,
    this.houseNo,
    this.postcode,
  });

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'streetAddress': streetAddress,
      'houseNo': houseNo,
      'postcode': postcode,
    };
  }

  @override
  String toString() {
    return 'ShippingInfo{id: $id, name:$name, phoneNumber:$phoneNumber, streetAddress: $streetAddress, houseNo: $houseNo, postcode: $postcode, }';
  }

  ShippingInfo copy({
    final int? id,
    final String? name,
    final int? phoneNumber,
    final String? streetAddress,
    final int? houseNo,
    final int? postcode,
  }) =>
      ShippingInfo(
        id: id ?? this.id,
        name: name ?? this.name,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        streetAddress: streetAddress ?? this.streetAddress,
        houseNo: houseNo ?? this.houseNo,
        postcode: postcode ?? this.postcode,
      );

  factory ShippingInfo.fromJson(Map<String, Object?> json) => ShippingInfo(
    id: json['id'] as int?,
    name: json['name'] as String?,
    phoneNumber: json['phoneNumber'] as int?,
    streetAddress: json['streetAddress'] as String?,
    houseNo: json['houseNo'] as int?,
    postcode: json['postcode'] as int?

  );
}
