import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:the_brick_of_resilience/app/modules/global/global_controller.dart';

import 'package:the_brick_of_resilience/app/modules/splash/splash_binding.dart';
import 'package:the_brick_of_resilience/app/modules/splash/splash_page.dart';
import 'package:the_brick_of_resilience/app/routes/app_pages.dart';
import 'package:the_brick_of_resilience/app/utils/dependency_injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DependencyInjection.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.lazyPut<GlobalController>(() => GlobalController());
    return GetMaterialApp(
      title: 'Flutter Demo',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const SplashPage(),
      initialBinding: SplashBinding(),
      getPages: AppPages.pages,
    );
  }
}
