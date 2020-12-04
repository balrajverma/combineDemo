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
    
    func publishData() {
        viewModel.apiNetworkActivitySubscriber = viewModel.Event
            .sink(receiveCompletion: { completion in
                print("Completion from passthrough====", completion)
                
            }, receiveValue: { value in
                print("Value from passthrough====",value)
            })
    }
        
    var body: some View {
        Text("Call API")
            .onAppear( perform: {
                publishData()
            }
            )
            .font(.largeTitle)
            .padding()
            .onTapGesture(count: 1, perform: {
                print("Calling API")
                viewModel.fetchData()
            })
    }
}

class Network {
    func doANetworkFetch() -> AnyPublisher<[JsonDat] , AFError> {
        let publisher = AF.request("https://jsonplaceholder.typicode.com/posts")
            .publishDecodable(type: [JsonDat].self)
        return publisher.value()
    }
}


class ViewModel: ObservableObject {
    var subscriber: AnyCancellable?
    var Event = PassthroughSubject<String, Never>()
    var apiNetworkActivitySubscriber: AnyCancellable?
    
    init() {
        print("Blank Init")
    }
    
    
    //CallAPi can have a codable type T: codable/decaodeable data which might be result of any json parsed API
    func fetchData() {
        subscriber = Network().doANetworkFetch()
            .sink(receiveCompletion: { completion in
                print(completion)
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    fatalError(error.localizedDescription)
                }
            }, receiveValue: { data in
                self.Event.send("5")
               // print("--JSON VALUES-->",data)
            })
    }
    
}
