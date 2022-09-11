import '../../../util/utilities/datetime_utils.dart';
import '../base_model.dart';

class User implements BaseModel {
  final String? id;
  final String? name;
  final String? email;
  final DateTime? createdAt;

  User({
    this.id,
    this.name,
    this.email,
    this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      createdAt: DateTimeUtils.parse(json['createdAt']),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'email': email,
      'createdAt': createdAt?.toIso8601String(),
    };
  }
}