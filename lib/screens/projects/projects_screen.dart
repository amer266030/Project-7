import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuwaiq_project_pulse/extensions/color_ext.dart';
import 'package:tuwaiq_project_pulse/extensions/string_ex.dart';
import 'package:tuwaiq_project_pulse/screens/projects/projects_cubit.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:tuwaiq_project_pulse/screens/rating/rating_screen.dart';
import 'subviews/bootcamps_view.dart';
import 'subviews/top_rated_view.dart';

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProjectsCubit(),
      child: Builder(builder: (context) {
        final brightness = Theme.of(context).brightness;
        final cubit = context.read<ProjectsCubit>();
        return BlocListener<ProjectsCubit, ProjectsState>(
          listener: (context, state) {
            if (state is ProjectsErrorState) {
              cubit.showAlert(context, true);
            } else {
              cubit.dismissAlert(context);
            }
          },
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('TUWAIQ ACADEMY').styled(
                          size: 20,
                          weight: FontWeight.bold,
                          color: C.primary(brightness)),
                      IconButton(
                          onPressed: () async {
                            String barcodeScanRes =
                                await FlutterBarcodeScanner.scanBarcode(
                                    '#ff6666', 'Cancel', true, ScanMode.QR);
                            FlutterBarcodeScanner.getBarcodeStreamReceiver(
                                    "#ff6666",
                                    "Cancel",
                                    false,
                                    ScanMode.DEFAULT)!
                                .listen((barcode) {
                              print('Barcode: ');
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const RatingScreen(),
                                  ));
                            });
                          },
                          icon: const Icon(CupertinoIcons.qrcode))
                    ],
                  ),
                  const Divider(),
                  BlocBuilder<ProjectsCubit, ProjectsState>(
                    builder: (context, state) {
                      if (state is ProjectsInitial) cubit.getProjects();
                      return Expanded(
                        child: ListView(
                          children: [
                            TopRatedView(cubit.topRated, cubit),
                            BootCampsView(cubit: cubit),
                          ],
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
