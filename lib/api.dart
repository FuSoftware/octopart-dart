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

  ComplianceDocument.fromJson(dynamic oJson) : super.fromJson(oJson) {
    this.attribution = Attribution.fromJson(oJson['attribution']);
    int c = oJson['subtypes'].length;

    for(int i=0; i<c; i++){
      this.subtypes.add(oJson['subtypes'][i]);
    }
  }
}

class Datasheet extends Asset{
  Attribution attribution;

  Datasheet.fromJson(dynamic oJson) : super.fromJson(oJson) {
    this.attribution = Attribution.fromJson(oJson['attribution']);
  }
}

class Description {
  String value;
  Attribution attribution;

  Description.fromJson(dynamic oJson) {
    this.value = oJson['value'];
    this.attribution = Attribution.fromJson(oJson['attribution']);
  }
}

class ExternalLinks {
  String product_url;
  String freesample_url;
  String evalkit_url;

  ExternalLinks.fromJson(dynamic oJson) {
    this.product_url = oJson['product_url'];
    this.freesample_url = oJson['freesample_url'];
    this.evalkit_url = oJson['evalkit_url'];
  }
}

class ImageSet {
  Asset swatch_image;
  Asset small_image;
  Asset medium_image;
  Asset large_image;
  Attribution attribution;
  String credit_string;
  String credit_url;

  ImageSet.fromJson(dynamic oJson) {
    this.swatch_image = Asset.fromJson(oJson['swatch_image']);
    this.small_image = Asset.fromJson(oJson['small_image']);
    this.medium_image = Asset.fromJson(oJson['medium_image']);
    this.swatch_image = Asset.fromJson(oJson['swatch_image']);
    this.attribution = Attribution.fromJson(oJson['attribution']);
    this.credit_string = oJson['credit_string'];
    this.credit_url = oJson['credit_url'];
  }
}

class Manufacturer {
  String uid;
  String name;
  String homepage_url;

  Manufacturer.fromJson(dynamic oJson) {
    this.uid = oJson['uid'];
    this.name = oJson['name'];
    this.homepage_url = oJson['homepage_url'];
  }
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

  Part.fromJson(dynamic oJson){
    this.uid = oJson['uid'];
    this.mpn = oJson['mpn'];
    this.manufacturer = Manufacturer.fromJson(oJson['manufacturer']);
    this.brand = Brand.fromJson(oJson['brand']);
    this.octopart_url = oJson['octopart_url'];
    this.external_links = oJson['external_links'];

    //Pricing
    this.offers.clear();
    for(var i=0;i<oJson['offers'].length;i++) this.offers.add(PartOffer.fromJson(oJson['offers'][i]));
  
    this.broker_listings = BrokerListing.fromJson(oJson['broker_listings']);

    //Description
    this.short_description = oJson['short_description'];

    this.descriptions.clear();
    for(var i=0;i<oJson['descriptions'].length;i++) this.descriptions.add(Description.fromJson(oJson['descriptions'][i]));

    this.imagesets.clear();
    for(var i=0;i<oJson['imagesets'].length;i++) this.imagesets.add(ImageSet.fromJson(oJson['imagesets'][i]));
    
    //Documents
    this.datasheets.clear();
    for(var i=0;i<oJson['datasheets'].length;i++) this.datasheets.add(Datasheet.fromJson(oJson['datasheets'][i]));

    this.compliance_documents.clear();
    for(var i=0;i<oJson['compliance_documents'].length;i++) this.compliance_documents.add(ComplianceDocument.fromJson(oJson['compliance_documents'][i]));

    this.reference_designs.clear();
    for(var i=0;i<oJson['reference_designs'].length;i++) this.reference_designs.add(ReferenceDesign.fromJson(oJson['reference_designs'][i]));

    this.cad_models.clear();
    for(var i=0;i<oJson['cad_models'].length;i++) this.cad_models.add(CADModel.fromJson(oJson['cad_models'][i]));
    
    //Specs
    //TODO : Map<String, SpecValue> specs;

    this.category_uids.clear();
    for(var i=0;i<oJson['category_uids'].length;i++) this.category_uids.add(oJson['category_uids'][i]);
  }
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

  PartOffer.fromJson(dynamic oJson) {
    sku = oJson['sku'];
    seller = Seller.fromJson(oJson['seller']);
    eligible_region = oJson['eligible_region'];
    product_url = oJson['product_url'];
    octopart_rfq_url = oJson['octopart_rfq_url'];
    //TODO : Map<String, Map<int, double>> prices;
    in_stock_quantity = oJson['in_stock_quantity'];
    on_order_quantity = oJson['on_order_quantity'];
    on_order_eta = DateTime.parse(oJson['on_order_eta']);
    factory_lead_days = oJson['factory_lead_days'];
    factory_order_multiple = oJson['factory_order_multiple'];
    order_multiple = oJson['order_multiple'];
    moq = oJson['moq'];
    multipack_quantity = oJson['multipack_quantity'];
    packaging = oJson['packaging'];
    is_authorized = oJson['is_authorized'];
    last_updated = DateTime.parse(oJson['last_updated']);
  }
}

