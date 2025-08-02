class UserDetails {
  final int id;
  final String name;
  final String phone;
  final String address;
  final String mail;
  final String username;
  final String password;
  final String passwordText;
  final int admin;
  final bool isAdmin;
  final bool isActive;
  final String? lastLogin;
  final String createdAt;
  final String updatedAt;
  final dynamic branch;

  UserDetails({
    required this.id,
    required this.name,
    required this.phone,
    required this.address,
    required this.mail,
    required this.username,
    required this.password,
    required this.passwordText,
    required this.admin,
    required this.isAdmin,
    required this.isActive,
    this.lastLogin,
    required this.createdAt,
    required this.updatedAt,
    this.branch,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      address: json['address'],
      mail: json['mail'],
      username: json['username'],
      password: json['password'],
      passwordText: json['password_text'],
      admin: json['admin'],
      isAdmin: json['is_admin'],
      isActive: json['is_active'],
      lastLogin: json['last_login'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      branch: json['branch'],
    );
  }
}
