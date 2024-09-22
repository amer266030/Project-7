part of 'pdf_preview_cubit.dart';

@immutable
sealed class PdfPreviewState {}

final class PdfPreviewInitial extends PdfPreviewState {}

final class LoadingState extends PdfPreviewState {}

final class SuccessState extends PdfPreviewState {}

final class ErrorState extends PdfPreviewState {}
