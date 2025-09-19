import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:skincare_app/src/core/domain/cloud_firestore/cloud_firestore.dart';

part 'provider.g.dart';


@riverpod

CloudFirestoreService cloudFirestoreService(ref) => CloudFirestoreService();
