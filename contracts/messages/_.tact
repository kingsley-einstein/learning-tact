message AddUser {
  name: String;
  password: String;
}

message InsertAtIndex {
  name: String;
  password: String;
  index: Int as uint256;
}

message DeleteUser {
  id: Int as uint256;
}