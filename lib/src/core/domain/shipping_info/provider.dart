import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skincare_app/src/core/domain/shipping_info/shipping_info.dart';

final shippingInfoProvider =
    NotifierProvider<ShippingTools, List<ShippingInfo>>(ShippingTools.new);


