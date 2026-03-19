import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../features/auth/data/datasources/session_local_data_source.dart';
import '../../../features/auth/data/repositories/permission_repository_impl.dart';
import '../../../features/auth/data/repositories/session_repository_impl.dart';
import '../../../features/auth/domain/repositories/permission_repository.dart';
import '../../../features/auth/domain/repositories/session_repository.dart';
import '../../../features/auth/domain/usecases/check_camera_permission.dart';
import '../../../features/auth/domain/usecases/check_notification_permission.dart';
import '../../../features/auth/domain/usecases/clear_session.dart';
import '../../../features/auth/domain/usecases/complete_onboarding.dart';
import '../../../features/auth/domain/usecases/get_startup_session.dart';
import '../../../features/auth/domain/usecases/open_permission_settings.dart';
import '../../../features/auth/domain/usecases/request_camera_permission.dart';
import '../../../features/auth/domain/usecases/request_notification_permission.dart';
import '../../../features/auth/domain/usecases/save_signed_in_role.dart';
import '../../../features/auth/presentation/bloc/auth_bloc.dart';
import '../api/api.dart';
import '../permission_gateway/permission_gateway.dart';
import '../url_launcher_gateway/url_launcher_gateway.dart';

part 'injection_container_main.dart';
