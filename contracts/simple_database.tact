import "@stdlib/deploy";
import "@stdlib/ownable";
import "./types/_";
import "./messages/_";

contract SimpleDatabase with Deployable, Ownable {
  owner: Address;
  users: Users;
  
  init(maxSize: Int) {
    self.owner = sender();
    self.users = Users{ map: emptyMap() };
    self.users.MAX_SIZE = maxSize;
  }

  receive(msg: AddUser) {
    self.requireOwner();

    let id: Int = self.computeId();
    let newUser: User = User{ id: id, name: msg.name, password: msg.password };

    self.users.append(newUser);
  }

  receive(msg: InsertAtIndex) {
    self.requireOwner();

    let id: Int = self.computeId();
    let newUser: User = User{ id: id, name: msg.name, password: msg.password };

    self.users.insertAtIndex(msg.index, newUser);
  }

  receive(msg: DeleteUser) {
    self.requireOwner();

    self.users.deleteById(msg.id);
  }

  receive("__DELETE__ALL__") {
    self.requireOwner();

    let count: Int = self.users.deleteAll();
    let print: StringBuilder = beginString();

    print.append("Deleted: ");
    print.append(count.toString());
    dump(print.toString());
  }

  get fun userById(id: Int): User? {
    return self.users.getById(id);
  }

  get fun computeId(): Int {
    return sha256(now().toString());
  }

  get fun allUsers(): Users {
    return self.users;
  }

  get fun usersCount(): Int {
    return self.users.length;
  }
}