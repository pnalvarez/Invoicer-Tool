import Combine

extension Publisher {
    func mapDistinct<Value: Equatable>(
        _ keyPath: KeyPath<Output, Value>,
        removeDuplicates: Bool = true
    ) -> AnyPublisher<Value, Failure> {
        let mapped = self
            .map(keyPath)

        if removeDuplicates {
            return mapped
                .removeDuplicates()
                .dropFirst()
                .eraseToAnyPublisher()
        } else {
            return mapped
                .dropFirst()
                .eraseToAnyPublisher()
        }
    }
}
