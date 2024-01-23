import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/constants/commons.dart';
import 'package:mobile/gen/assets.gen.dart';
import 'package:mobile/utils/extensions.dart';
import 'package:mobile/views/friends/bloc/friends_bloc.dart';
import 'package:mobile/widget/body_widget.dart';
import 'package:mobile/widget/button_widget.dart';

class MyAddFriendScreen extends StatefulWidget {
  const MyAddFriendScreen({super.key});

  @override
  State<MyAddFriendScreen> createState() => _MyAddFriendScreenState();
}

class _MyAddFriendScreenState extends State<MyAddFriendScreen> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FriendsBloc(),
      child: BlocConsumer<FriendsBloc, FriendsState>(
        listener: (context, state) {
          if (state.status == FriendStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message ?? 'Something went wrong!'),
              ),
            );
          }
        },
        builder: (context, state) {
          print(state.contactList);
          return BodyWidget(
            isLoading: state.status == FriendStatus.loading,
            child: Scaffold(
              appBar: AppBar(
                title: TextField(
                  controller: _controller,
                  decoration: const InputDecoration.collapsed(
                    hintText: 'Enter name, email or phone #',
                    hintStyle: TextStyle(fontSize: 18),
                  ),
                  style: const TextStyle(fontSize: 18),
                ),
              ),
              body: SizedBox.expand(
                child: Padding(
                  padding: allPadding16,
                  child: (state.contactList?.length ?? 0) > 0
                      ? ListView.separated(
                          itemBuilder: (context, index) {
                            final contact = state.contactList![index];
                            return ListTile(
                              title: Text(contact.displayName),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const Divider();
                          },
                          itemCount: state.contactList!.length,
                          shrinkWrap: true,
                        )
                      : const AllowContactAccessWidget(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class AllowContactAccessWidget extends StatelessWidget {
  const AllowContactAccessWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Assets.svg.findFriends.svg(
          width: MediaQuery.sizeOf(context).width * .5,
        ),
        verticalMargin24,
        SizedBox(
          width: MediaQuery.sizeOf(context).width * .8,
          child: Text(
            '''Allow Udhar kab Dega to access your contact to add people faster.''',
            style: context.textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ),
        verticalMargin24,
        MiniCustomButton(
          label: 'Allow contact access',
          onTap: () {
            context.read<FriendsBloc>().add(GetAllContactList());
          },
        ),
      ],
    );
  }
}
