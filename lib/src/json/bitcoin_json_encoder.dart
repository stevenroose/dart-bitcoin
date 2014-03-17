part of dartcoin.json;

class BitcoinJsonEncoder extends JsonEncoder {

  BitcoinJsonEncoder() : super(_toEncodable);
  BitcoinJsonEncoder.withIndent(String indent) : super.withIndent(indent, _toEncodable);
  
  /**
   * This method can be used by the `JsonCodec.encode` method from dart:convert.
   */
  static dynamic _toEncodable(dynamic object) {
    if(object is Block)
      return _mapFromBlock(object);
    if(object is Transaction)
      return _mapFromTransaction(object);
    //TODO complete
    return object.toJson();
  }
  
  
  /*****************************
   * Actual to-string encoders *
   *****************************/
  // and auxilary methods.
  
  /**
   * Encode a block.
   */
  String encodeBlock(Block block) {
    return convert(_mapFromBlock(block));
  }
  
  static Map<String, String> _mapFromBlock(Block block) {
    Map<String, dynamic> json = new HashMap<String, dynamic>()
      ..["version"]       = block.version
      ..["time"]          = block.timestamp
      ..["hash"]          = block.hash.toString()
      ..["height"]        = block.height
      ..["merkleroot"]    = block.merkleRoot.toString()
      ..["nonce"]         = block.nonce
      ..["bits"]          = CryptoUtils.bytesToHex(Utils.uintToBytesLE(block.difficultyTarget, 4))
      ..["difficulty"]    = 0 //TODO
      ..["size"]          = block.serializationLength
      ..["confirmations"] = 0;
    return json;
  }
  
  /**
   * Encode a transaction.
   */
  String encodeTransaction(Transaction transaction) {
    return convert(_mapFromTransaction(transaction));
  }
  
  static Map<String, String> _mapFromTransaction(Transaction transaction) {
    Map<String, dynamic> json = new HashMap<String, dynamic>()
      ..["txid"]            = transaction.txid.toString();
    if(transaction.block != null) {
      Block block = transaction.block;
      json["blockhash"]     = block.hash.toString();
      json["blockindex"]    = 0; //TODO
      json["confirmations"] = 0; //TODO
    }
    json["amount"]          = transaction.amount;
    json["fee"]             = transaction.fee;
    return json;
  }
  
}