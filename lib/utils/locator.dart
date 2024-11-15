import 'package:get_it/get_it.dart';
import 'package:roqqu/services/binance_service.dart';


GetIt locator = GetIt.instance;

void setUpLocator() {
  locator.registerLazySingleton(() => BinanceService());


}
