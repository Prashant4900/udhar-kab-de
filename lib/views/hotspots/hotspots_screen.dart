import 'package:flutter/material.dart';
import 'package:mobile/constants/commons.dart';
import 'package:mobile/repositories/hotspot_repository.dart';
import 'package:mobile/utils/extensions.dart';
import 'package:mobile/widget/body_widget.dart';

class MyHotSpotsScreen extends StatelessWidget {
  const MyHotSpotsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Hotspots'),
      ),
      body: BodyWidget(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: horizontalPadding16 + verticalPadding12,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: context.colorScheme.primaryContainer,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.add,
                      color: context.colorScheme.onPrimaryContainer,
                    ),
                    horizontalMargin12,
                    Text(
                      'Add Hotspots',
                      style: context.textTheme.bodyLarge!.copyWith(
                        color: context.colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                      color: context.colorScheme.onPrimaryContainer,
                    ),
                  ],
                ),
              ),
              verticalMargin12,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child: SizedBox(
                      child: Divider(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'Saved Hotspots',
                      style: context.textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const Expanded(
                    child: SizedBox(
                      child: Divider(),
                    ),
                  ),
                ],
              ),
              verticalMargin12,
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    // ignore: lines_longer_than_80_chars
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      tileColor: context.colorScheme.surfaceVariant,
                      leading: const Column(
                        children: [Icon(Icons.home), Text('2.0 m')],
                      ),
                      title: const Text(
                        'Food',
                        style: TextStyle(fontWeight: FontWeight.w400),
                      ),
                      subtitle: const Column(
                        children: [
                          Text(
                            'Lohiya Bazaar Rd, Dal Bazaar, Lashkar, Gwalior, Madhya Pradesh 474001',
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          HotspotRepository().getHotspots();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
