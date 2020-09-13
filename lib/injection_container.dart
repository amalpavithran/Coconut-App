import 'package:coconut_app/presentation/account_page/cubit/account_cubit.dart';
import 'package:get_it/get_it.dart';

import 'presentation/repos/auth_repo.dart';
import 'presentation/repos/group_repo.dart';
import 'presentation/repos/payment_repo.dart';
import 'presentation/account_page/cubit/user_details_cubit.dart';
import 'presentation/group_page/cubit/group_cubit.dart';
import 'presentation/home_page/cubit/home_cubit.dart';
import 'presentation/login_page/cubit/login_cubit.dart';
import 'presentation/repos/user_repo.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => LoginCubit(sl(), sl()));
  sl.registerFactory(() => HomeCubit(sl(), sl(), sl()));
  sl.registerFactory(() => GroupCubit());
  sl.registerFactory(() => UserDetailsCubit());
  sl.registerFactory(() => AccountCubit());

  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  sl.registerLazySingleton<GroupRepository>(() => GroupRepositoryImpl(sl()));
  sl.registerLazySingleton<PaymentRepository>(() => PaymentRepositoryImpl());
  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl());
}
