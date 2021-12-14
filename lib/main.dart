import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:momnotebook/constants/sizeConfig.dart';
import 'package:momnotebook/cubit/cubit/auth_cubit_cubit.dart';
import 'package:momnotebook/cubit/cubit/home_page_cubit.dart';
import 'package:momnotebook/routes/appRouter.dart';

import 'bloc/bloc/form_saving_bloc.dart';
import 'constants/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final AppRouter _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        SizeConfig().init(constraints, orientation);
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => HomePageCubit()..getBabyTasks()),
            BlocProvider(create: (context) => AuthCubitCubit()..getUser()),
          ],
          child: MaterialApp(
            title: "Mom's notebook",
            debugShowCheckedModeBanner: false,
            theme: theme(),
            onGenerateRoute: _appRouter.onGenerateRoute,
          ),
        );
      });
    });
  }
}
