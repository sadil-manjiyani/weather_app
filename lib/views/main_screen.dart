import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/utils/colors.dart';
import 'package:weather_app/view_models/location_view_model.dart';
import 'package:weather_app/view_models/weather_view_model.dart';
import 'package:weather_app/widgets/custom_buttons.dart';
import 'package:weather_app/widgets/custom_text_fields.dart';
import 'package:weather_app/widgets/loading_screen.dart';
import 'package:weather_app/widgets/space.dart';
import 'package:weather_app/widgets/toast_messages.dart';

import '../utils/functions.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  WeatherViewModel weatherViewModel=Get.put(WeatherViewModel());
  LocationViewModel locationViewModel=Get.put(LocationViewModel());

  RxBool loading=false.obs;
  RxBool isDataAvailable=false.obs;
  //Header Widget Variables
  TextEditingController searchController=TextEditingController();
  WeatherModel? weatherModel;
  RxBool isConnected=true.obs;

  //temperature Variables
  RxString currentTemp="".obs;
  RxString minTemp="".obs;
  RxString maxTemp="".obs;
  RxString feelsLike="".obs;
  RxString humidity="".obs;
  RxString pressure="".obs;
  RxString location="".obs;
  RxString sunrise="".obs;
  RxString sunset="".obs;
  RxInt sunriseTime=0.obs;
  RxInt sunsetTime=0.obs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation();
  }

  getLocation() async {
    isConnected.value=await locationViewModel.checkInternetConnection();
    if(isConnected.value){
      loading.value=true;
      await locationViewModel.getCurrentPosition();
      Position position=locationViewModel.currentPosition!;
      var weatherData=await weatherViewModel.getDataPosition(position);
      weatherModel=weatherData;
      if(weatherModel?.temperatureModel!=null && weatherModel?.additionalDataModel!=null){
        setData();
        location.value="Current Location";
        isDataAvailable.value=true;
      }else{
        isDataAvailable.value=false;
      }
      loading.value=false;
    }else{
      normalToast("Internet Not Connected! Cannot Fetch data");
    }

  }

  setData(){
    currentTemp.value=weatherModel?.temperatureModel?.temp.toString().substring(0,2)??"NA";
    minTemp.value="${weatherModel?.temperatureModel?.tempmin.toString().substring(0,2)}°";
    maxTemp.value="${weatherModel?.temperatureModel?.tempmax.toString().substring(0,2)}°";
    feelsLike.value="${weatherModel?.temperatureModel?.feelslike.toString().substring(0,2)}°";
    humidity.value="${weatherModel?.temperatureModel?.humidity.toString()}%";
    pressure.value= "${weatherModel?.temperatureModel?.pressure.toString()} hpa";
    sunriseTime.value=weatherModel?.additionalDataModel?.sunrise??1000;
    sunsetTime.value=weatherModel?.additionalDataModel?.sunset??1000;

    sunrise.value=formatIntToDateString(
        sunriseTime.value,
        weatherViewModel.timeZoneDifference.value
    );
    sunset.value=formatIntToDateString(
        sunsetTime.value
        ,weatherViewModel.timeZoneDifference.value
    );
    location.value=searchController.text;
  }

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.sizeOf(context);
    return SafeArea(
      child: Scaffold(
        //Added This extra container to center in
        body: Container(
          alignment: Alignment.center,
          color: Colors.blue.shade50,
          child: Container(
            height: size.height,
            width: size.width<821?size.width:820,
            decoration: const BoxDecoration(
            gradient: backgroundLinearGradient,
            ),
            child:Obx(
                ()=>loading.value?const LoadingScreen():mainBody(),
            )
          ),
        )
      ),
    );
  }

