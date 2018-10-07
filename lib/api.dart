import 'dart:convert';

class Metadata {
  String type;
}

class PDFMetadata {
  int size_bytes;
  int num_pages;
  DateTime date_created;
  DateTime last_modified;
}

class CSVMetadata {
  int size_bytes;
  DateTime date_created;
  DateTime last_modified;
}

class ImageMetadata {
  int width;
  int height;
}

class Asset{
  String url;
  String mimetype;
  String metadata;

  Asset.fromJson(dynamic oJson){
    url = oJson['url'];
    mimetype = oJson['mimetype'];
    metadata = oJson['metadata'];
  }
}

class Attribution{
  DateTime first_acquired;
  List<Source> sources;

  Attribution.fromJson(dynamic oJson){
    first_acquired = DateTime.parse(oJson['first_acquired']);
    
    int c = oJson['sources'].length;
    for(int i=0; i<c; i++){
      this.sources.add(Source.fromJson(oJson['sources'][i]));
    }
  }
}

class Brand{
  String uid;
  String name;
  String homepage_url;

  Brand.fromJson(dynamic oJson){
    uid = oJson['uid'];
    name = oJson['name'];
    homepage_url = oJson['homepage_url'];
  }
}

class BrokerListing{
  String seller;
  String listing_url;
  String octopart_rfq_url;

  BrokerListing.fromJson(dynamic oJson) {
    seller = oJson['data'];
    listing_url = oJson['listing_url'];
    octopart_rfq_url = oJson['octopart_rfq_url'];
  }
}


class CADModel extends Asset{
  Attribution attribution;

  CADModel.fromJson(dynamic oJson) : super.fromJson(oJson) {
    this.attribution = Attribution.fromJson(oJson['attribution']);
  }
}

class Category{
  String uid;
  String name;
  String parent_uid;
  List<String> children_uid;
  List<String> ancestor_uid;
  List<String> ancestor_names;
  int num_parts;
  List<ImageSet> imagesets;

  Category.fromJson(dynamic oJson){
    uid = oJson['uid'];
    name = oJson['name'];
    parent_uid = oJson['parent_uid'];
    children_uid = oJson['children_uid'];
    ancestor_uid = oJson['ancestor_uid'];
    ancestor_names = oJson['ancestor_names'];
    num_parts = oJson['num_parts'];

    int c = oJson['imagesets'].length;

    for(int i=0; i<c; i++){
      this.imagesets.add(ImageSet.fromJson(oJson['imagesets'][i]));
    }
  }
}


enum ComplianceDocumentSubtypes {
  rohs_statement,
  reach_statement,
  materials_sheet,
  conflict_mineral_statement
}

class ComplianceDocument extends Asset {
  List<ComplianceDocumentSubtypes> subtypes;
  Attribution attribution;
}

class Datasheet extends Asset{
  Attribution attribution;
}

class Description {
  String value;
  Attribution attribution;
}

class ExternalLinks {
  String product_url;
  String freesample_url;
  String evalkit_url;
}

class ImageSet {
  Asset swatch_image;
  Asset small_image;
  Asset medium_image;
  Asset large_image;
  Attribution attribution;
  String credit_string;
  String credit_url;
}

class Manufacturer {
  String uid;
  String name;
  String homepage_url;
}

class Part {
  String uid;
  String mpn;
  Manufacturer manufacturer;
  Brand brand;
  String octopart_url;
  String external_links;
  
  //Pricing
  List<PartOffer> offers;
  BrokerListing broker_listings;

  //Description
  String short_description;
  List<Description> descriptions;
  List<ImageSet> imagesets;

  //Documents
  List<Datasheet> datasheets;
  List<ComplianceDocument> compliance_documents;
  List<ReferenceDesign> reference_designs;
  List<CADModel> cad_models;

  //Specs
  Map<String, SpecValue> specs;
  List<String> category_uids;
}

class PartOffer {
  String sku;
  Seller seller;
  String eligible_region;
  String product_url;
  String octopart_rfq_url;
  Map<String, Map<int, double>> prices;
  int in_stock_quantity;
  int on_order_quantity;
  DateTime on_order_eta;
  int factory_lead_days;
  int factory_order_multiple;
  int order_multiple;
  int moq;
  String multipack_quantity;
  String packaging;
  bool is_authorized;
  DateTime last_updated;
}

class SpecValue {
  double value;
  double min_value;
  double max_value;
  SpecMetadata metadata;
  Attribution attribution;
}

class ReferenceDesign extends Asset {
  String title;
  String description;
  Attribution attribution;
}

class Seller {
  String uid;
  String name;
  String homepage_url;
  String display_flag;
  bool has_ecommerce;
}

class Source {
  String uid;
  String name;
}

class SpecMetadata{
  String key;
  String name;
  String datatype;
  UnitOfMeasurement unit;
}

class UnitOfMeasurement {
  String name;
  String symbol;
}

class PartsMatchRequest {
  List<PartsMatchQuery> queries;
  bool exact_only = false;
}

class PartsMatchQuery {
  String q;
  String mpn;
  String brand;
  String sku;
  String seller;
  String mpn_or_sku;
  int start = 0;
  int limit = 10;
  String reference;

  String get toJson {
    dynamic query;

    if(q.isNotEmpty) query.q = q;
    if(mpn.isNotEmpty) query.mpn = mpn;
    if(brand.isNotEmpty) query.brand = brand;
    if(sku.isNotEmpty) query.sku = sku;
    if(seller.isNotEmpty) query.seller = seller;
    if(mpn_or_sku.isNotEmpty) query.mpn_or_sku = mpn_or_sku;

    query.start = start;
    query.limit = limit;

    return json.encode(query);
  }
}

class PartsMatchResponse {
  PartsMatchRequest request;
  List<PartsMatchResult> results;
  int msec;
}

class PartsMatchResult {
  List<Part> items;
  int hits;
  String reference;
  String error;
}

class SearchRequest {
  String q;
  int start;
  int limit;
  String sortby;
}

class SearchResponse {
  SearchRequest request;
  List<SearchResult> results;
  int hits;
  int msec;
}

class SearchResult {
  Brand item;
}

class API {
  String apiKey = '';
  String baseUrl = 'https://octopart.com/api/v3/';

  dynamic endpoints = {
    'parts' : {
      'search' : '/parts/search',
      'match' : '/parts/march'
    },
    'brands' : {
      'root' : '/brands/',
      'search' : '/brands/search',
      'get_multi' : '/brands/get_multi'
    }
  };
  
  query(dynamic queries){

  }

  partsSearch(){

  }
}