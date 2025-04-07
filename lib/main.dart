import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_my_landlord/app.dart';

import 'package:rate_my_landlord/net/firebase/database/rating/cubit/rating_database_cubit.dart';
import 'package:rate_my_landlord/net/firebase/database/rating/rating_database.dart';
import 'package:rate_my_landlord/net/firebase/database/selected_cubit.dart';
import 'package:rate_my_landlord/net/firebase/database/tenant/cubit/tenant_database_cubit.dart';
import 'package:rate_my_landlord/net/firebase/database/tenant/tenants_database.dart';
import 'package:rate_my_landlord/net/map/map_cubit.dart';
import 'package:rate_my_landlord/screens/cubit/bottom_nav_bar_cubit.dart';
import 'package:rate_my_landlord/views/search/selected_type_cubit.dart';

import 'a.dart';
import 'net/firebase/auth/cubit/authorization_cubit.dart';
import 'net/firebase/database/landlord/landlord_database.dart';
import 'net/firebase/database/landlord/landlord_database_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'rate-my-landlord-45fe2-default-rtdb',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  BlocOverrides.runZoned(
          () => runApp( MultiBlocProvider(
        providers: <BlocProvider>[
          BlocProvider<RatingDatabaseCubit>(
            create: (_)=>RatingDatabaseCubit(RatingDatabase()),
          ),
          BlocProvider<AuthorizationCubit>(
            create: (_) => AuthorizationCubit(),
          ),
          BlocProvider<TenantsDatabaseCubit>(
            create: (_)=>TenantsDatabaseCubit(TenantsDatabase()),
          ),
          BlocProvider<BottomNavBarCubit>(
            create: (_) => BottomNavBarCubit(BottomNavBarCubit.home),
          ),
          BlocProvider<SelectedCubit>(
            create: (_) => SelectedCubit(),
          ),
          BlocProvider<SelectedTypeCubit>(
            create: (_) => SelectedTypeCubit(),
          ),
          BlocProvider<LandlordDatabaseCubit>(
            create: (_) => LandlordDatabaseCubit(LandlordDatabase()),
          ),
          BlocProvider<MapCubit>(
            create: (_) => MapCubit(),
          ),
        ],
        child: RateApp(),
      )),
  );
  //runApp(RateApp());
}
