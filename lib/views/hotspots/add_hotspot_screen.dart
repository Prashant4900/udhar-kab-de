import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/constants/commons.dart';
import 'package:mobile/utils/extensions.dart';
import 'package:mobile/views/hotspots/bloc/hotspot_bloc.dart';
import 'package:mobile/widget/body_widget.dart';

final _chipsList = <String>[
  'Snacks',
  'Food',
  'Petrol',
  'Shopping',
  'Other',
];

class MyAddHotspotScreen extends StatefulWidget {
  const MyAddHotspotScreen({super.key});

  @override
  State<MyAddHotspotScreen> createState() => _MyAddHotspotScreenState();
}

class _MyAddHotspotScreenState extends State<MyAddHotspotScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final TextEditingController _hotspotNameController;
  late final TextEditingController _hotspotTypeController;
  late final TextEditingController _hotspotLocationController;

  @override
  void initState() {
    super.initState();
    _hotspotLocationController = TextEditingController();
    _hotspotTypeController = TextEditingController();
    _hotspotNameController = TextEditingController();
  }

  @override
  void dispose() {
    _hotspotLocationController.dispose();
    _hotspotNameController.dispose();
    _hotspotTypeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HotspotBloc(),
      child: BlocConsumer<HotspotBloc, HotspotState>(
        listener: (context, state) {},
        builder: (context, state) {
          return BodyWidget(
            child: Scaffold(
              appBar: AppBar(),
              body: const Padding(
                padding: allPadding16,

                // child: Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     Text(
                //       'Add Hotspot Details',
                //       style: context.textTheme.headlineLarge!.copyWith(
                //         fontWeight: FontWeight.bold,
                //       ),
                //     ),
                //     verticalMargin16,
                //     const Text(
                //       '''Once any one of the two buttons is tapped, it will trigger the Navigate.pop method sending the respective data back as an argument.''',
                //     ),
                //     verticalMargin32,
                //     Text(
                //       'Hotspot type *',
                //       style: context.textTheme.bodyLarge,
                //     ),
                //     verticalMargin8,
                //     Consumer<HotspotTypeProvider>(
                //       builder: (context, ref, child) {
                //         final selectedIndex = ref.selectedIndex;
                //         return selectedIndex != 4
                //             ? Wrap(
                //                 children: List.generate(
                //                   _chipsList.length,
                //                   (index) => Padding(
                //                     padding: rightPadding12,
                //                     child: InkWell(
                //                       onTap: () {
                //                         ref.updateSelectedIndex(index);
                //                         _hotspotTypeController.text =
                //                             _chipsList[index];
                //                       },
                //                       borderRadius: BorderRadius.circular(12),
                //                       child: Hero(
                //                         tag: _chipsList[index],
                //                         child: Chip(
                //                           backgroundColor:
                //                               index == selectedIndex
                //                                   ? context.colorScheme
                //                                       .primaryContainer
                //                                       .withOpacity(0.7)
                //                                   : null,
                //                           label: Text(
                //                             _chipsList[index],
                //                           ),
                //                         ),
                //                       ),
                //                     ),
                //                   ),
                //                 ),
                //               )
                //             : Hero(
                //                 tag: _chipsList[selectedIndex],
                //                 child: Row(
                //                   children: [
                //                     InkWell(
                //                       onTap: () => ref.updateSelectedIndex(-1),
                //                       borderRadius: BorderRadius.circular(12),
                //                       child: Chip(
                //                         backgroundColor: context
                //                             .colorScheme.primaryContainer
                //                             .withOpacity(0.7),
                //                         label: Text(_chipsList[selectedIndex]),
                //                       ),
                //                     ),
                //                     horizontalMargin12,
                //                     Expanded(
                //                       child: TextField(
                //                         controller: _hotspotTypeController,
                //                         decoration: InputDecoration(
                //                           hintText: 'Enter Hotspot Type',
                //                           suffixIcon: InkWell(
                //                             onTap: () {
                //                               _hotspotTypeController.clear();
                //                               ref.updateSelectedIndex(-1);
                //                             },
                //                             child: const Icon(
                //                               CupertinoIcons
                //                                   .clear_thick_circled,
                //                             ),
                //                           ),
                //                         ),
                //                       ),
                //                     ),
                //                   ],
                //                 ),
                //               );
                //       },
                //     ),
                //     verticalMargin16,
                //     textFieldWithLabel(
                //       controller: _hotspotNameController,
                //       label: 'Hotspot Name',
                //     ),
                //     verticalMargin16,
                //     textFieldWithLabel(
                //       controller: _hotspotLocationController,
                //       label: 'Location',
                //       maxLine: 3,
                //     ),
                //     const Spacer(),
                //     CustomButton(
                //       label: 'Create Hotspot',
                //       onTap: validState()
                //           ? () {
                //               context.read<HotspotBloc>().add(
                //                     CreateHotspotEvent(
                //                       hotspotModel: HotspotRequestModel(
                //                         hotspotLocation:
                //                             _hotspotLocationController.text,
                //                         hotspotName:
                //                             _hotspotNameController.text,
                //                         hotspotType:
                //                             _hotspotTypeController.text,
                //                       ),
                //                     ),
                //                   );

                //               Navigator.pop(context, true);
                //             }
                //           : null,
                //     ),
                //     verticalMargin32,
                //   ],
                // ),
              ),
            ),
          );
        },
      ),
    );
  }

  bool validState() {
    return _hotspotTypeController.text.length >= 2 &&
        _hotspotTypeController.text.length < 20 &&
        _hotspotNameController.text.length >= 3 &&
        _hotspotNameController.text.length < 30 &&
        _hotspotLocationController.text.length < 100 &&
        _hotspotNameController.text.isNotEmpty &&
        _hotspotLocationController.text.isNotEmpty &&
        _hotspotTypeController.text.isNotEmpty;
  }

  Widget textFieldWithLabel({
    required TextEditingController controller,
    required String label,
    Widget? icon,
    int? maxLine,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: context.textTheme.bodyLarge,
            ),
            const Spacer(),
            icon ?? emptyWidget,
          ],
        ),
        verticalMargin8,
        Container(
          decoration: BoxDecoration(
            color: context.colorScheme.primaryContainer.withOpacity(0.7),
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              contentPadding:
                  horizontalPadding12 + verticalPadding8 + verticalPadding2,
              border: InputBorder.none,
              hintText: 'Enter $label',
              suffixIcon: InkWell(
                onTap: () => controller.clear(),
                child: const Icon(
                  CupertinoIcons.clear_thick_circled,
                  size: 16,
                ),
              ),
            ),
            maxLines: maxLine,
          ),
        ),
      ],
    );
  }
}
