part of dartcoin.json;

class JSONEncoder {
  
  /**
   * This method can be used by the `JsonCodec.encode` method from dart:convert.
   */
  toEncodable(Object object) {
    if(object is Block)
      return _mapFromBlock(object);
    if(object is Transaction)
      return _mapFromTransaction(object);
    //TODO throw?
  }
  
  
  /*****************************
   * Actual to-string encoders *
   *****************************/
  // and auxilary methods.
  
  /**
   * Encode a block.
   */
  String encodeBlock(Block block) {
    return stringify(_mapFromBlock(block));
  }
  
  Map<String, String> _mapFromBlock(Block block) {
    Map<String, String> json = new HashMap<String, String>();
    json["version"]    = stringify(block.version);
    json["time"]       = stringify(block.timestamp);
    json["hash"]       = stringify(block.hash.toString());
    json["height"]     = stringify(block.height);
    json["merkleroot"] = stringify(block.merkleRoot.toString());
    json["nonce"]      = stringify(block.nonce);
    json["bits"]       = stringify(block.bits);
    json["difficulty"] = stringify(""); //TODO
    json["size"]       = stringify(0); //TODO
    return json;
  }
  
  /**
   * Encode a transaction.
   */
  String encodeTransaction(Transaction transaction) {
    return stringify(_mapFromTransaction(transaction));
  }
  
  Map<String, String> _mapFromTransaction(Transaction transaction) {
    Map<String, String> json = new HashMap<String, String>();
    json["txid"]          = stringify(transaction.txid.toString());
    json["blockhash"]     = stringify(""); //TODO
    json["block"]         = stringify(0); //TODO
    json["blockindex"]    = stringify(0);; //TODO
    json["confirmations"] = stringify(0); //TODO
    json["amount"]        = stringify(transaction.amount);
    json["fee"]           = stringify(transaction.fee);
    Map<String, String> details = new HashMap<String, String>();
    //TODO complete
    return json;
  }
  
}