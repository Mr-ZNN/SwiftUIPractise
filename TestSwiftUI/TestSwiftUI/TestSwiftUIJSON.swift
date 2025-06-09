//
//  TestSwiftUIJSON.swift
//  TestSwiftUI
//
//  Created by Neil on 5/6/25.
//

import Foundation
import SwiftUI

let json = """
{
    "messages": [
        {
            "name": "zhangsan",
            "location" : {
                "country": "Chian",
            },
            "cityName": "Guangzhou"
        },
        {
            "name": "lisi",
            "location" : {
                "country": "Chian",
            },
            "cityName": "Xi'an"
        },
        {
            "name": "wangwu",
            "location" : {
                "country": "Chian",
            },
            "cityName": "Shenzhen"
        }
    ]
}
"""

struct MessageArrays: Codable {
    var messages: [PersonalInformation]
    
}
struct PersonalInformation: Codable {
    var name: String
    var country: String
    var city: String
    
    enum CodingKeys: String, CodingKey {
        case name
        //将Json的"location"映射为"country"
        case country = "location"
        //将Json的"cityName"映射为"city"
        case city = "cityName"
    }
    enum locationKeys: String, CodingKey {
        case country
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        
        //先解析location，再解析country
        let location = try container.nestedContainer(keyedBy: locationKeys.self, forKey: .country)
        self.country = try location.decode(String.self, forKey: .country)
        
        self.city = try container.decode(String.self, forKey: .city)
    }
}

class TestSwiftUIJSON: NSObject {
    static func testJson() {
        let decoder = JSONDecoder()
        if let jsonData = json.data(using: .utf8) {
            do {
                let messageArrays = try decoder.decode(MessageArrays.self, from: jsonData)
                for message in messageArrays.messages {
                    print(message)
                }
                /*
                 打印结果：
                 PersonalInformation(name: "zhangsan", country: "Chian", city: "Guangzhou")
                 PersonalInformation(name: "lisi", country: "Chian", city: "Xi\'an")
                 PersonalInformation(name: "wangwu", country: "Chian", city: "Shenzhen")
                 */
            } catch {
                print(error)
            }
        }
    }
}

struct TestSwiftUIJSONView: View {
    var body: some View {
        Button {
            TestSwiftUIJSON.testJson()
        } label: {
            Text("解析Json数据")
                .font(.system(size: 18))
                .foregroundStyle(.white)
                .padding()
                .background(.black)
        }
    }
}
