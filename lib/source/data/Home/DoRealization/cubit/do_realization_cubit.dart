import 'package:bloc/bloc.dart';
import 'package:hikaron/source/repository/repository.dart';
import 'package:meta/meta.dart';

part 'do_realization_state.dart';

class DoRealizationCubit extends Cubit<DoRealizationState> {
  final MyRepository? myRepository;
  DoRealizationCubit({required this.myRepository}) : super(DoRealizationInitial());
}
