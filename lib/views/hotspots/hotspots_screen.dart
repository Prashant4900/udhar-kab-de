import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/constants/commons.dart';
import 'package:mobile/gen/assets.gen.dart';
import 'package:mobile/models/hotspots/hotspot_models.dart';
import 'package:mobile/theme/theme_manager.dart';
import 'package:mobile/utils/extensions.dart';
import 'package:mobile/views/hotspots/bloc/hotspot_bloc.dart';
import 'package:mobile/views/hotspots/provider/hotspot_type_provider.dart';
import 'package:mobile/widget/body_widget.dart';
import 'package:mobile/widget/button_widget.dart';
import 'package:pinput/pinput.dart';
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final TextEditingController _hotspotNameController;
  late final TextEditingController _hotspotTypeController;
  late final TextEditingController _hotspotLocationController;
  int selectedIndex = -1;

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
      child: BlocBuilder<HotspotBloc, HotspotState>(
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
                                style: context.subtitleBoldStyle.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              verticalMargin4,
                              Text(
                                hotspotItem.hotspotName ?? '',
                                style: context.captionStyle,
                                maxLines: 3,
                              ),
                              verticalMargin4,
                              SizedBox(
                                width: context.mediaQuery.size.width * 0.6,
                                child: Text(
                                  hotspotItem.hotspotLocation ?? '',
                                  style: context.captionStyle,
                                  maxLines: 3,
                                ),
                              ),
                              verticalMargin12,
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      await addHotspotBottomSheet(
                                        context,
                                        hotspotResponseModel: hotspotItem,
                                      ).then((value) {
                                        if (value == true) {
                                          context
                                              .read<HotspotBloc>()
                                              .add(GetAllHotspotEvent());
                                        }
                                      });
                                    },
                                    child: Text(
                                      'EDIT',
                                      style: context.captionBoldStyle.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: context.colorScheme.primary,
                                      ),
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
                                      style: context.captionBoldStyle.copyWith(
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
                                      style: context.captionBoldStyle.copyWith(
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
              bottomNavigationBar: Padding(
                padding: bottomPadding24 + horizontalPadding16,
                child: CustomButton(
                  label: 'Add Hotspot',
                  onTap: () async {
                    await addHotspotBottomSheet(context).then((value) {
                      if (value == true) {
                        context.read<HotspotBloc>().add(GetAllHotspotEvent());
                      }
                    });
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<dynamic> addHotspotBottomSheet(
    BuildContext context, {
    HotspotResponseModel? hotspotResponseModel,
  }) {
    _hotspotNameController.text = hotspotResponseModel?.hotspotName ?? '';
    _hotspotLocationController.text =
        hotspotResponseModel?.hotspotLocation ?? '';
    return showModalBottomSheet<void>(
      context: context,
      elevation: 0,
      useRootNavigator: true,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return BlocProvider(
          create: (context) => HotspotBloc(),
          child: BlocBuilder<HotspotBloc, HotspotState>(
            builder: (context, state) {
              return Form(
                key: _formKey,
                child: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: horizontalPadding16 + bottomPadding48,
                  children: [
                    Divider(
                      thickness: 3,
                      indent: context.mediaQuery.size.width * 0.4,
                      endIndent: context.mediaQuery.size.width * 0.4,
                      color: Colors.black,
                    ),
                    verticalMargin12,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          hotspotResponseModel?.id == null
                              ? 'Create Hotspot'
                              : 'Update Hotspot',
                          style: context.textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context, false);
                          },
                          child: Text(
                            'Close',
                            style: context.textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                    verticalMargin24,
                    Text(
                      'Hotspot Type *',
                      style: context.textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    verticalMargin12,
                    Consumer<HotspotTypeProvider>(
                      builder: (context, ref, child) {
                        final selectedIndex = ref.selectedIndex;
                        return selectedIndex != 4
                            ? Wrap(
                                children: List.generate(
                                  _chipsList.length,
                                  (index) => Padding(
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
                                          backgroundColor:
                                              index == selectedIndex
                                                  ? context.colorScheme
                                                      .primaryContainer
                                                      .withOpacity(0.7)
                                                  : null,
                                          label: Text(
                                            _chipsList[index],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
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
                                              CupertinoIcons
                                                  .clear_thick_circled,
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
                    Text(
                      'Hotspot Name *',
                      style: context.textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextFormField(
                      controller: _hotspotNameController,
                      decoration: const InputDecoration(
                        hintText: 'Enter Name',
                      ),
                    ),
                    verticalMargin24,
                    Text(
                      'Hotspot Location *',
                      style: context.textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextFormField(
                      controller: _hotspotLocationController,
                      decoration: const InputDecoration(
                        hintText: 'Enter Location',
                      ),
                    ),
                    verticalMargin48 + verticalMargin48 + verticalMargin48,
                    CustomButton(
                      label: hotspotResponseModel?.id == null
                          ? 'Create Hotspot'
                          : 'Update Hotspot',
                      onTap: _hotspotTypeController.length > 3 ||
                              _hotspotNameController.length > 3
                          ? () {
                              context.read<HotspotBloc>().add(
                                    hotspotResponseModel?.id == null
                                        ? const CreateHotspotEvent(
                                            hotspotModel: HotspotRequestModel(
                                              hotspotType: 'Type',
                                              hotspotName: 'Name',
                                              hotspotLocation: 'Location',
                                            ),
                                          )
                                        : UpdateHotspotEvent(
                                            hotspotModel: HotspotRequestModel(
                                              id: hotspotResponseModel?.id,
                                              hotspotType: 'Type 2',
                                              hotspotName: 'Name 1',
                                              hotspotLocation: 'Location 1',
                                            ),
                                          ),
                                  );
                              Navigator.pop(context, true);
                            }
                          : null,
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}

Widget getHotspotIcon(String hotspotType) {
  switch (hotspotType.toLowerCase()) {
    case 'food':
      return Assets.svg.food.svg(
        width: 18,
      );
    case 'snacks':
      return Assets.svg.snacks2.svg(
        width: 18,
      );
    case 'petrol':
      return Assets.svg.petrol.svg(
        width: 18,
      );
    case 'shopping':
      return Assets.svg.shopping.svg(
        width: 18,
      );
    default:
      return Assets.svg.snacks1.svg(
        width: 18,
      );
  }
}
