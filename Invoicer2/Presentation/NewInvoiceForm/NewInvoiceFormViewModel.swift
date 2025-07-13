import Combine
import Foundation

final class NewInvoiceFormViewModel: ObservableObject {
    private let coordinator: NewInvoiceFormCoordinatorProtocol
    @Published var state: NewInvoiceFormState = .init()
    @Published var shouldDisplayIssueDatePicker: Bool = false
    @Published var shouldDisplayDueDatePicker: Bool = false
    @Published var issueDate: Date = Date()
    @Published var dueDate: Date = Date()
    
    @Published var issueDateError: String?
    @Published var dueDateError: String?
    private var cancellables: Set<AnyCancellable> = []
    
    init(coordinator: NewInvoiceFormCoordinatorProtocol) {
        self.coordinator = coordinator
        setUpFieldValidation()
    }
    
    func didTapBack() {
        coordinator.navigateBack()
    }
    
    func didTapCTA() {
        shouldDisplayIssueDatePicker = true
    }
    
    private func setUpFieldValidation() {
        $state
            .mapDistinct(\.invoiceId)
            .sink { [weak self] invoiceId in
                guard let self else { return }
                self.state.invoiceIdError = invoiceId.isEmpty ? "Invoice ID is required" : nil
            }
            .store(in: &cancellables)
        
        $issueDate
            .sink { [weak self] value in
                guard let self else { return }
                dueDateError = nil
                dueDate = value.plus(days: 7)
            }
            .store(in: &cancellables)
        
        $dueDate
            .sink { [weak self] value in
                guard let self else { return }
                dueDateError = value < issueDate ? "Due date should be after issue date" : nil
            }
            .store(in: &cancellables)
        
        Publishers.CombineLatest3(
            $state.mapDistinct(\.invoiceIdError),
            $issueDateError,
            $dueDateError
        ).sink { [weak self] (invoiceIdError, issueDateError, dueDateError) in
            guard let self else { return }
            state.ctaEnabled = invoiceIdError == nil && issueDateError == nil && dueDateError == nil
        }
        .store(in: &cancellables)
    }
}
