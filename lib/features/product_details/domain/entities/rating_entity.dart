import 'package:equatable/equatable.dart';

class RatingEntity extends Equatable {
  final double? rate;
  final int? count;

  RatingEntity({this.rate, this.count});

  @override
  List<Object?> get props => <Object?>[rate, count];
}
