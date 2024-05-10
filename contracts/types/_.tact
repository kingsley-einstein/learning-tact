struct User {
  id: Int as uint256;
  name: String;
  password: String;
}

struct Users {
  map: map<Int as uint256, User>;
  length: Int as uint256 = 0;
  MAX_SIZE: Int as uint256 = 5_000_000;
}

extends mutates fun append(self: Users, user: User): User {
  require(self.length + 1 <= self.MAX_SIZE, "cannot exceed threshhold");
  self.map.set(self.length, user);
  self.length += 1;
  return self.map.get(self.length - 1)!!;
}

extends mutates fun insertAtIndex(self: Users, index: Int, user: User): User {
  require(self.length + 1 <= self.MAX_SIZE, "cannot exceed threshhold");
  require(index >= 0, "index cannot be negative");
  require(index < self.length, "index is out of bounds");

  let i: Int = self.length;

  while (i > index) {
    self.map.set(i, self.map.get(i - 1)!!);
    i -= 1;
  }

  self.map.set(index, user);
  self.length += 1;
  return self.map.get(index)!!;
}

extends fun getById(self: Users, id: Int): User? {
  let user: User? = null;
  let index: Int = 0;


  while (index < self.length - 1 && user == null) {
    let u: User = self.map.get(index)!!;

    if (u.id == id) {
      user = u;
    } else {
      index += 1;
    }
  }

  return user;
}

extends mutates fun deleteById(self: Users, id: Int): User? {
  let user: User? = null;
  let index: Int = 0;


  while (index < self.length - 1 && user == null) {
    let u: User = self.map.get(index)!!;

    if (u.id == id) {
      user = u;
    } else {
      index += 1;
    }
  }

  require(user != null, "user not found");
  self.map.set(index, null);
  self.length -= 1;

  let shiftIndex: Int = index;

  while (shiftIndex < self.length - 1) {
    self.map.set(shiftIndex, self.map.get(shiftIndex + 1));
    shiftIndex += 1;
  }

  return user;
}

extends mutates fun deleteAll(self: Users): Int {
  require(self.length > 0 , "not items to delete");
  self.map = emptyMap();

  let lengthReference: Int = self.length;
  self.length = 0;

  return lengthReference;
}
