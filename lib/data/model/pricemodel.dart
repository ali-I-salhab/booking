class PriceModel {
  String? priceId;
  String? priceRoomid;
  String? priceMealplan;
  String? priceGroup;
  String? priceValue;
  String? pricePeriod;
  String? priceHotelid;

  PriceModel(
      {this.priceId,
      this.priceRoomid,
      this.priceMealplan,
      this.priceGroup,
      this.priceValue,
      this.pricePeriod,
      this.priceHotelid});

  PriceModel.fromJson(Map<String, dynamic> json) {
    priceId = json['price_id'];
    priceRoomid = json['price_roomid'];
    priceMealplan = json['price_mealplan'];
    priceGroup = json['price_group'];
    priceValue = json['price_value'];
    pricePeriod = json['price_period'];
    priceHotelid = json['price_hotelid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['price_id'] = this.priceId;
    data['price_roomid'] = this.priceRoomid;
    data['price_mealplan'] = this.priceMealplan;
    data['price_group'] = this.priceGroup;
    data['price_value'] = this.priceValue;
    data['price_period'] = this.pricePeriod;
    data['price_hotelid'] = this.priceHotelid;
    return data;
  }
}
