part of 'qr_cubit.dart';

@immutable
abstract class QrState {}

class QrInitial extends QrState {}

class QrLoadingState extends QrState {}

class QrLoadedState extends QrState {
  List<QrModel> QrList;

  QrLoadedState({required this.QrList});
}

class QrErrorState extends QrState {}


