part of dartcoin.core;


/**
 * This interface defines the basic functionality a Wallet definition should have.
 */
abstract class Wallet {
  
  NetworkParameters get params;
  
  Iterable<KeyPair> get keys;
  
  /**
   * Use either [KeyPair] or [Uint8List] to describe the (public) key.
   */
  bool hasKey(dynamic key) {
    if(key is Uint8List)
      key = new KeyPair(key);
    if(!(key is KeyPair)) throw new Exception("Invalid parameter type.");
    return keys.contains(key);
  }
  
  bool hasAddress(Address address) => 
      keys.any( (KeyPair key) => address == key.toAddress(params) );
  
  KeyPair getKeyFromAddress(Address address) => 
      keys.singleWhere((KeyPair kp) => kp.toAddress(params) == address);
  
  bool isTransactionRelevant(Transaction tx) {
    for(TransactionInput input in tx.inputs) {
      // PayToAddressInputScript
      try {
        if(hasKey(new PayToPubKeyHashInputScript.convert(input.scriptSig).pubKey)) return true;
      } on ScriptException {}
      // PayToPubKeyInput
      try {
        TransactionSignature sig = new PayToPubKeyInputScript.convert(input.scriptSig).signature;
        for(int i = 0 ; i < 4 ; i++) {
          //TODO
          Sha256Hash message = null;
          if(hasKey(KeyPair.recoverFromSignature(i, sig, message)))
            return true;
        }
      } on ScriptException {}
    }
    for(TransactionOutput output in tx.outputs) {
      // PayToAddressOutputScript
      try {
        if(hasAddress(new PayToPubKeyHashOutputScript.convert(output.scriptPubKey).getAddress(params))) return true;
        continue;
      } on ScriptException {}
      // PayToPubKeyOutputScript
      try {
        if(hasKey(new PayToPubKeyOutputScript.convert(output.scriptPubKey).pubKey)) return true;
        continue;
      } on ScriptException {}
    }
  }
  
  // maybe
  bool isConsistent();
  
}