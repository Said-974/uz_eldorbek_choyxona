import 'dart:convert';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/error/exceptions.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> verifyPin(String restaurantId, String pin);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;

  AuthRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<UserModel> verifyPin(String restaurantId, String pin) async {
    try {
      final response = await supabaseClient.rpc(
        'rpc_verify_pin',
        params: {
          'p_restaurant_id': restaurantId,
          'p_pin': pin,
        },
      );

      final data = response is String ? jsonDecode(response) : response;

      if (data['success'] == true && data['user'] != null) {
        return UserModel.fromJson(data['user'] as Map<String, dynamic>);
      } else {
        throw AppAuthException(data['message'] ?? 'PIN-kod noto‘g‘ri!');
      }
    } catch (e) {
      if (e is AppAuthException) rethrow;
      throw ServerException('Server bilan bog‘lanishda xatolik yuz berdi.');
    }
  }
}
