//
//  GetDataOperation.swift
//  SocialProject
//
//  Created by Irina Kuligina on 17.01.2022.
//
import Foundation
import Alamofire

class GetDataOperation: AsyncOperation {
    private var request: DataRequest
    var data: Data?
    
    init(request: DataRequest) {
        self.request = request
        super.init()
    }
    
    override func main() {
        request.responseData(queue: DispatchQueue.global()) { [weak self] response in
            self?.data = response.data
            self?.state = .finished
        }
    }
    
    override func cancel() {
        request.cancel()
        super.cancel()
    }
}
