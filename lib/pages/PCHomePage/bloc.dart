// lib/pages/home/bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'model.dart';

// 定义事件
class ContactsEvent {}

class LoadContacts extends ContactsEvent {}

class SearchContacts extends ContactsEvent {
  final String query;

  SearchContacts(this.query);
}

// 定义状态
class ContactsState {}

class ContactsLoading extends ContactsState {}

class ContactsLoaded extends ContactsState {
  final List<Contact> contacts;

  ContactsLoaded(this.contacts);
}

class ContactsError extends ContactsState {
  final String error;

  ContactsError(this.error);
}

// 定义 BLoC
class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  ContactsBloc() : super(ContactsLoading());

  Stream<ContactsState> mapEventToState(ContactsEvent event) async* {
    if (event is LoadContacts) {
      // 加载联系人列表
      try {
        // TODO: 调用接口获取联系人列表
        final contacts = [
          Contact(name: 'Alice', avatarUrl: 'https://example.com/alice.png'),
          Contact(name: 'Bob', avatarUrl: 'https://example.com/bob.png'),
          Contact(name: 'Charlie', avatarUrl: 'https://example.com/charlie.png'),
        ];
        yield ContactsLoaded(contacts);
      } catch (error) {
        yield ContactsError(error.toString());
      }
    } else if (event is SearchContacts) {
      // 搜索联系人
      try {
        // TODO: 调用接口搜索联系人
        final contacts = [
          Contact(name: 'Alice', avatarUrl: 'https://example.com/alice.png'),
        ];
        yield ContactsLoaded(contacts);
      } catch (error) {
        yield ContactsError(error.toString());
      }
    }
  }
}