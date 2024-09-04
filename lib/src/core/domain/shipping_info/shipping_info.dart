import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

const _uuid = Uuid();

class ShippingInfo {
 final String? id;
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
    final String? id,
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
      id: json['id'] as String?,
      name: json['name'] as String?,
      phoneNumber: json['phoneNumber'] as int?,
      streetAddress: json['streetAddress'] as String?,
      houseNo: json['houseNo'] as int?,
      postcode: json['postcode'] as int?);
}

class ShippingTools extends Notifier<List<ShippingInfo>> {
  @override
  List<ShippingInfo> build() => [];
  void addInfo(
   
    String? name,
    int? phoneNumber,
    String? houseAddress,
    int? houseNo,
    int? postcode,
  ) {
    state = [
      ShippingInfo(
        id: _uuid.v4(),
        name: name,
        phoneNumber: phoneNumber,
        streetAddress: houseAddress,
        postcode: postcode,
        houseNo: houseNo,
      )
    ];
  }

  void edit({
    String? id,
    String? name,
    int? phoneNumber,
    String? houseAddress,
    int? houseNo,
    int? postcode,
  }) {
    state = [
      for (final shippingInfo in state)
        // ignore: unrelated_type_equality_checks
        if (shippingInfo.id == int.parse(id!))
          ShippingInfo(
            id: shippingInfo.id,
            name: name,
            phoneNumber: phoneNumber,
            streetAddress: houseAddress,
            houseNo: houseNo,
            postcode: postcode,
          )
        else
          shippingInfo,
    ];
  }
}
