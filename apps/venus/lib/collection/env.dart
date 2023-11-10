import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env', obfuscate: true)
abstract class Env {
  @EnviedField(varName: 'TELLER_APPLICATION_ID')
  static final String tellerApplicationId = _Env.tellerApplicationId;
}
