import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:weatherapp/data/image_path.dart';

import 'package:weatherapp/services/home_controller.dart';
import 'package:weatherapp/services/location.dart';
import 'package:weatherapp/services/weather_services_controller.dart';

import 'package:weatherapp/utils/apptext.dart';
import 'package:weatherapp/utils/custom_divider_page.dart';
import 'package:weatherapp/controllers/search_controller.dart' ;


class HomePage extends StatelessWidget {
 const HomePage({super.key});
 
 
     
  @override
  Widget build(BuildContext context) {
    
    final controller = Get.put(WController());
      final LocationController locationController = Get.put(LocationController());
     locationController.getCurrentLocation();
    //  print(locationController.locationName.value);
    final WeatherServicesController weatherServicesController = Get.put(WeatherServicesController());
  final homeController = Get.put(HomeController());
  homeController.onInit();
  
    
   
     Size size = MediaQuery.of(context).size;
 

    return  Scaffold(
      
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBar(),
      
      body: SingleChildScrollView(
         
        child: Column(
          children: [
            Obx(
              () => Container(
                
                height: size.height,
                width: size.width,
                decoration:  BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(background["${weatherServicesController.weatherDescription}" ?? "N/A"] ?? "assets/img/default.png"),
                     fit: BoxFit.cover,),
                ),
                child:Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                  
                        children: [
                          const Icon(Iconsax.location,color: Colors.red,),
                           const SizedBox(width: 16,),
                              Obx(
                                () => Column(
                                      children: [
                                          AppText(
                                            // data: 'Dubai',
                                      data: locationController.locationName.value != 'Unknown Location'
                                          ? locationController.locationName.value
                                          : 'Kollam', // Display loading text or handle null
                                      color: Colors.white,
                                      fw: FontWeight.w800,
                                      size: 24,
                                    ),
                                        AppText(data: "Good Morning",color: Colors.white,fw: FontWeight.w400,size: 16),          
                                      ],         
                                   ),
                              ),
                            
                            
                           
                            const SizedBox(width: 16,),
                              IconButton(icon: const Icon(Iconsax.search_normal,color: Colors.white,), onPressed: (){
                               controller.toggleTextFieldVisibility();
                              }),
                        ],
                      ),
                      Obx(() {
                        return controller.isTextFieldVisible.value
                          ? Padding(
                padding: const EdgeInsets.all(24.0),
                child: Container(
                  height: 45,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              )
                    : Container(); // You can return an empty container or some other widget when not visible.
              }),
                      // Padding(
                      //   padding: const EdgeInsets.all(24.0),
                      //   child: Container(
                      //     // padding: const EdgeInsets.all(30),
                      //     height: 45,
                      //     child: TextFormField(
                      //       decoration: const InputDecoration(
                      //         enabledBorder: UnderlineInputBorder(
                      //           borderSide: BorderSide(color: Colors.transparent),
                      //         ),
                      //         focusedBorder: UnderlineInputBorder(
                      //           borderSide: BorderSide(color: Colors.white)
                      //         ),
                      //         )
                      //       ),
                                    
                      //     ),
                      //   ),
                      
                      Obx(
                        () => Align(
                          alignment: const Alignment(0,-0.7),
                          
                          child: Image.asset(imagePath["${weatherServicesController.weatherDescription}" ?? "N/A"] ?? "assets/img/default.png" ),),
                      ),
                      const SizedBox(height: 16,),
                      SizedBox(
                        height: 450,
                       
                        child:  Obx(
                          () => Column(
                                children: [
                                  AppText(data: weatherServicesController.temperature.value!=0 ?
                                  "${weatherServicesController.temperature.value}°" : "28",
                                  color: Colors.white,fw: FontWeight.w800,size: 48,),
                                  AppText(data: weatherServicesController.weatherDescription.value!= "Snow" ?
                                  "${weatherServicesController.weatherDescription}": "Snow",
                                  color: Colors.white,fw: FontWeight.w400,size: 16),
                                  AppText(data: DateTime.now().toString(),color: Colors.white,fw: FontWeight.w400,size: 16),
                                  const SizedBox(height: 16,),
                                
                                  Container(
                                    padding:const EdgeInsets.all(16),
                                    height: 200,
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(20)
                                    ),
                                    child: Column(
                                              
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Image.asset("assets/img/temperature-high.png",height: 55),
                                            
                                            Obx(
                                              () =>Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  AppText(data: "Temp Max",color: Colors.white,fw: FontWeight.w600,size: 14,),
                                                  AppText(data: weatherServicesController.tempMax.value!=0 ?
                                                  "${weatherServicesController.tempMax.value}°" : "32",
                                                  color: Colors.white,fw: FontWeight.w600,size: 14,)
                                                ],
                                              ),
                                            ),
                                            const SizedBox(width: 16,),
                                                Image.asset("assets/img/temperature-low.png",height: 55),
                                            
                                            Obx(
                                              () => Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  AppText(data: "Temp Min",color: Colors.white,fw: FontWeight.w600,size: 14,),
                                                  AppText(data:weatherServicesController.tempMin.value!=0 ?
                                                  "${weatherServicesController.tempMin.value}°" : "32" ,
                                                  color: Colors.white,fw: FontWeight.w600,size: 14,)
                                                ],
                                              ),
                                            )
                                              
                                          ],
                                        ),
                                        const SizedBox(height: 16,),
                                        CustomDivider(
                                          startIndent: 20,
                                          endIndent: 20,
                                          color: Colors.white,
                                          thickness: 1,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Image.asset("assets/img/sun.png",height: 55),
                                            
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                AppText(data: "Sunrise",color: Colors.white,fw: FontWeight.w600,size: 14,),
                                                AppText(data: "32°",color: Colors.white,fw: FontWeight.w600,size: 14,)
                                              ],
                                            ),
                                            const SizedBox(width: 16,),
                                                Image.asset("assets/img/moon.png",height: 55),
                                            
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                AppText(data: "Sunset",color: Colors.white,fw: FontWeight.w600,size: 14,),
                                                AppText(data: "32°",color: Colors.white,fw: FontWeight.w600,size: 14,)
                                              ],
                                            )
                                              
                                          ],
                                        ),
                                        
                                      ],
                                    ),
                                    )
                                              
                                ],
                              ),
                        ),
                            
                            
                        ),
                      
                    ],
                  ),
                )
                ),
            ),
          ],
        ),
      ),
      );
      
   
  }
}