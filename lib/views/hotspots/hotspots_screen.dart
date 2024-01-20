import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/constants/commons.dart';
import 'package:mobile/gen/assets.gen.dart';
import 'package:mobile/models/hotspots/hotspot_models.dart';
import 'package:mobile/utils/extensions.dart';
import 'package:mobile/views/hotspots/bloc/hotspot_bloc.dart';
import 'package:mobile/views/hotspots/provider/hotspot_type_provider.dart';
import 'package:mobile/widget/body_widget.dart';
import 'package:mobile/widget/button_widget.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

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
      child: BlocConsumer<HotspotBloc, HotspotState>(
        listener: (context, state) {},
        builder: (context, state) {
          return BodyWidget(
            isLoading: state.status == HotspotStatus.loading,
            child: Scaffold(
              appBar: AppBar(
                title: const Text('Hotspots'),
                centerTitle: true,
              ),
              body: ListView.separated(
                shrinkWrap: true,
                padding: allPadding16,
                itemCount: state.hotspots?.length ?? 0,
                itemBuilder: (context, index) {
                  final hotspotItem = state.hotspots![index];
                  return Card(
                    child: Padding(
                      padding: horizontalPadding12 + verticalPadding16,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: topPadding4,
                            child:
                                getHotspotIcon(hotspotItem.hotspotType ?? ''),
                          ),
                          horizontalMargin12,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                hotspotItem.hotspotType ?? '',
                                style: context.textTheme.bodyLarge!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              verticalMargin8,
                              Text(
                                hotspotItem.hotspotName ?? '',
                                style: context.textTheme.bodyMedium,
                                maxLines: 3,
                              ),
                              verticalMargin8,
                              SizedBox(
                                width: context.mediaQuery.size.width * 0.77,
                                child: Text(
                                  hotspotItem.hotspotLocation ?? '',
                                  style: context.textTheme.bodyMedium,
                                  maxLines: 3,
                                ),
                              ),
                              verticalMargin8,
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'EDIT',
                                    style:
                                        context.textTheme.titleMedium!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: context.colorScheme.primary,
                                    ),
                                  ),
                                  horizontalMargin16,
                                  InkWell(
                                    onTap: () {
                                      context.read<HotspotBloc>().add(
                                            DeleteHotspotEvent(
                                              hotspotModel: HotspotRequestModel(
                                                id: hotspotItem.id,
                                              ),
                                            ),
                                          );
                                    },
                                    child: Text(
                                      'DELETE',
                                      style: context.textTheme.titleMedium!
                                          .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: context.colorScheme.primary,
                                      ),
                                    ),
                                  ),
                                  horizontalMargin16,
                                  InkWell(
                                    onTap: () {
                                      Share.share(
                                        '''Hey! Save this address on Udhar Kab Dega https://play.google.com/store/apps/details?id=news.nerdy.mobile.\n\nName: ${hotspotItem.hotspotName}\n\nAddress: ${hotspotItem.hotspotLocation}''',
                                      );
                                    },
                                    child: Text(
                                      'SHARE',
                                      style: context.textTheme.titleMedium!
                                          .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: context.colorScheme.primary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => verticalMargin8,
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
        },
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

  Future<void> createUpdateHotspotsSheet(
    BuildContext context, {
    HotspotResponseModel? model,
  }) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      elevation: 0,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                                onTap: () {
                                  ref.updateSelectedIndex(index);
                                  _hotspotTypeController.text =
                                      _chipsList[index];
                                },
                                borderRadius: BorderRadius.circular(12),
                                child: Hero(
                                  tag: _chipsList[index],
                                  child: Chip(
                                    backgroundColor: index == selectedIndex
                                        ? context.colorScheme.primaryContainer
                                            .withOpacity(0.7)
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
                                backgroundColor: context
                                    .colorScheme.primaryContainer
                                    .withOpacity(0.7),
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
            ),
            verticalMargin16,
            CustomButton(
              label: 'Save',
              onTap: () {
                Navigator.pop(context);
              },
            ),
            verticalMargin48,
          ],
        );
      },
    );
  }
}

Widget getHotspotIcon(String hotspotType) {
  switch (hotspotType.toLowerCase()) {
    case 'food':
      return Assets.svg.food.svg(
        width: 20,
      );
    case 'snacks':
      return Assets.svg.snacks2.svg(
        width: 20,
      );
    case 'petrol':
      return Assets.svg.petrol.svg(
        width: 20,
      );
    case 'shopping':
      return Assets.svg.shopping.svg(
        width: 20,
      );
    default:
      return Assets.svg.snacks1.svg(
        width: 20,
      );
  }
}
