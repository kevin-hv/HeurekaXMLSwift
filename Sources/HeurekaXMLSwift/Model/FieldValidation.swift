//
//  FieldValidation.swift
//
//
//  Created by Kevin Varga on 12/03/2024.
//

import Foundation

enum FieldValidation {
    case shopItemId
    case shopItemProduct
    case videoUrl
    case vat
    case ean
    case isbn
    case itemGroupId
    case gift
    case specialService
    case salesVoucherCode
    case salesVoucherDesc
    
    var regex : String {
        switch self {
        case .shopItemId: return "^([0-9]|[A-Z]|[a-z]|-|_){1,36}$"
        case .shopItemProduct: return "^.{0,200}$"
        case .videoUrl: return "^((?:https?:)?//)?((?:www|m).)?((?:youtube(-nocookie)?.com|youtu.be)).*$"
        case .vat: return "^.*%$"
        case .ean: return "^[0-9]{13}$"
        case .isbn: return "^(?=(?:\\D*\\d){10}(?:(?:\\D*\\d){3})?$)[\\d-]+$"
        case .itemGroupId: return "^([0-9]|[A-Z]|[a-z]|-|_){1,36}$"
        case .gift: return "^.{1,250}$"
        case .specialService: return "^.{1,128}$"
        case .salesVoucherCode: return "^.{1,24}$"
        case .salesVoucherDesc: return "^.{1,128}$"
        }
    }
}
