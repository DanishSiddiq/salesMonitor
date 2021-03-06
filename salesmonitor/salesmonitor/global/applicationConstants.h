//
//  applicationConstants.h
//  salesmonitor
//
//  Created by goodcore2 on 6/4/13.
//  Copyright (c) 2013 GoodCore. All rights reserved.
//

#ifndef salesmonitor_applicationConstants_h
#define salesmonitor_applicationConstants_h
#endif

#define KEY_SERVER_MAIN_URL             @"http://sales-monitor.herokuapp.com/"

#define KEY_SERVER_URL_LOGIN            KEY_SERVER_MAIN_URL @"login"
#define KEY_SERVER_REPORT_SALE          KEY_SERVER_MAIN_URL @"api/salesRep/%@/salesTrend?startDate=%@&endDate=%@&productId=%@"
#define KEY_SERVER_URL_DOCTOR_ADD       KEY_SERVER_MAIN_URL @"api/salesRep/%@/doctor"
#define KEY_SERVER_URL_DOCTOR_UPDATE    KEY_SERVER_MAIN_URL @"api/doctor/%@"
#define KEY_SERVER_URL_DOCTOR_DELETE    KEY_SERVER_MAIN_URL @"api/doctor/%@"
#define KEY_SERVER_URL_REPORT_ADVANCE   KEY_SERVER_MAIN_URL @"main-ipad"

// local notifications
// local notifications
#define NOTIFICATION_NETWORK_DISCONNECTED       @"atmnavigator.localnotification.network.disconnected"


// graph keys
#define KEY_GRAPH_BAR_BUDGET_COLOR              @"0F00F0"
#define KEY_GRAPH_BAR_BUDGET_COLOR_ALTERNATE    @"FF9900"


#define KEY_GRAPH_XML_FILE_UNIT     @"barChartUnit.xml"
#define KEY_GRAPH_XML_FILE_VALUE    @"barChartValue.xml"

// error in network calls
#define KEY_ERROR @"error"

// data triversing
#define KEY_USER_ID     @"_id"

#define KEY_PATH_PRODUCT_BUSINESS       @"businessUnitId.products"
#define KEY_PRODUCT_NAME                @"productName"
#define KEY_PRODUCT_PRICE               @"price"
#define KEY_PRODUCT_THERAPUTIC_CLASS    @"theraputicClass"
#define KEY_PRODUCT_INDICATION          @"indication"
#define KEY_PRODUCT_PACKSHOT            @"packShot"
#define KEY_PRODUCT_ID                  @"_id"
#define KEY_PRODUCT_SALES_UNIT          @"salesUnit"
#define KEY_PRODUCT_BUDGET_UNITS        @"budgetUnits"


#define KEY_BRICKS @"bricks"
#define KEY_BRICKS_SALES                @"sales"
#define KEY_BRICKS_NAME                 @"name"
#define KEY_BRICKS_DISTRIBUTOR_NAME     @"distributorName"
#define KEY_BRICKS_LOCATION             @"location"
#define KEY_BRICKS_LOCATION_LAT         @"lat"
#define KEY_BRICKS_LOCATION_LONG        @"long"
#define KEY_BRICKS_PRODUCT_NAME         @"productName"
#define KEY_BRICKS_PRODUCT_PRICE        @"price"
#define KEY_BRICKS_PRODUCT_SALES_UNIT   @"salesUnit"
#define KEY_BRICKS_PRODUCT_TOTAL_SALE   @"salesValue"

#define KEY_PATH_BRICKS_LOCATION_LAT    @"location.lat"
#define KEY_PATH_BRICKS_LOCATION_LONG   @"location.long"


#define KEY_SALES_YEAR          @"year"
#define KEY_SALES_MONTH         @"month"
#define KEY_SALES_MONTH_NUMBER  @"monthNumber"
#define KEY_SALES_BUDGET_UNIT   @"budgetUnits"
#define KEY_SALES_BUDGET_VALUE  @"budgetValue"
#define KEY_SALES_UNIT          @"salesUnit"
#define KEY_SALES_VALUE         @"salesValue"


#define KEY_DOCTOR_ADD          @"doctor"
#define KEY_DOCTORS             @"doctors"
#define KEY_DOCTORS_ID          @"_id"
#define KEY_DOCTORS_IMAGE       @"image"
#define KEY_DOCTORS_NAME        @"name"
#define KEY_DOCTORS_ADDRESS     @"address"
#define KEY_DOCTORS_PHONE       @"phone"
#define KEY_DOCTORS_EMAIL       @"email"
#define KEY_DOCTORS_SPECIALITY  @"speciality"




