import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

part 'kalmaModel.g.dart';

@HiveType()
class KalmaModel {
  @HiveField(0)
  final String kalma;
  @HiveField(1)
  final String tdr;
  KalmaModel({@required this.kalma, @required this.tdr});
}
