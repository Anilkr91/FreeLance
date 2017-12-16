//
//  Gloss+NSDate.swift
//  TapHeal
//
//  Created by Rahul Katariya on 18/01/16.
//  Copyright © 2016 ProntoItLabs. All rights reserved.
//


import Gloss

/*
/**
 Convenience operator for decoding JSON to NSDate
 */
public func <~~ (key: String, json: JSON) -> NSDate? {
    return Decoder.decodeDate(key: key)(json)
}

/**
 Convenience operator for encoding NSDate to JSON
 */
public func ~~> (key: String, property: NSDate?) -> JSON? {
    return Encoder.encodeDate(key: key)(property)
}

extension Decoder {
    
    /**
     Returns function to decode JSON to Date
     
     :parameter: key JSON key used to set value
     
     :returns: Function decoding JSON to an optional Date
     */
    public static func decodeDate(key: String) -> JSON -> NSDate? {
        return {
            json in
            
            if let dateDouble = json[key] as? Double {
                return NSDate(timeIntervalSince1970: dateDouble/1000)
            }
            
            return nil
        }
    }
    
}

extension Double {
    /// Rounds the double to decimal places value
    func roundToPlaces(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return round(self * divisor) / divisor
    }
}

extension Encoder {
    
    /**
     Returns function to encode Date as JSON
     
     :parameter: key Key used to create JSON property
     
     :returns: Function encoding Date to optional JSON
     */
    public static func encodeDate(key: String) -> NSDate? -> JSON? {
        return {
            date in
            
            if let date = date {
                return [key : date.timeIntervalSince1970.roundToPlaces(0)*1000]
            }
            
            return nil
        }
    }
} */


