mixin Mappable {
  // Abstract method to convert the object to a map
  Map<String, dynamic> toMap();

  // Static method to create an instance from a map
  static Mappable fromMap(Map<String, dynamic> map) {
    throw UnimplementedError('fromMap must be implemented in the subclass');
  }
}
