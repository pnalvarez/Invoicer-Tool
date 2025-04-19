import Combine

extension Publisher {
    func mapDistinct<Value: Equatable>(_ keyPath: KeyPath<Output, Value>) -> AnyPublisher<Value, Failure> {
            self
                .map(keyPath)
                .removeDuplicates()
                .dropFirst()
                .eraseToAnyPublisher()
        }
}
