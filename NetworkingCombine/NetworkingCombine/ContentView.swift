//
//  ContentView.swift
//  NetworkingCombine
//
//  Created by Balraj Verma on 11/30/20.
//

import SwiftUI
import Alamofire
import Combine

struct ContentView: View {
    @ObservedObject var viewModel = ViewModel()

    var body: some View {
        Text("Call API")
            .font(.largeTitle)
            .padding()
            .onTapGesture(count: 1, perform: {
                print("Calling API")
            })
    }
}


//class Abstraction {
//
//    func callAPI<T: Decodable>() -> Void {
//
//    }
//}

class API {
    func callAPI() -> AnyPublisher<[JsonDat] , AFError> {
        let publisher = AF.request("https://jsonplaceholder.typicode.com/posts")
            .publishDecodable(type: [JsonDat].self)
        return publisher.value()
       // print("----->",publisher.value())
        //  //  http://jsonplaceholder.typicode.com/posts
//        return publisher.eraseToAnyPublisher()
    }
}


class ViewModel: ObservableObject {
    var subscriber: AnyCancellable?
    
    init() {
        fetchData()
    }
    
    
    //CallAPi can have a codable type T: codable/decaodeable data which might be result of any json parsed API
    func fetchData() {
        subscriber = API().callAPI()
            //            .mapError({ (error) -> Error in
            //                print(error)
            //                return error
            //            })
            .sink(receiveCompletion: { completion in
                print(completion)
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    fatalError(error.localizedDescription)
                }
                
            }, receiveValue: { data in
                print("--JSON VALUES-->",data)
            })
    }
    
}