Widget mainBody(){
    return RefreshIndicator(
      onRefresh: () {
        if(location.value=="Current Location"){
          return getLocation();
        }
        else{
          return getWeatherData(location.value);
        }
      },
      child: Stack(
        children: [
//ListView is added to Achieve pull to refresh
          ListView(),
          SizedBox(
            height: MediaQuery.sizeOf(context).height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //Header - Searchbar and Search Button
                headerWidget(),
                addVerticalSpace(50),
                //TemperatureDisplay
                Obx(
                    ()=> isDataAvailable.value?
                  temperatureWidget():
                  defaultWidget("Search to Get Weather Updates"),
                ),

                addVerticalSpace(50),
                //Additional Information
                Obx(
                    ()=> isDataAvailable.value?
                  Expanded(child: additionalDataWidget()): Expanded(child: defaultWidget("")),
                ),
              ],
            ),
          ),
        ],
      ),
    );
}

Widget headerWidget(){
    return Container(
      padding: const EdgeInsets.all(12),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: CustomTextField(
            hint: 'Enter City Name',
              controller: searchController,
            ),
          ),
          addHorizontalSpace(10),
          SizedBox(
            width: 45,
            height: 45,
            child: DefaultButton(
              onTap: (){
               getWeatherData(searchController.text);
              },
              child: const Icon(
                  Icons.search,
                color: textColor,
              ),
            ),
          )
        ],
      ),
    );
}
Widget temperatureWidget(){
    return SizedBox(
      height: MediaQuery.sizeOf(context).height*0.3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Obx(
                  ()=> Text(
                    "${currentTemp.toString()}°",
                    style: const TextStyle(
                      color: textColor,
                      fontSize: 48,
                      fontWeight: FontWeight.w700,

                    ),
            ),
          ),
          addVerticalSpace(5),
          Obx(
                  ()=> Text(
                      location.value,
                    style: const TextStyle(
                      color: textColorSecondary,
                      fontSize: 32,
                      fontWeight: FontWeight.w600
                    ),
                  )
          ),
        ],
      ),
    );
}
Widget additionalDataWidget(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        padding: const EdgeInsets.all(12),
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow:  [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 5,
              spreadRadius: 1

            )
          ]
        ),
        child:  SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  //Feels like
                  dataContainer(
                      "Feels Like",
                      feelsLike
                  ),
                  Container(
                    height: 50,
                    width: 1,
                    color: Colors.black,
                  ),
                  //Min Temp
                  dataContainer(
                      "Minimum",
                      minTemp,
                  ),
                  Container(
                    height: 50,
                    width: 1,
                    color: Colors.black,
                  ),
                  //Max Temp
                  dataContainer(
                      "Maximum",
                      maxTemp
                  ),
                ],
              ),
              addVerticalSpace(20),
              Row(
                children: [
                  //Pressure
                  dataContainer("Pressure", pressure),
                  const Divider(
                    height: 50,
                  ),
                  //Humidity
                  dataContainer("Humidity",humidity),
                ],
              ),
              addVerticalSpace(20),
              Row(
                children: [
                  //Pressure
                  dataContainer("Sun Rise", sunrise),
                  const Divider(
                    height: 50,
                  ),
                  //Humidity
                  dataContainer("Sun Set",sunset),
                ],
              )

            ],
          ),
        ),
      ),
    );
}

Widget defaultWidget(message){
    return SizedBox(
      height: MediaQuery.sizeOf(context).height*0.3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(message,style: const TextStyle(
            fontSize: 16,
          ),),
        ],
      ),
    );
}

Widget dataContainer(dataFor,RxString value){
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            Text(dataFor),
            Obx(()=> Text(value.value))
          ],
        ),
      ),
    );
}

getWeatherData(loc) async
{
  isConnected.value=await locationViewModel.checkInternetConnection();
  if(isConnected.value){
    loading.value=true;
    var weatherData = await weatherViewModel.getData(loc);
    loading.value=false;
    weatherModel=weatherData;
    if(weatherData!=null){
      isDataAvailable.value=true;
      setData();
    }else{
      isDataAvailable.value=false;
    }
    searchController.clear();
    location.value=loc;
  }else{
    normalToast("Internet Not Connected! Cannot Fetch data");
  }


}

}


