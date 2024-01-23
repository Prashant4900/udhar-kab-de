import 'package:flutter/material.dart';
import 'package:mobile/constants/commons.dart';
import 'package:mobile/utils/extensions.dart';
import 'package:mobile/widget/body_widget.dart';
import 'package:mobile/widget/button_widget.dart';

class MyAccountDetailScreen extends StatelessWidget {
  const MyAccountDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BodyWidget(
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: allPadding16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Account details',
                style: context.textTheme.headlineSmall!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              verticalMargin32,
              SizedBox(
                width: 83,
                child: Column(
                  children: [
                    Text(
                      'PERSONAL',
                      style: context.textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: context.colorScheme.primary,
                      ),
                    ),
                    Divider(
                      thickness: 4,
                      color: context.colorScheme.primary,
                    ),
                  ],
                ),
              ),
              verticalMargin16,
              const TextFieldWithLabel(label: 'Name'),
              verticalMargin16,
              const TextFieldWithLabel(label: 'Email'),
              verticalMargin16,
              const TextFieldWithLabel(label: 'Mobile'),
              const Spacer(),
              CustomButton(
                label: 'Save',
                onTap: () {},
              ),
              verticalMargin24,
            ],
          ),
        ),
      ),
    );
  }
}

class TextFieldWithLabel extends StatelessWidget {
  const TextFieldWithLabel({required this.label, super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: context.textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.w300,
              ),
            ),
            verticalMargin4,
            TextField(
              decoration: InputDecoration.collapsed(
                hintText: 'Enter $label',
              ),
              style: context.textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
              cursorHeight: 15,
            ),
          ],
        ),
      ),
    );
  }
}