class SpecValue {
  double value;
  double min_value;
  double max_value;
  SpecMetadata metadata;
  Attribution attribution;

  SpecValue.fromJson(dynamic oJson){
    value = oJson['value'];
    min_value = oJson['min_value'];
    max_value = oJson['max_value'];
    metadata = SpecMetadata.fromJson(oJson['metadata']);
    attribution = Attribution.fromJson(oJson['attribution']);
  }
}

class ReferenceDesign extends Asset {
  String title;
  String description;
  Attribution attribution;

  ReferenceDesign.fromJson(dynamic oJson) : super.fromJson(oJson){
    title = oJson['title'];
    description = oJson['description'];
    attribution = Attribution.fromJson(oJson['attribution']);
  }
}

class Seller {
  String uid;
  String name;
  String homepage_url;
  String display_flag;
  bool has_ecommerce;

  Seller.fromJson(dynamic oJson) {
    uid = oJson['uid'];
    name = oJson['name'];
    homepage_url = oJson['homepage_url'];
    display_flag = oJson['display_flag'];
    has_ecommerce = oJson['has_ecommerce'];
  }
}

class Source {
  String uid;
  String name;

  Source.fromJson(dynamic oJson) {
    uid = oJson['uid'];
    name = oJson['name'];
  }
}

class SpecMetadata{
  String key;
  String name;
  String datatype;
  UnitOfMeasurement unit;

  SpecMetadata.fromJson(dynamic oJson) {
    key = oJson['key'];
    name = oJson['name'];
    datatype = oJson['datatype'];
    unit = UnitOfMeasurement.fromJson(oJson['unit']);
  }
}

class UnitOfMeasurement {
  String name;
  String symbol;

  UnitOfMeasurement.fromJson(dynamic oJson) {
    name = oJson['name'];
    symbol = oJson['symbol'];
  }
}

class PartsMatchRequest {
  List<PartsMatchQuery> queries;
  bool exact_only = false;

  PartsMatchRequest.fromJson(dynamic oJson){
    this.queries.clear();
    for(var i=0;i<oJson['queries'].length;i++) this.queries.add(PartsMatchQuery.fromJson(oJson['queries'][i]));
    exact_only = oJson['exact_only'];
  }
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

  PartsMatchQuery.fromJson(dynamic oJson){
    q = oJson['q'];
    mpn = oJson['mpn'];
    brand = oJson['brand'];
    sku = oJson['sku'];
    seller = oJson['seller'];
    mpn_or_sku = oJson['mpn_or_sku'];
    start = oJson['start'];
    limit = oJson['limit'];
    reference = oJson['reference'];
  }

  String get jsonString{
    return json.encode(this.toJson());
  }

  Map toJson() {
    Map map = new Map();

    if(q.isNotEmpty) map['q'] = q;
    if(mpn.isNotEmpty) map['mpn'] = mpn;
    if(brand.isNotEmpty) map['brand'] = brand;
    if(sku.isNotEmpty) map['sku'] = sku;
    if(seller.isNotEmpty) map['seller'] = seller;
    if(mpn_or_sku.isNotEmpty) map['mpn_or_sku'] = mpn_or_sku;
    map['start'] = start;
    map['limit'] = limit;
    if(reference.isNotEmpty) map['reference'] = reference;

    return map;
  }
}

class PartsMatchResponse {
  PartsMatchRequest request;
  List<PartsMatchResult> results;
  int msec;

  PartsMatchResponse.fromJson(dynamic oJson){
    request = PartsMatchRequest.fromJson(oJson['request']);
    this.results.clear();
    for(var i=0;i<oJson['results'].length;i++) this.results.add(PartsMatchResult.fromJson(oJson['results'][i]));
    msec = oJson['msec'];
  }
}

class PartsMatchResult {
  List<Part> items;
  int hits;
  String reference;
  String error;

  PartsMatchResult.fromJson(dynamic oJson){
    for(var i=0;i<oJson['items'].length;i++) this.items.add(Part.fromJson(oJson['items'][i]));
    hits = oJson['hits'];
    reference = oJson['reference'];
    error = oJson['error'];
  }
}

class SearchRequest {
  String q;
  int start;
  int limit;
  String sortby;

  SearchRequest.fromJson(dynamic oJson){
    q = oJson['q'];
    start = oJson['start'];
    limit = oJson['limit'];
    sortby = oJson['sortby'];
  }

  String get toJson {
    dynamic query;

    if(q.isNotEmpty) query.q = q;
    if(sortby.isNotEmpty) query.sortby = sortby;

    query.start = start;
    query.limit = limit;

    return json.encode(query);
  }
}

class SearchResponse {
  SearchRequest request;
  List<SearchResult> results;
  int hits;
  int msec;

  SearchResponse.fromJson(dynamic oJson){
    request = SearchRequest.fromJson(oJson['request']);
    for(var i=0;i<oJson['results'].length;i++) this.results.add(SearchResult.fromJson(oJson['results'][i]));
    hits = oJson['hits'];
    msec = oJson['msec'];
  }
}

class SearchResult {
  Brand item;

  SearchResult.fromJson(dynamic oJson){
    item = Brand.fromJson(oJson['item']);
  }
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
