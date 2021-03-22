class FriendlyTroop {
  PVector pos = new PVector();  //a starting position
  PVector speed = new PVector(1, 0);  //the speed of a troop - not constant for all troops
  PImage troop;  //the image of the troop we deploy - defined in each sub-class
  int allegiance, hp, damage, reach; //allegiance defines the troop's faction (player or enemy)
  float attackSpeed = 1; //the attack speed of a troop - not constant for all troops
  int lastTimeAttacked;
  float speedBeforeContact;
  //boolean occupied = false;


  FriendlyTroop () {
    pos.x = h.selectorX + 20;
    pos.y = h.selectorY;
    speedBeforeContact = speed.x;
  }


  void update() {
    pos.add(speed);
    image(troop, pos.x, pos.y);
  }


  void checkCollision() {
    if (pos.x >= width - 75 - reach && pos.x < width) { //Checks collision with Enemy castle
      speed.x = 0;
      if (millis() - lastTimeAttacked >= attackSpeed*1000) {
        currentEnemyCastleHP -= damage;
        lastTimeAttacked = millis();
      }
    }

    for (int i = 0; i < et.size(); i++) {
      if (pos.x >= et.get(i).pos.x - 30 - reach && pos.y == et.get(i).pos.y) { //Checks collision with enemy troops
        speed.x = 0;
        if (millis() - lastTimeAttacked >= attackSpeed*1000) { //Attacke speed is multiplied by 1000 because the millis()
          et.get(i).hp -= damage;                              // runs in milli seconds while attack speed is in seconds
          lastTimeAttacked = millis();
          if (et.get(i).hp <= 0) {
            this.speed.x = speedBeforeContact;
          }
        }
      } else {
        speed.x = speedBeforeContact;
      }
    }
  }

  void collision() {
  }
}



class FSwordsman extends FriendlyTroop {

  FSwordsman() {
    super();
    troop = swordsman;
    speed.x = 1.2;
    damage = 5;
    hp = 20;
    reach = 0;
    f.goldCount -= 20;
  }


  void collision() {
  }
}


class FArcher extends FriendlyTroop {

  FArcher() {
    super();
    troop = archer;
    speed.x = 0.9;
    damage = 2;
    attackSpeed = 0.5;
    hp = 15;
    reach = 150;
    f.goldCount -= 25;
  }

  void collision() {
  }
}


class FMage extends FriendlyTroop {

  FMage() {
    super();
    troop = mage;
    speed.x = 0.9;
    damage = 8;
    hp = 15;
    reach = 80;
    f.goldCount -= 40;
  }

  void collision() {
  }
}


class FCavalry extends FriendlyTroop {

  FCavalry() {
    super();
    troop = cavalry;
    speed.x = 1.5;
    damage = 4;
    hp = 50;
    reach = 30;
    f.goldCount -= 70;
  }

  void collision() {
  }
}


class FGiant extends FriendlyTroop {

  FGiant() {
    super();
    troop = giant;
    speed.x = 0.6;
    damage = 10;
    attackSpeed = 2;
    hp = 70;
    reach = 10;
    f.goldCount -= 100;
  }

  void collision() {
  }
}
