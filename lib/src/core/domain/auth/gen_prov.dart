import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:skincare_app/src/core/domain/auth/auth_service.dart';

part 'gen_prov.g.dart';


@riverpod
AuthService authService(AuthServiceRef ref) => AuthService();
