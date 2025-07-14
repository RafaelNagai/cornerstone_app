import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cornerstone_app/features/user/domain/entities/user.dart';

// Pode ser um StateProvider se você pretende atualizá-lo depois
final currentUserProvider = StateProvider<User?>((ref) => null);
