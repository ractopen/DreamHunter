class Player {
  int health;

  Player({required this.health});

  void takeDamage(int amount) {
    health -= amount;
  }
}
