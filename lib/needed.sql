
create view hotelview as 
SELECT hotels.hotel_id,hotels.hotel_name ,
( SELECT COUNT(*) FROM mealplans where mealplans.mealplan_hotelid=hotel_id ) AS mealplnascount 
,( SELECT COUNT(*) FROM groups where groups.group_hotelid=hotel_id ) AS groupscount 
,( SELECT COUNT(*) FROM rooms where rooms.room_hotelid=hotel_id ) AS roomsscount 
,( SELECT COUNT(*) FROM rates where rates.rates_hotelid=hotel_id ) AS ratecount
,( SELECT COUNT(*) FROM addedusers where addedusers.user_hotelid=hotel_id ) AS userscount 
,( SELECT COUNT(*) FROM periods where periods.period_id=hotel_id ) AS periodsscount 
,( SELECT COUNT(*) FROM payment where payment.payment_hotelid=hotel_id ) AS paymentcount 
,( SELECT COUNT(*) FROM photos where photos.photo_hotelid=hotel_id ) AS phtoscount 

from hotels GROUP by hotels.hotel_id;

