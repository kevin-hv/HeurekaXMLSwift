import XCTest
@testable import HeurekaXMLFeed

final class HeurekaXMLFeedTests: XCTestCase {
    
    func testLoadXMLData() throws {
        let shop1GoldenData = try Data(contentsOf: try XCTUnwrap(Bundle.module.url(forResource: "Shop1-Golden", withExtension: "xml")))
        
        let shopFromGolden = try HeurekaShop(fromXMLData: shop1GoldenData)
        
        let expectedShop = HeurekaShop(
            shopItems: [
                try XCTUnwrap(
                    .init(
                        itemId: "AB123",
                        productName: "Nokia 5800 XpressMusic",
                        product: "Nokia 5800 XpressMusic",
                        productNo: "RM-559394",
                        description: "Klasický s plným dotykovým užívateľským rozhraním",
                        url: try XCTUnwrap(URL(string: "http://obchod.sk/mobily/nokia-5800-xpressmusic")),
                        imgUrl: try XCTUnwrap(URL(string: "http://obchod.sk/mobily/nokia-5800-xpressmusic/obrazok.jpg")),
                        alternativeImageUrls: [
                            try XCTUnwrap(URL(string: "http://obchod.sk/mobily/nokia-5800-xpressmusic/obrazok2.jpg"))
                        ],
                        videoUrl: try XCTUnwrap(URL(string: "http://www.youtube.com/watch?v=KjR759oWF7w")),
                        priceVat: "240",
                        params: [
                            .init(
                                paramName: "Farba",
                                val: "čierna"
                            )
                        ],
                        manufacturer: "NOKIA",
                        categoryText: "Elektronika | Mobilné telefóny",
                        ean: "6417182041488",
                        heurekaCpc: "0,24",
                        deliveryDate: 2,
                        delivery: [
                            .init(
                                deliveryId: .slovenskaPosta,
                                deliveryPrice: "3",
                                deliveryPriceCod: "5"
                            ),
                            .init(
                                deliveryId: .ppl,
                                deliveryPrice: "3",
                                deliveryPriceCod: "5"
                            )
                        ],
                        itemGroupId: "EF789",
                        accessory: [
                            "CD456"
                        ],
                        gift: [
                            "Púzdro zadarmo"
                        ],
                        specialService: [
                            "Aplikácia ochrannej fólie"
                        ],
                        extendedWarranty: try .init(
                            val: 36,
                            desc: "Záruka na 36 mesiacov"
                        )
                    )
                )
            ]
        )
        
        XCTAssertEqual(shopFromGolden, expectedShop)
    }
    
    func testSaveXMLData() throws{
        let shop = HeurekaShop(
            shopItems: [
                try XCTUnwrap(
                    .init(
                        itemId: "AB123",
                        productName: "Nokia 5800 XpressMusic",
                        product: "Nokia 5800 XpressMusic",
                        productNo: "RM-559394",
                        description: "Klasický s plným dotykovým užívateľským rozhraním",
                        url: try XCTUnwrap(URL(string: "http://obchod.sk/mobily/nokia-5800-xpressmusic")),
                        imgUrl: try XCTUnwrap(URL(string: "http://obchod.sk/mobily/nokia-5800-xpressmusic/obrazok.jpg")),
                        alternativeImageUrls: [
                            try XCTUnwrap(URL(string: "http://obchod.sk/mobily/nokia-5800-xpressmusic/obrazok2.jpg"))
                        ],
                        videoUrl: try XCTUnwrap(URL(string: "http://www.youtube.com/watch?v=KjR759oWF7w")),
                        priceVat: "240",
                        params: [
                            .init(
                                paramName: "Farba",
                                val: "čierna"
                            )
                        ],
                        manufacturer: "NOKIA",
                        categoryText: "Elektronika | Mobilné telefóny",
                        ean: "6417182041488",
                        heurekaCpc: "0,24",
                        deliveryDate: 2,
                        delivery: [
                            .init(
                                deliveryId: .slovenskaPosta,
                                deliveryPrice: "3",
                                deliveryPriceCod: "5"
                            ),
                            .init(
                                deliveryId: .ppl,
                                deliveryPrice: "3",
                                deliveryPriceCod: "5"
                            )
                        ],
                        itemGroupId: "EF789",
                        accessory: [
                            "CD456"
                        ],
                        gift: [
                            "Púzdro zadarmo"
                        ],
                        specialService: [
                            "Aplikácia ochrannej fólie"
                        ],
                        extendedWarranty: try .init(
                            val: 36,
                            desc: "Záruka na 36 mesiacov"
                        )
                    )
                )
            ]
        )
        
        let data = try shop.getAsXMLData()
        let dataAsText = String(data: data, encoding: .utf8)
        
        let expectedData = try Data(contentsOf: try XCTUnwrap(Bundle.module.url(forResource: "Shop1-Golden", withExtension: "xml")))
        let expectedDataAsText = String(data: expectedData, encoding: .utf8)
        
        XCTAssertEqual(dataAsText, expectedDataAsText)
    }
    
    
}
