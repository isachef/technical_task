import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:t1/models/qr_model.dart';

part 'qr_state.dart';

class QrCubit extends Cubit<QrState> {
  QrCubit() : super(QrInitial());

  getQrCodes()async{
    try{
    emit(QrLoadingState());

    List<QrModel> QrList=QrModelList;
    await Future.delayed(Duration(seconds: 3));

    emit(QrLoadedState(QrList: QrList));
    }
    catch(error){
      emit(QrErrorState());
    }
  }
}
