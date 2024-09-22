import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
part 'pdf_preview_state.dart';

class PdfPreviewCubit extends Cubit<PdfPreviewState> {
  PdfPreviewCubit() : super(PdfPreviewInitial());
  String? localPath;

  void loadPdf(String pdfUrl) {
    if (pdfUrl.isNotEmpty) {
      emit(LoadingState());
      downloadPdf(pdfUrl);
    } else {
      emit(ErrorState());
    }
  }

  Future<void> downloadPdf(String url) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final filePath = "${dir.path}/temp.pdf";
      await Dio().download(url, filePath);
      localPath = filePath;
      emit(SuccessState());
    } catch (e) {
      emit(ErrorState());
    }
  }
}
