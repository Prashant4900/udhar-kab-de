part of 'friends_bloc.dart';

enum FriendStatus { initial, loading, success, failure }

class FriendsState extends Equatable {
  const FriendsState({
    this.status,
    this.message,
    this.contactList,
  });

  factory FriendsState.initial() =>
      const FriendsState(status: FriendStatus.initial);

  final FriendStatus? status;
  final String? message;
  final List<Contact>? contactList;

  FriendsState copyWith({
    FriendStatus? status,
    String? message,
    List<Contact>? contactList,
  }) {
    return FriendsState(
      status: status ?? this.status,
      message: message ?? this.message,
      contactList: contactList ?? this.contactList,
    );
  }

  @override
  List<Object?> get props => [
        status,
        message,
        contactList,
      ];
}
