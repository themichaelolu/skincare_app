import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:skincare_app/src/core/domain/cloud_firestore/provider.dart';

part 'cloud_firestore_controller.g.dart';

@riverpod
Future<dynamic> getDocs(GetDocsRef ref) async {
  final service = ref.read(cloudFirestoreServiceProvider);
  try {
    const AsyncLoading();
    final docs = await service.getProducts();
    if (docs != null) {
      AsyncData(docs);
      return docs;
    } else {
      return docs;
    }
  } catch (e, s) {
    AsyncError(e, s);
  }
}
