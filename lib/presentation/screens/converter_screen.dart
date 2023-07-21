import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:r7_currency_converter/app/app_colors.dart';
import 'package:r7_currency_converter/app/app_strings.dart';
import 'package:http/http.dart' as http;
import 'package:r7_currency_converter/data/models/currency_model.dart';
import '../../app/app_text_styles.dart';
import '../../data/currency_converter_remote_data_source.dart';

class ConverterScreen extends StatefulWidget {
  ConverterScreen({super.key});

  @override
  State<ConverterScreen> createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
  String defaultImageUrl= "https://cdn.britannica.com/33/4833-004-828A9A84/Flag-United-States-of-America.jpg";

  String selectedCurrencyCode = "USD";

  String convertedValue = "0";
  final List<CurrencyModel> currencies = [];
 
  @override
  void initState(){
    super.initState();
    CurrencyConverterRemoteDataSource.listAllAvailableCurrencies().then(
          (value){
            currencies.addAll(value);
            print("from then ${value.length}");
          },
        onError: (error){
            print("from error ${error.toString()}");
        }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.currencyConverter,
          style: AppTextStyles.appBarTextStyle,
        ),
        backgroundColor: AppColors.mainRedColor,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 32,horizontal: 16),
        children: [
          32.verticalSpace,
          Row(
            children: [
              //button
              Expanded(
                flex: 1,
                child:  InkWell(
                  onTap: (){
                    showModalBottomSheet(
                      context: context,
                      builder: (ctx){
                        return Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 32,vertical: 16),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8),
                              )
                          ),
                          height: 700,
                          child: ListView.separated(
                            itemCount: currencies.length,
                            itemBuilder: (context,index){
                              return InkWell(
                                onTap: (){
                                  selectedCurrencyCode =currencies[index].code??"USD";
                                  Navigator.pop(context);
                                  setState(() {});
                                },
                                child: Row(
                                  children: [
                                    // currency name
                                    Text(currencies[index].name??"",
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                    Spacer(),
                                    // symbol
                                    Text(currencies[index].symbol??""),
                                    const SizedBox(width: 6,),
                                    //code
                                    Text(currencies[index].code??""),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (BuildContext context, int index) {
                              return Divider(
                                color: Colors.blue,
                              );
                           },
                          ),
                        );
                      },
                    );
                  },
                  child: SizedBox(
                    height: 40.h,
                    child: Center(
                      child: Text(
                        selectedCurrencyCode,
                        style: TextStyle(
                          fontSize: 20.sp,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // SizedBox(width: 16.w,),
              16.horizontalSpace,
              Expanded(
                flex: 2,
                child:  SizedBox(
                  height: 40.h,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
            ],
          ),
          32.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //button
              Container(
                color: Colors.purple,
                width: 40,
                height: 40,
              ),
              Text("0"),
            ],
          ),
          64.verticalSpace,
          TextButton(
            //TODO: call controller method
            onPressed: ()async{
              // final uri  =  Uri.parse("https://api.freecurrencyapi.com/v1/latest?apikey=N8na7dQL8kt7phAWoSS4brbPX97Ubjo9ydW8JyMN&currencies=EUR");
              Uri uri= Uri(
                scheme: "https",
                host: "api.freecurrencyapi.com",
                path: "v1/latest",
                queryParameters: {
                  "apikey":"N8na7dQL8kt7phAWoSS4brbPX97Ubjo9ydW8JyMN",
                  "currencies":'EUR',
                },
              );
              print(uri);
              var response = await http.get(uri);
              print(response.statusCode);
              print(response.body);
              if(response.statusCode==200){
                var decodedBody = json.decode(response.body) as Map<String,dynamic>;
                num rate  = decodedBody["data"]['EUR'];
                print(rate);
                // double convertedValue = convertedDouble/rate.toDouble();
                // print(convertedValue);
              }
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(AppColors.mainRedColor),
            ),
            child: Text(
              AppStrings.convert,
              style: AppTextStyles.titleTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}

