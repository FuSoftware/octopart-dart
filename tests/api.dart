
import '../lib/api.dart';
import "package:test/test.dart";
import 'dart:convert';

void startTests(){
  group('JSON', () {
    test('PartsMatchQuery loads correctly', () {
      Map oJson = {
        'q' : 'a',
        'mpn' : 'b',
        'brand' : 'c',
        'sku' : 'd',
        'seller' : 'e',
        'mpn_or_sku' :  'f',
        'start' : 10,
        'limit' : 11,
        'reference' : 'g',
      };

      var query = PartsMatchQuery.fromJson(oJson);
      expect(query.toJson(), equals(oJson));
      expect(query.jsonString, equals(json.encode(oJson)));
    });
  });
}