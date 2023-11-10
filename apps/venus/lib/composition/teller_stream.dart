import 'dart:async';

import 'package:venus/collection/models/teller_data.dart';

final tellerSuccessStreamController = StreamController<TellerData>.broadcast();

Stream<TellerData> get tellerSuccessStream =>
    tellerSuccessStreamController.stream;
