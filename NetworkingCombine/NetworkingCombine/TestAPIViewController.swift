























//
//
//
//
//import SwiftUI
//import Combine
//
//
//class Worker {
//   let stringGeneratorResultSubject: PassthroughSubject<String, Error>
//
//   init(stringGeneratorResultSubject: PassthroughSubject<String, Error>) {
//        self.stringGeneratorResultSubject = stringGeneratorResultSubject
//   }
//
//   func generateString() {
//       stringGeneratorResultSubject.send("someValue")
//   }
//}
//
//class A {
//    let workerObj: Worker
//    let workerObjPublisher: AnyPublisher<String, Swift.Error>
//    init(workerObj: Worker, workerObjPublisher: AnyPublisher<String, Swift.Error>) {
//       self.workerObj = workerObj
//       self.workerObjPublisher = workerObjPublisher
//       super.init()
//
//       getString()
//    }
//
//   func getString() {
//      workerObjPublisher.sink { result in
//        // do something with result for
//     }.store(in: &cancellable)
//
//     workerObj.generateString()
//  }
//}
//
//class B {
//    let workerObjPublisher: AnyPublisher<String, Swift.Error>
//    init(workerObjPublisher: AnyPublisher<String, Swift.Error>) {
//       self.workerObjPublisher = workerObjPublisher
//       super.init()
//
//       loadString()
//    }
//
//   func loadString() {
//      workerObjPublisher.sink { result in
//        // do something with result
//     }.store(in: &cancellable)
//   }
//
// }
//
//class Parent {
//   lazy var stringGeneratorResultSubject: PassthroughSubject<String, Swift.Error> = .init()
//   lazy var workerObj: Worker = .init(stringGeneratorResultSubject: stringGeneratorResultSubject)
//   lazy var aObj: A = .init(workerObj: workerObj,
//                            workerObjPublisher: stringGeneratorResultSubject.eraseToAnyPublisher())
//
//   lazy var bObj: B = .init(workerObjPublisher: stringGeneratorResultSubject.eraseToAnyPublisher())
//
//   _ = bObj
//
//   aObj.getString()
//}
