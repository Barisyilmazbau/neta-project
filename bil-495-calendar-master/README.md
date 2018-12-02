# README
heroku url: https://guarded-bayou-90785.herokuapp.com/appointments
* Ruby version:2.3.3

Appointment creating post request curl example:
curl --header "Content-Type: application/json" --request POST --data '{"description":"test","date":"2018-06-07T09:31:00.000Z", "recursive":false, "recurseDays":null}' https://guarded-bayou-90785.herokuapp.com/appointments.json

So you need to add header "Content-Type: application/json" and data {"description":"String","date":"YYYY-MM-DDTHH:MM:SS.000Z", "recursive":Boolean, "recurseDays":Integer} then make request to app url.

Appointment searching post request curl example:
curl --header "Content-Type: application/json" --request POST --data '{"description":"test","date":"2018-06-07T09:31:00.000Z", "recursive":false, "recurseDays":null}' https://guarded-bayou-90785.herokuapp.com/appointmentsSearch.json

In this request only the description value matters. Date and recursive parameters do not affect the query.
