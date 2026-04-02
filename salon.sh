#! /bin/bash
PSQL="psql --username=freecodecamp --dbname=salon -t --no-align -q -c"
echo -e "\n~~~~~ MY SALON ~~~~~\n"

MENU(){
echo -e "\nWelcome to My Salon, how can I help you?\n"
echo "1) $($PSQL "SELECT name from services WHERE service_id=1;")"
echo "2) $($PSQL "SELECT name from services WHERE service_id=2;")"
echo "3) $($PSQL "SELECT name from services WHERE service_id=3;")"
echo "4) $($PSQL "SELECT name from services WHERE service_id=4;")"
echo "5) $($PSQL "SELECT name from services WHERE service_id=5;")"
read SERVICE_ID_SELECTED
case $SERVICE_ID_SELECTED in 
1)
;; 
2)
;;
3)
;;
4)
;;
5)
;;
*)
echo "I could not find that service."
MENU
;;
esac
}
MENU
PHONE(){
echo -e "\nWhat's your phone number?"
read CUSTOMER_PHONE
PHONE_NUMBER=$($PSQL "SELECT phone FROM customers where phone='$CUSTOMER_PHONE';")
if [[ $CUSTOMER_PHONE != $PHONE_NUMBER ]]
	then	
		echo -e "\nI don't have a record for that phone number, what's your name?"
		read CUSTOMER_NAME
		($PSQL "INSERT INTO customers(phone,name) values ('$CUSTOMER_PHONE','$CUSTOMER_NAME');")
		echo -e "\nWhat time would you like your $($PSQL "SELECT name from services WHERE service_id=$SERVICE_ID_SELECTED;"), $CUSTOMER_NAME?"
		read SERVICE_TIME
		($PSQL "INSERT INTO appointments(customer_id,service_id,time) values ((SELECT customer_id from customers where name='$CUSTOMER_NAME'),$SERVICE_ID_SELECTED,'$SERVICE_TIME');")
		echo -e "\nI have put you down for a $($PSQL "SELECT name from services WHERE service_id=$SERVICE_ID_SELECTED;") at $SERVICE_TIME, $CUSTOMER_NAME."

elif [[ $CUSTOMER_PHONE == $PHONE_NUMBER ]]
	then	
		echo -e "\nWhat time would you like your $($PSQL "SELECT name from services WHERE service_id=$SERVICE_ID_SELECTED;"), $($PSQL "SELECT name from customers where phone='$CUSTOMER_PHONE';")?"
		read SERVICE_TIME2
		($PSQL "INSERT INTO appointments(customer_id,service_id,time) values ((SELECT customer_id from customers where phone='$PHONE_NUMBER'),$SERVICE_ID_SELECTED,'$SERVICE_TIME2');")
		echo -e "\nI have put you down for a $($PSQL "SELECT name from services WHERE service_id=$SERVICE_ID_SELECTED;") at $SERVICE_TIME2, $($PSQL "SELECT name from customers where phone='$CUSTOMER_PHONE';")."
fi
}
PHONE





