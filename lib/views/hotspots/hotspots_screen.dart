import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/constants/commons.dart';
import 'package:mobile/models/hotspot_model.dart';
import 'package:mobile/utils/extensions.dart';
import 'package:mobile/views/hotspots/bloc/hotspot_bloc.dart';
import 'package:mobile/views/hotspots/provider/hotspot_type_provider.dart';
import 'package:mobile/widget/body_widget.dart';
import 'package:provider/provider.dart';

final _chipsList = <String>[
  'Snacks',
  'Food',
  'Petrol',
  'Shopping',
  'Other',
];

class MyHotSpotsScreen extends StatefulWidget {
  const MyHotSpotsScreen({super.key});

  @override
  State<MyHotSpotsScreen> createState() => _MyHotSpotsScreenState();
}

class _MyHotSpotsScreenState extends State<MyHotSpotsScreen> {
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
      create: (context) => HotspotBloc()..add(GetAllHotspotEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Hotspots'),
          centerTitle: true,
        ),
        body: BlocConsumer<HotspotBloc, HotspotState>(
          listener: (context, state) {},
          builder: (context, state) {
            return BodyWidget(
              isLoading: state.status == HotspotStatus.loading,
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: state.hotspots!.length,
                itemBuilder: (context, index) {
                  final hotspotItem = state.hotspots![index];
                  return Card(
                    elevation: 0,
                    child: Padding(
                      padding: verticalPadding12,
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        onTap: () => createUpdateHotspotsSheet(
                          context,
                          model: HotspotModel(
                            hotspotName: hotspotItem.hotspotName,
                            hotspotLocation: hotspotItem.hotspotLocation,
                          ),
                        ),
                        leading: Column(
                          children: [
                            const Icon(
                              Icons.home,
                              size: 26,
                            ),
                            Text(
                              '2.0 m',
                              style: context.textTheme.bodySmall,
                            ),
                          ],
                        ),
                        title: Text(
                          hotspotItem.hotspotName!,
                          style: context.textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          hotspotItem.hotspotLocation!,
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => verticalMargin8,
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: context.colorScheme.primary,
          onPressed: () {
            createUpdateHotspotsSheet(context);
          },
          label: Text(
            'Add Hotspot',
            style: context.textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.w600,
              color: context.colorScheme.onPrimary,
            ),
          ),
          icon: Icon(
            Icons.add,
            color: context.colorScheme.onPrimary,
          ),
        ),
      ),
    );
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
            color: context.colorScheme.primaryContainer,
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

  Future<void> createUpdateHotspotsSheet(
    BuildContext context, {
    HotspotModel? model,
  }) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      builder: (context) {
        return ListView(
          shrinkWrap: true,
          padding: horizontalPadding16,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            verticalMargin32,
            Row(
              children: [
                Text(
                  'Create Hotspots',
                  style: context.textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.colorScheme.primary,
                    fontSize: 20,
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Text(
                    'Close',
                    style: context.textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.colorScheme.error,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(),
            verticalMargin12,
            Text(
              'Hotspot type *',
              style: context.textTheme.bodyLarge,
            ),
            verticalMargin12,
            Consumer<HotspotTypeProvider>(
              builder: (context, ref, child) {
                final selectedIndex = ref.selectedIndex;
                _hotspotLocationController.text = model?.hotspotLocation ?? '';
                _hotspotNameController.text = model?.hotspotName ?? '';
                return selectedIndex != 4
                    ? SizedBox(
                        height: 50,
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: rightPadding12,
                              child: InkWell(
                                onTap: () => ref.updateSelectedIndex(index),
                                borderRadius: BorderRadius.circular(12),
                                child: Hero(
                                  tag: _chipsList[index],
                                  child: Chip(
                                    backgroundColor: index == selectedIndex
                                        ? context.colorScheme.primaryContainer
                                        : null,
                                    label: Text(
                                      _chipsList[index],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          shrinkWrap: true,
                          itemCount: _chipsList.length,
                          scrollDirection: Axis.horizontal,
                        ),
                      )
                    : Hero(
                        tag: _chipsList[selectedIndex],
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () => ref.updateSelectedIndex(-1),
                              borderRadius: BorderRadius.circular(12),
                              child: Chip(
                                backgroundColor:
                                    context.colorScheme.primaryContainer,
                                label: Text(_chipsList[selectedIndex]),
                              ),
                            ),
                            horizontalMargin12,
                            Expanded(
                              child: TextField(
                                controller: _hotspotTypeController,
                                decoration: InputDecoration(
                                  hintText: 'Enter Hotspot Type',
                                  suffixIcon: InkWell(
                                    onTap: () {
                                      _hotspotTypeController.clear();
                                      ref.updateSelectedIndex(-1);
                                    },
                                    child: const Icon(
                                      CupertinoIcons.clear_thick_circled,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
              },
            ),
            verticalMargin16,
            textFieldWithLabel(
              controller: _hotspotNameController,
              label: 'Hotspot Name',
            ),
            verticalMargin16,
            textFieldWithLabel(
              controller: _hotspotLocationController,
              label: 'Location',
              maxLine: 4,
              icon: InkWell(
                onTap: () {},
                child: Icon(
                  Icons.location_on,
                  color: context.colorScheme.primary,
                ),
              ),
            ),
            verticalMargin16,
            InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: context.colorScheme.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    'Save',
                    style: context.textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.colorScheme.onPrimary,
                    ),
                  ),
                ),
              ),
            ),
            verticalMargin48,
          ],
        );
      },
    );
  }
}
