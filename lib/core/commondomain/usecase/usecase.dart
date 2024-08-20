import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

import '../../network/network_exception/network_exception.dart';

abstract class Usecase<Type, Params>{
  Future<Either<NetworkException,Type>> call(Params? param);
}

class NoParams extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => <Object?>[];
  
}