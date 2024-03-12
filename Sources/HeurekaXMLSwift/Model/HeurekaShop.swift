//
//  HeurekaShop.swift
//
//
//  Created by Kevin Varga on 12/03/2024.
//

import Foundation

public struct HeurekaShop : Codable, Equatable {
    public let shopItems : [ShopItem]
    
    public enum CodingKeys: String, CodingKey {
        case shopItems = "SHOPITEM"
    }
    
    public init(shopItems: [ShopItem]) {
        self.shopItems = shopItems
    }
}

public struct ShopItem : Codable, Equatable {
    
    public enum Error : Swift.Error {
        case itemIdIncorrectFormat
        case productIncorrectFormat
        case videoUrlIncorrectFormat
        case vatIncorrectFormat
        case eanIncorrectFormat
        case isbnIncorrectFormat
        case itemGroupIdIncorrectFormat
        case accessoryItemIdIncorrectFormat
        case giftIncorrectFormat
        case tooManySpecialServices
        case specialServiceInvalidFormat
    }
    
    let itemId : String
    let productName : String
    let product : String?
    let description: String
    let url : URL
    let imgUrl : URL
    let alternativeImageUrls : [URL]
    let videoUrl : URL?
    let priceVat : String
    let heurekaCpc : String?
    let vat : String?
    let itemType : String?
    let param : [Param]
    let manufacturer : String
    let categoryText : String
    let ean : String?
    let productNo : String?
    let isbn: String?
    let deliveryDate : Int?
    let delivery : [Delivery]
    let itemGroupId : String?
    let accessory : [String]
    let dues : String?
    let gift: [String]
    let specialService : [String]
    let salesVoucher: SalesVoucher?
    let extendedWarranty : ExtendedWarranty?
    
    public enum CodingKeys: String, CodingKey {
        case itemId = "ITEM_ID"
        case productName = "PRODUCTNAME"
        case product = "PRODUCT"
        case productNo = "PRODUCTNO"
        case description = "DESCRIPTION"
        case url = "URL"
        case imgUrl = "IMGURL"
        case alternativeImageUrls = "IMGURL_ALTERNATIVE"
        case videoUrl = "VIDEO_URL"
        case priceVat = "PRICE_VAT"
        case vat = "VAT"
        case itemType = "ITEM_TYPE"
        case param = "PARAM"
        case manufacturer = "MANUFACTURER"
        case categoryText = "CATEGORYTEXT"
        case ean = "EAN"
        case isbn = "ISBN"
        case heurekaCpc = "HEUREKA_CPC"
        case deliveryDate = "DELIVERY_DATE"
        case delivery = "DELIVERY"
        case itemGroupId = "ITEMGROUP_ID"
        case accessory = "ACCESSORY"
        case dues = "DUES"
        case gift = "GIFT"
        case specialService = "SPECIAL_SERVICE"
        case salesVoucher = "SALES_VOUCHER"
        case extendedWarranty = "EXTENDED_WARRANTY"
    }
    
