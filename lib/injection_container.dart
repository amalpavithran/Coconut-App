import 'package:coconut_app/auth_repo.dart';
import 'package:coconut_app/group_repo.dart';
import 'package:coconut_app/payment_repo.dart';
import 'package:coconut_app/presentation/cubit/home_cubit.dart';
import 'package:coconut_app/presentation/cubit/login_cubit.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async{
  sl.registerFactory(() => LoginCubit(sl()));
  sl.registerFactory(() => HomeCubit(sl()));
  
  sl.registerLazySingleton(() => AuthRepositoryImpl());
  sl.registerLazySingleton(() => GroupRepositoryImpl());
  sl.registerLazySingleton(() => PaymentRepositoryImpl());
}