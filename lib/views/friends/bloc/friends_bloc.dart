import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fast_contacts/fast_contacts.dart';
import 'package:mobile/service/permission_services.dart';
import 'package:permission_handler/permission_handler.dart';

part 'friends_event.dart';
part 'friends_state.dart';

class FriendsBloc extends Bloc<FriendsEvent, FriendsState> {
  FriendsBloc() : super(FriendsState.initial()) {
    on<GetAllContactList>(_getAllContactList);
  }

  FutureOr<void> _getAllContactList(
    GetAllContactList event,
    Emitter<FriendsState> emit,
  ) async {
    emit(state.copyWith(status: FriendStatus.loading));
    try {
      if (await PermissionService.hasPermission(Permission.contacts)) {
        final contacts = await FastContacts.getAllContacts();
        emit(
          state.copyWith(
            contactList: contacts,
            status: FriendStatus.success,
          ),
        );
      } else {
        // Permission not granted, request it or handle alternative
        final isGranted = await PermissionService.requestAndCheckPermission(
          Permission.contacts,
        );
        if (isGranted) {
          final contacts = await FastContacts.getAllContacts();
          emit(
            state.copyWith(
              contactList: contacts,
              status: FriendStatus.success,
            ),
          );
        } else {
          emit(
            state.copyWith(
              message: 'Please, give contact Permission',
              status: FriendStatus.failure,
            ),
          );
        }
      }
    } catch (e) {
      final message = e.toString();
      emit(state.copyWith(status: FriendStatus.failure, message: message));
    }
  }
}
