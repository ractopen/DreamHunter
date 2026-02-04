import 'package:flutter_test/flutter_test.dart';
import 'package:dreamdefenders/domain/player.dart';

void main() {
  group('Player', () {
    test('health should decrease when taking damage', () {
      // Arrange
      final player = Player(health: 100);

      // Act
      player.takeDamage(20);

      // Assert
      expect(player.health, 80);
    });
  });
}