    public init(
        itemId: String,
        productName: String,
        product: String? = nil,
        productNo: String? = nil,
        description: String,
        url: URL,
        imgUrl: URL,
        alternativeImageUrls: [URL] = [],
        videoUrl: URL? = nil,
        priceVat: String,
        vat: String? = nil,
        itemType: String? = nil,
        params: [Param],
        manufacturer: String,
        categoryText: String,
        ean: String? = nil,
        isbn: String? = nil,
        heurekaCpc : String? = nil,
        deliveryDate: Int?,
        delivery: [Delivery],
        itemGroupId: String?,
        accessory: [String] = [],
        dues: String? = nil,
        gift: [String] = [],
        specialService: [String] = [],
        extendedWarranty: ExtendedWarranty? = nil,
        salesVoucher: SalesVoucher? = nil
    ) throws {
        guard itemId.matches(of: try Regex(FieldValidation.shopItemId.regex)).count == 1 else {
            throw Error.itemIdIncorrectFormat
        }
        
        if let product {
            guard product.matches(of: try Regex(FieldValidation.shopItemProduct.regex)).count == 1 else {
                throw Error.itemIdIncorrectFormat
            }
        }
        
        if let videoUrl {
            guard videoUrl.absoluteString.matches(of: try Regex(FieldValidation.videoUrl.regex)).count == 1 else {
                throw Error.videoUrlIncorrectFormat
            }
        }
        
        if let vat {
            guard vat.matches(of: try Regex(FieldValidation.vat.regex)).count == 1 else {
                throw Error.vatIncorrectFormat
            }
        }
        
        if let ean {
            guard ean.matches(of: try Regex(FieldValidation.ean.regex)).count == 1 else {
                throw Error.eanIncorrectFormat
            }
        }
        
        if let isbn {
            guard isbn.matches(of: try Regex(FieldValidation.isbn.regex)).count == 1 else {
                throw Error.isbnIncorrectFormat
            }
        }
        
        if let itemGroupId {
            guard itemGroupId.matches(of: try Regex(FieldValidation.itemGroupId.regex)).count == 1 else {
                throw Error.itemGroupIdIncorrectFormat
            }
        }
        
        let allAccessoryIdsCorrect = try accessory.allSatisfy{ accessoryItemId in
            return accessoryItemId.matches(of: try Regex(FieldValidation.shopItemId.regex)).count == 1
        }
        
        guard allAccessoryIdsCorrect else {
            throw Error.accessoryItemIdIncorrectFormat
        }
        
        let allGiftsCorrect = try gift.allSatisfy{ gift in
            return gift.matches(of: try Regex(FieldValidation.gift.regex)).count == 1
        }
        
        guard allGiftsCorrect else {
            throw Error.giftIncorrectFormat
        }
        
        guard specialService.count < 6 else {
            throw Error.tooManySpecialServices
        }
        
        let allSpecialServiceCorrect = try specialService.allSatisfy{ service in
            return service.matches(of: try Regex(FieldValidation.specialService.regex)).count == 1
        }
        
        guard allSpecialServiceCorrect else {
            throw Error.specialServiceInvalidFormat
        }
        
        self.itemId = itemId
        self.productName = productName
        self.product = product
        self.productNo = productNo
        self.description = description
        self.url = url
        self.imgUrl = imgUrl
        self.alternativeImageUrls = alternativeImageUrls
        self.videoUrl = videoUrl
        self.priceVat = priceVat
        self.vat = vat
        self.itemType = itemType
        self.param = params
        self.manufacturer = manufacturer
        self.categoryText = categoryText
        self.ean = ean
        self.isbn = isbn
        self.heurekaCpc = heurekaCpc
        self.deliveryDate = deliveryDate
        self.delivery = delivery
        self.itemGroupId = itemGroupId
        self.accessory = accessory
        self.dues = dues
        self.gift = gift
        self.specialService = specialService
        self.extendedWarranty = extendedWarranty
        self.salesVoucher = salesVoucher
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let itemId = try container.decode(String.self, forKey: .itemId)
        let productName = try container.decode(String.self, forKey: .productName)
        let product = try container.decodeIfPresent(String.self, forKey: .product)
        let productNo = try container.decodeIfPresent(String.self, forKey: .productNo)
        let description = try container.decode(String.self, forKey: .description)
        let url = try container.decode(URL.self, forKey: .url)
        let imgUrl = try container.decode(URL.self, forKey: .imgUrl)
        let alternativeImageUrls = try container.decodeIfPresent([URL].self, forKey: .alternativeImageUrls) ?? []
        let videoUrl = try container.decodeIfPresent(URL.self, forKey: .videoUrl)
        let priceVat = try container.decode(String.self, forKey: .priceVat)
        let vat = try container.decodeIfPresent(String.self, forKey: .vat)
        let itemType = try container.decodeIfPresent(String.self, forKey: .itemType)
        let params = try container.decodeIfPresent([Param].self, forKey: .param) ?? []
        let manufacturer = try container.decode(String.self, forKey: .manufacturer)
        let categoryText = try container.decode(String.self, forKey: .categoryText)
        let ean = try container.decodeIfPresent(String.self, forKey: .ean)
        let isbn = try container.decodeIfPresent(String.self, forKey: .isbn)
        let heurekaCpc = try container.decodeIfPresent(String.self, forKey: .heurekaCpc)
        let deliveryDate = try container.decodeIfPresent(Int.self, forKey: .deliveryDate)
        let delivery = try container.decodeIfPresent([Delivery].self, forKey: .delivery) ?? []
        let itemGroupId = try container.decodeIfPresent(String.self, forKey: .itemGroupId)
        let accessories = try container.decodeIfPresent([String].self, forKey: .accessory) ?? []
        let dues = try container.decodeIfPresent(String.self, forKey: .dues)
        let gift = try container.decodeIfPresent([String].self, forKey: .gift) ?? []
        let specialServices = try container.decodeIfPresent([String].self, forKey: .specialService) ?? []
        let extendedWarranty = try container.decodeIfPresent(ExtendedWarranty.self, forKey: .extendedWarranty)
        let salesVoucher = try container.decodeIfPresent(SalesVoucher.self, forKey: .salesVoucher)
        
        try self.init(
            itemId: itemId,
            productName: productName,
            product: product,
            productNo: productNo,
            description: description,
            url: url,
            imgUrl: imgUrl,
            alternativeImageUrls: alternativeImageUrls,
            videoUrl: videoUrl,
            priceVat: priceVat,
            vat: vat,
            itemType: itemType,
            params: params,
            manufacturer: manufacturer,
            categoryText: categoryText,
            ean: ean,
            isbn: isbn,
            heurekaCpc: heurekaCpc,
            deliveryDate: deliveryDate,
            delivery: delivery,
            itemGroupId: itemGroupId,
            accessory: accessories,
            dues: dues,
            gift: gift,
            specialService: specialServices,
            extendedWarranty: extendedWarranty,
            salesVoucher: salesVoucher
        )
    }
}

