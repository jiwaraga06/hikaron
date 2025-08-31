import 'package:bloc/bloc.dart';
import 'package:hikaron/source/repository/PutAwayRepository.dart';
import 'package:meta/meta.dart';

part 'getdata_qr_put_away_state.dart';

class GetdataQrPutAwayCubit extends Cubit<GetdataQrPutAwayState> {
  final PutAwayRepository? repository;
  GetdataQrPutAwayCubit({this.repository}) : super(GetdataQrPutAwayInitial());
}
