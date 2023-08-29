################################################################################
    extract object by field value from JSON (using jq)
################################################################################
Assume we want to extract all objects where "id" == "city":
{
  "status": 0,
  "data": [
    {
      "id": "city",
      "name": {
        "locales": [
          {
            "lang": "UA",
            "value": "Місто"
          },
          {
            "lang": "RU",
            "value": "Город"
          }
        ]
      },
      "min": -1,
      "max": -1,
      "type": "CITY"
    }
  ]
}

jq '.data[] | select(.id == "city")'



################################################################################
{
  "finalPortion": true,
  "activities": [
    {
      "id": "74061698098DB",
      "idFront": "74061698098",
      "idTran": "61624608872",
      "date": "17.08.2023 21:22:26",
      "update": "17.08.2023 21:22:26",
      "typeOper": "DB",
      "status": "p",
      "type": "other",
      "details": "Одяг: LIQPAY*LoveUnder",
      "category": "7",
      "categoryDetails": "Шопінг",
      "eventType": "089835",
      "amount": -3900.0,
      "originalAmount": 3900.0,
      "currency": "980",
      "originalAmountCurrency": "980",
      "card": "1111222233334444",
      "cashback": 0.0,
      "bonus": 0.0,
      "discount": 0.0,
      "bonusCurrency": "980",
      "discountCurrency": "840",
      "fee": 0.0,
      "feeCurrency": "980",
      "balance": 707.06,
      "paymentType": "AP",
      "countryCode": "804",
      "countryName": "UKR",
      "posInfo": {
        "term": "I0110INL",
        "name": "LIQPAY*LoveUnder",
        "addr": "LIQPAY*LOVEUNDER, DNIPRO, UA",
        "type": "Шопінг",
        "checkNum": "0303229661464536",
        "approval": "300093",
        "amt": -3900.0,
        "rest": 707.06,
        "rrn": 74061697987
      },
      "moneyBack": false,
      "can": "26251111222233980",
      "term": "I0110INL",
      "mcc": "5651",
      "source_table": "TRAN"
    }
  ]
}

cat .idea/httpRequests/2023-08-29T135236.200.json | jq '.activities[] | {id: .id, idFront: .idFront, idTran: .idTran, date: .date, update: .update, amount: .amount, balance: .balance, details: .details} | select(.balance > 500) | select(.balance <700)'

{
  "id": "73816835578DB",
  "idFront": "73816835578",
  "idTran": "61410641584",
  "date": "10.08.2023 19:17:07",
  "update": "10.08.2023 19:17:07",
  "amount": -71.15,
  "balance": 604.08,
  "details": "GIPERMARKET BUDMEN, KHARKIV"
}
...




