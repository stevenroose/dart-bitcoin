part of dartcoin.core;

class Units {
  
  static BigInteger toSatoshi(num bitcoins) {
    return new BigInteger(bitcoins) * new BigInteger(10).pow(8);
  }
  
  static num toBitcoins(BigInteger satoshi) {
    return (satoshi / new BigInteger(10).pow(8)).intValue() + 
        (satoshi % new BigInteger(10).pow(8)).intValue()/pow(10,8);
  }
}