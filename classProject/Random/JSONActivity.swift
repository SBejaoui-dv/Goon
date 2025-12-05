////
////  JSONActivity.swift
////  classProject
////
////  Created by Sebastian Bejaoui on 11/7/25.
//// https://chatgpt.com/share/69115eb8-fc80-800d-bd46-73efee00c8ef
//
//
//
//Consider the Following JSON Structure
//{
//"cod": "200",
//"message": 0,
//"cnt": 40,
//    
//    "list":[
//            {
//            "dt": 1661871600,
//            "main": {"temp": 296.76,"feels_like": 296.98,"temp_min": 296.76,"temp_max": 297.87,"pressure": 1015,"sea_level": 1015,"grnd_level": 933,"humidity": 69,"temp_kf": -1.11 },
//            "weather": [ { "id": 500, "main": "Rain", "description": "light rain", "icon": "10d" } ],
//            "clouds": { "all": 100 },
//            "wind": { "speed": 0.62, "deg": 349, "gust": 1.18 }
//            }
//    ]
//}
//
//
///*
//Objects: WeatherResponse, WeatherEntry, WeatherData, CloudsData, WindData, MainData
//Arrays: list, weather,
//key-value pairs: everything else
//*/
//
//// List is an array
//
//struct WeatherResponse: Decodable {
//    let cod: String
//    let message: Int
//    let cnt: Int
//    
//    //each element inside list array represents one weather entry
//    let list: [WeatherEntry]
//}
//
//struct WeatherEntry: Decodable {
//    let dt: Int
//    let main: MainData
//    let weather: [WeatherData]
//    let clouds: CloudsData
//    let wind: WindData
//}
//
//
//struct MainData: Decodable {
//    let temp: Double
//    let feels_like: Double
//    let temp_min: Double
//    let temp_max: Double
//    let pressure: Int
//    let sea_level: Int?
//    let grnd_level: Int?
//    let humidity: Int
//    let temp_kf: Double?
//}
//    
//
//struct WeatherData: Decodable {
//    let id: Int
//    let main: String
//    let description: String
//    let icon: String
//}
//
//struct CloudsData: Decodable {
//    let all: Int
//}
//
//struct WindData: Decodable {
//    let speed: Double
//    let deg: Int
//    let gust: Double
//}
//
//
