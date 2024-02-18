class AvailabilityModel {
  String? availabilityId;
  String? availabilityHotelid;
  String? availabilityRoomid;
  String? availabilityGroup;
  String? availabilityMealplan;
  String? availabilityValue;

  AvailabilityModel(
      {this.availabilityId,
      this.availabilityHotelid,
      this.availabilityRoomid,
      this.availabilityGroup,
      this.availabilityMealplan,
      this.availabilityValue});

  AvailabilityModel.fromJson(Map<String, dynamic> json) {
    availabilityId = json['availability_id'];
    availabilityHotelid = json['availability_hotelid'];
    availabilityRoomid = json['availability_roomid'];
    availabilityGroup = json['availability_group'];
    availabilityMealplan = json['availability_mealplan'];
    availabilityValue = json['availability_value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['availability_id'] = this.availabilityId;
    data['availability_hotelid'] = this.availabilityHotelid;
    data['availability_roomid'] = this.availabilityRoomid;
    data['availability_group'] = this.availabilityGroup;
    data['availability_mealplan'] = this.availabilityMealplan;
    data['availability_value'] = this.availabilityValue;
    return data;
  }
}