import Foundation

    /**
     Set of functions used to encode values to JSON
     */
   public struct Encoder {
    
            // MARK: - Encoders
    
            /**
             Returns function to encode value to JSON
     
            :parameter: key Key used to create JSON property
     
             :returns: Function decoding value to optional JSON
             */
            public static func encode<T>(key: String) -> (T?) -> JSON? {
                   return {
                           property in
            
                           if let property = property as? AnyObject {
                                    return [key : property]
                               }
            
                            return nil
                        }
                }
    
            /**
     0055        Returns function to encode value to JSON
     0056        for objects the conform to the Encodable protocol
     0057
     0058        :parameter: key Key used to create JSON property
     0059
     0060        :returns: Function decoding value to optional JSON
     0061        */
           public static func encodeEncodable<T: Encodable>(key: String) -> (T?) -> JSON? {
                    return {
                            model in
            
                           if let model = model, let json = model.toJSON() {
                                    return [key : json]
                               }
            
                           return nil
                       }
               }
    
        /**
     0075        Returns function to encode date as JSON
     0076
     0077        :parameter: key           Key used to create JSON property
     0078        :parameter: dateFormatter Formatter used to format date string
     0079
     0080        :returns: Function encoding date to optional JSON
     0081        */
            public static func encodeDate(key: String, dateFormatter: DateFormatter) -> (NSDate?) -> JSON? {
                    return {
                            date in
            
                           if let date = date {
                                   return [key : dateFormatter.string(from: date as Date)]
                                }
            
                            return nil
                        }
            }
    
            /**
     0095        Returns function to encode ISO8601 date as JSON
     0096
     0097        :parameter: key           Key used to create JSON property
     0098        :parameter: dateFormatter Formatter used to format date string
     0099
     0100        :returns: Function encoding ISO8601 date to optional JSON
     0101        */
            public static func encodeDateISO8601(key: String) -> (NSDate?) -> JSON? {
                   let dateFormatter = DateFormatter()
                    dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale!
                   dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        
                    return Encoder.encodeDate(key: key, dateFormatter: dateFormatter)
                }
    
            /**
     0111        Returns function to encode enum value as JSON
     0112
     0113        :parameter: key Key used to create JSON property
     0114
     0115        :returns: Function encoding enum value to optional JSON
     0116        */
            public static func encodeEnum<T: RawRepresentable>(key: String) -> (T?) -> JSON? {
                   return {
                            enumValue in
            
                           if let enumValue = enumValue {
                                    return [key : enumValue.rawValue as! AnyObject]
                                }
            
                            return nil
                        }
                }
    
            /**
     0130        Returns function to encode URL as JSON
     0131
     0132        :parameter: key Key used to create JSON property
     0133
     0134        :returns: Function encoding URL to optional JSON
     0135        */
            public static func encodeURL(key: String) -> (NSURL?) -> JSON? {
                    return {
                            url in
            
                            if let url = url {
                                    return [key : url.absoluteString]
                               }
            
                           return nil
                        }
                }
    
            /**
     0149        Returns function to encode array as JSON
     0150
     0151        :parameter: key Key used to create JSON property
     0152
     0153        :returns: Function encoding array to optional JSON
     0154        */
           public static func encodeArray<T>(key: String) -> ([T]?) -> JSON? {
                    return {
                           array in
            
                           if let array = array as? AnyObject {
                                    return [key : array]
                            }
            
                            return nil
                        }
                }
    
            /**
     0168        Returns function to encode array as JSON
     0169        for objects the conform to the Encodable protocol
     0170
     0171        :parameter: key Key used to create JSON property
     0172
     0173        :returns: Function encoding array to optional JSON
     0174        */
            public static func encodeEncodableArray<T: Encodable>(key: String) -> ([T]?) -> JSON? {
                    return {
                            array in
            
                           if let array = array {
                                    var encodedArray: [JSON] = []
                
                                   for model in array {
                                            if let json = model.toJSON() {
                                                    encodedArray.append(json)
                                                }
                                       }
                
                                    return [key : encodedArray]
                                }
            
                            return nil
                        }
                }
    
            /**
     0196         Returns function to encode a [String : Encodable] into JSON
     0197         for objects the conform to the Encodable protocol
     0198
     0199         :parameter: key Key used to create JSON property
     0200
     0201         :returns: Function encoding dictionary to optional JSON
     0202         */
//            public static func encodeEncodableDictionary<T: Encodable>(key: String) -> ([String : T]?) -> JSON? {
//                   return {
//                            dictionary in
//            
//                            guard let dictionary = dictionary else {
//                                   return nil
//                                }
//            
//                            return dictionary.flatMap { (key, value) in
//                                   guard let json = value.toJSON() else {
//                                           return nil
//                                        }
//                
//                                   return (key, json)
//                               }
//                        }
//                }
    
          /**
     0222        Returns function to encode array as JSON
     0223        of enum raw values
     0224
     0225        :parameter: key Key used to create JSON property
     0226
     0227        :returns: Function encoding array to optional JSON
     0228        */
            public static func encodeEnumArray<T: RawRepresentable>(key: String) -> ([T]?) -> JSON? {
                    return {
                            enumValues in
            
                            if let enumValues = enumValues {
                                    var rawValues: [T.RawValue] = []
                
                                   for enumValue in enumValues {
                                           rawValues.append(enumValue.rawValue)
                                        }
                
                                    return [key : rawValues as! AnyObject]
                                }
            
                           return nil
                       }
                }
    
           /**
     0248         Returns function to encode date array as JSON
     0249         
     0250         :parameter: key           Key used to create JSON property
     0251         :parameter: dateFormatter Formatter used to format date string
     0252         
     0253         :returns: Function encoding date array to optional JSON
     0254         */
           public static func encodeDateArray(key: String, dateFormatter: DateFormatter) -> ([NSDate]?) -> JSON? {
                    return {
                           dates in
                        
                            if let dates = dates {
                                   var dateStrings: [String] = []
                
                                  for date in dates {
                                           let dateString = dateFormatter.string(from: date as Date)
                    
                                           dateStrings.append(dateString)
                                        }
                
                                   return [key : dateStrings]
                                }
                        
                            return nil
                       }
               }
    
            /**
     0276         Returns function to encode ISO8601 date array as JSON
     0277         
     0278         :parameter: key           Key used to create JSON property
     0279         :parameter: dateFormatter Formatter used to format date string
     0280         
     0281         :returns: Function encoding ISO8601 date array to optional JSON
     0282         */
            public static func encodeDateISO8601Array(key: String) -> ([NSDate]?) -> JSON? {
                    return Encoder.encodeDateArray(key: key, dateFormatter: GlossDateFormatterISO8601)
                }
    
       }
