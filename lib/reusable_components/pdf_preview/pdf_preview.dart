import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:tuwaiq_project_pulse/reusable_components/pdf_preview/pdf_preview_cubit.dart';

class PdfPreview extends StatelessWidget {
  const PdfPreview({super.key, this.url});
  final String? url;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PdfPreviewCubit(),
      child: BlocBuilder<PdfPreviewCubit, PdfPreviewState>(
        builder: (context, state) {
          final cubit = context.read<PdfPreviewCubit>();
          Future.microtask(() {
            if (state is PdfPreviewInitial) {
              cubit.loadPdf(url ?? '');
            }
          });

          return SizedBox(
            width:
                MediaQuery.of(context).size.width * 0.8, // 80% of screen width
            height: MediaQuery.of(context).size.height *
                0.5, // 60% of screen height
            child: (state is SuccessState && cubit.localPath != null)
                ? PDFView(
                    filePath: cubit.localPath!,
                    enableSwipe: true,
                    swipeHorizontal: false,
                    autoSpacing: true,
                    pageFling: true,
                  )
                : (state is ErrorState)
                    ? const Text('No PDF Found!')
                    : const CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
