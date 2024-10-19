//
//  APIAppUAMExample
//
//
//  Created by Oscar Alvarado 17/10/24
//

import Foundation

final class AddProductController {
    private let apiDataSource = APIDataSource()
    
    func createProduct(_ product: ProductModel) async -> Bool {
        await apiDataSource.createProduct(product)
    }
}