public struct Param : Codable, Equatable {
    let paramName : String
    let val : String
    
    public enum CodingKeys: String, CodingKey {
        case paramName = "PARAM_NAME"
        case val = "VAL"
    }
}

public struct Delivery : Codable, Equatable {
    let deliveryId : String
    let deliveryPrice : String
    let deliveryPriceCod: String
    
    public enum CodingKeys: String, CodingKey {
        case deliveryId = "DELIVERY_ID"
        case deliveryPrice = "DELIVERY_PRICE"
        case deliveryPriceCod = "DELIVERY_PRICE_COD"
    }
}

public struct SalesVoucher : Codable, Equatable {
    public enum Error : Swift.Error {
        case codeInvalidFormat
        case descInvalidFormat
    }
    
    let code : String
    let desc : String
    
    enum CodingKeys: String, CodingKey {
        case code = "CODE"
        case desc = "DESC"
    }
    
    init(
        code : String,
        desc : String
    ) throws{
        
        guard code.matches(of: try Regex(FieldValidation.salesVoucherCode.regex)).count == 1 else {
            throw Error.codeInvalidFormat
        }
        
        guard desc.matches(of: try Regex(FieldValidation.salesVoucherDesc.regex)).count == 1 else {
            throw Error.descInvalidFormat
        }
        
        self.code = code
        self.desc = desc
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let code = try container.decode(String.self, forKey: .code)
        let desc = try container.decode(String.self, forKey: .desc)
        
        try self.init(
            code: code,
            desc: desc
        )
    }
    
}

public struct ExtendedWarranty : Codable, Equatable {
    let val : Int
    let desc : String
    
    enum CodingKeys: String, CodingKey {
        case val = "VAL"
        case desc = "DESC"
    }
    
    public init(
        val: Int,
        desc: String
    ) throws {
        self.val = val
        self.desc = desc
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let val = try container.decode(Int.self, forKey: .val)
        let desc = try container.decode(String.self, forKey: .desc)
        
        try self.init(
            val: val,
            desc: desc
        )
    }
}
