abstract class Source {
  List<String> get lookupAddresses;
  bool doesAddressExistInLookup(String address);
}