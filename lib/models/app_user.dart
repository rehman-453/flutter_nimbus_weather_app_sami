/// A registered account. Kept in memory until a real backend is wired up.
class AppUser {
  const AppUser({
    required this.name,
    required this.email,
    required this.password,
  });

  final String name;
  final String email;
  final String password;
}
