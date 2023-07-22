// lib/pages/home/model.dart
final List<Contact> contacts = [
  Contact(name: 'Alice', avatarUrl: 'https://example.com/alice.png'),
  Contact(name: 'Bob', avatarUrl: 'https://example.com/bob.png'),
  Contact(name: 'Charlie', avatarUrl: 'https://example.com/charlie.png'),
];
class Contact {
  final String name;
  final String avatarUrl;

  Contact({required this.name, required this.avatarUrl});
}
