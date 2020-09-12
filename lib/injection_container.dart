import 'package:coconut_app/auth_repo.dart';
import 'package:coconut_app/group_repo.dart';
import 'package:coconut_app/payment_repo.dart';
import 'package:coconut_app/presentation/home_page/cubit/home_cubit.dart';
import 'package:coconut_app/presentation/login_page/cubit/login_cubit.dart';
import 'package:coconut_app/user_repo.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => LoginCubit(sl()));
  sl.registerFactory(() => HomeCubit(sl(), sl()));

  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  sl.registerLazySingleton<GroupRepository>(() => GroupRepositoryImpl(sl()));
  sl.registerLazySingleton<PaymentRepository>(() => PaymentRepositoryImpl());
  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl());
}
