//
//  Data.swift
//  A2_FA_iOS_Satnam_C0798066
//
//  Created by SatnamSingh on 24/05/21.
//

import Foundation
import CoreData
import UIKit

class Data {
    private static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private static var providers : [Provider] = [Provider]()
    private static var productList : [Product] = [Product]()
    private static func deleteData(){
        let request : NSFetchRequest<Provider> = Provider.fetchRequest()
        var providers : [Provider] = [Provider]()
        do {
            //following is to fetch all providers
            providers = try context.fetch(request)
            //following loop is to delete all the providers
            for provider in providers {
                context.delete(provider)
                try context.save()
            }
        } catch  {
            print(error)
        }
    }
    
    static func createInitialData(){
        deleteData()
        createProvider()
        productList = [Product(context: context),Product(context: context),Product(context: context),Product(context: context),Product(context: context),Product(context: context),Product(context: context),Product(context: context),Product(context: context),Product(context: context),Product(context: context),Product(context: context),Product(context: context),Product(context: context),Product(context: context),Product(context: context),Product(context: context),Product(context: context),Product(context: context),Product(context: context),Product(context: context),Product(context: context),Product(context: context),Product(context: context),Product(context: context)]
        
        //Following is data of products
        productList[0].productName = "Macbook Pro"
        productList[0].productID = "C-3432"
        productList[0].productPrice = 1500
        productList[0].productDescription = "Premium Product with m1 Chip set"
        productList[0].provider = providers[0]
        
        productList[1].productName = "iPad Pro"
        productList[1].productID = "D-9234"
        productList[1].productPrice = 999
        productList[1].productDescription = "Pressure sensitive pencil with fast processor"
        productList[1].provider = providers[0]
        
        productList[2].productName = "iPhone XR"
        productList[2].productID = "E-3292"
        productList[2].productPrice = 769
        productList[2].productDescription = "Face recognition feature A12 Bionic"
        productList[2].provider = providers[0]
        
        productList[3].productName = "iPhone 11"
        productList[3].productID = "A-8232"
        productList[3].productPrice = 919
        productList[3].productDescription = "Dual camera with A13 Bionic"
        productList[3].provider = providers[0]
        
        productList[4].productName = "iPhone 12"
        productList[4].productID = "B-1252"
        productList[4].productPrice = 979
        productList[4].productDescription = "Triple camera and 5G support with A14 Bionic"
        productList[4].provider = providers[0]
        
        productList[5].productName = "iPhone 12 Pro Max"
        productList[5].productID = "P-9018"
        productList[5].productPrice = 769
        productList[5].productDescription = "Triple camera and 5G support with large storage and A14 Bionic"
        productList[5].provider = providers[0]
        
        productList[6].productName = "Apple watch series 6"
        productList[6].productID = "C-8723"
        productList[6].productPrice = 600
        productList[6].productDescription = "Oxygen level calculator with AI health monitoring"
        productList[6].provider = providers[0]
        
        productList[7].productName = "HomePod"
        productList[7].productID = "A-9981"
        productList[7].productPrice = 400
        productList[7].productDescription = "Loud speaker with extra bass and high battery capacity"
        productList[7].provider = providers[0]
        
        productList[8].productName = "Microsoft Surface Laptop 4 15-inch"
        productList[8].productID = "B-1123"
        productList[8].productPrice = 1100
        productList[8].productDescription = "256 gb SSD with AMD Ryzen 7 4980U"
        productList[8].provider = providers[1]
        
        productList[9].productName = "Microsoft Surface Pro 7"
        productList[9].productID = "C-3721"
        productList[9].productPrice = 900
        productList[9].productDescription = "Touch screen with Core i7"
        productList[9].provider = providers[1]
        
        productList[10].productName = "Microsoft Surface Pro X"
        productList[10].productID = "D-8831"
        productList[10].productPrice = 1149
        productList[10].productDescription = "Touch screen with 15 hours of barttery and 128 gb ssd"
        productList[10].provider = providers[1]
        
        productList[11].productName = "Microsoft Surface Laptop Go"
        productList[11].productID = "W-2371"
        productList[11].productPrice = 964
        productList[11].productDescription = "Touchscreen with core i5"
        productList[11].provider = providers[1]
        
        productList[12].productName = "Microsoft Surface Book 3"
        productList[12].productID = "G-5564"
        productList[12].productPrice = 1849
        productList[12].productDescription = "Touch screen with Ryzen 5"
        productList[12].provider = providers[1]
        
        productList[13].productName = "Microsoft Surface Pro 6"
        productList[13].productID = "E-6650"
        productList[13].productPrice = 1779
        productList[13].productDescription = "Core i7 and 256 HDD"
        productList[13].provider = providers[1]
        
        productList[14].productName = "Microsoft Surface 2 LQN-00038"
        productList[14].productID = "A-1831"
        productList[14].productPrice = 1649
        productList[14].productDescription = "GTX 1050 and 256 gb SSD with core i5"
        productList[14].provider = providers[1]
        
        productList[15].productName = "Microsoft Surface Pro KLH-00023"
        productList[15].productID = "D-8831"
        productList[15].productPrice = 1569
        productList[15].productDescription = "Touch screen with core i5"
        productList[15].provider = providers[1]
        
        productList[16].productName = "Asus ROG Zephyrus M16"
        productList[16].productID = "G-7218"
        productList[16].productPrice = 2700
        productList[16].productDescription = "RTX 3070 and 2TB SSD"
        productList[16].provider = providers[2]
        
        productList[17].productName = "Asus ROG Zephyrus S17"
        productList[17].productID = "I-1238"
        productList[17].productPrice = 3000
        productList[17].productDescription = "RTX 3080 and 2TB SSD"
        productList[17].provider = providers[2]
        
        productList[18].productName = "Asus Vivobook Pro 14"
        productList[18].productID = "H-6613"
        productList[18].productPrice = 1500
        productList[18].productDescription = "Ryzen 5 and 16 gb Ram with 512 gb SSD"
        productList[18].provider = providers[2]
        
        productList[19].productName = "Asus tuf a-17"
        productList[19].productID = "U-5521"
        productList[19].productPrice = 1200
        productList[19].productDescription = "Ryzen 5 4600U and 256 SSD"
        productList[19].provider = providers[2]
        
        productList[20].productName = "Asus Vivobook Ultra K15"
        productList[20].productID = "N-2612"
        productList[20].productPrice = 1500
        productList[20].productDescription = "Ryzen 5000 and 512 SSD"
        productList[20].provider = providers[2]
        
        productList[21].productName = "Asus ROG Strix G17"
        productList[21].productID = "H-3212"
        productList[21].productPrice = 2149
        productList[21].productDescription = "512 gb SSD and 16 gb Ram with Ryzen 7"
        productList[21].provider = providers[2]
        
        productList[22].productName = "Asus ZenBook Pro Duo 15"
        productList[22].productID = "T-3212"
        productList[22].productPrice = 3100
        productList[22].productDescription = "32 gb Ram and 1 TB with Core i7"
        productList[22].provider = providers[2]
        
        productList[23].productName = "Asus Tuf Dash F15"
        productList[23].productID = "B-1772"
        productList[23].productPrice = 2000
        productList[23].productDescription = "RTX 3060 and core i7"
        productList[23].provider = providers[2]
        
        productList[23].productName = "Asus Rog Moba 5 Plus"
        productList[23].productID = "V-8829"
        productList[23].productPrice = 3200
        productList[23].productDescription = "1Tb SSD and 16 gb Ram with Ryzen 5000"
        productList[23].provider = providers[2]
        
        productList[24].productName = "Asus Expertbook B1"
        productList[24].productID = "K-7721"
        productList[24].productPrice = 2900
        productList[24].productDescription = "512 gb SSD with core i7"
        productList[24].provider = providers[2]
        do {
            try context.save()
        } catch  {
            print(error)
        }
    }
    
    private static func createProvider(){
        //First provider
        var provider = Provider(context: context)
        providers.append(provider)
        provider.name = "Apple"
        
        //second provider
        provider = Provider(context: context)
        providers.append(provider)
        provider.name = "Microsoft"
        
        //Third provider
        provider = Provider(context: context)
        providers.append(provider)
        provider.name = "Asus"
        do {
            try context.save()
        } catch  {
            print(error)
        }
    }
}
