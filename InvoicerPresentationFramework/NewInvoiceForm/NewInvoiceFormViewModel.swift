import Combine

final class NewInvoiceFormViewModel: ObservableObject {
    private let coordinator: NewInvoiceFormCoordinatorProtocol
    @Published var state: NewInvoiceFormState = .init()
    private var cancellables: Set<AnyCancellable> = []
    
    init(coordinator: NewInvoiceFormCoordinatorProtocol) {
        self.coordinator = coordinator
        setUpFieldValidation()
    }
    
    func didTapBack() {
        coordinator.navigateBack()
    }
    
    func didTapCTA() {
        state.shouldDisplayIssueDatePicker = true
    }
    
    private func setUpFieldValidation() {
        $state
            .mapDistinct(\.invoiceId)
            .sink { [weak self] invoiceId in
                guard let self else { return }
                self.state.invoiceIdError = invoiceId.isEmpty ? "Invoice ID is required" : nil
            }
            .store(in: &cancellables)
        
        $state
            .mapDistinct(\.issueDate)
            .sink { [weak self] issueDate in
                guard let self else { return }
                state.issueDate = issueDate
            
                if state.dueDate < issueDate {
                    state.dueDateError = "Due date should be after issue date"
                }
            }
            .store(in: &cancellables)
        
        $state
            .mapDistinct(\.dueDate)
            .sink { [weak self] dueDate in
                guard let self else { return }
                state.dueDate = dueDate
                if dueDate < state.issueDate {
                    state.dueDateError = "Due date should be after issue date"
                }
            }
            .store(in: &cancellables)
        
        Publishers.CombineLatest3(
            $state.mapDistinct(\.invoiceIdError),
            $state.mapDistinct(\.issueDateError),
            $state.mapDistinct(\.dueDateError)
        ).sink { [weak self] (invoiceIdError, issueDateError, dueDateError) in
            guard let self else { return }
            state.ctaEnabled = invoiceIdError == nil && issueDateError == nil && dueDateError == nil
        }
        .store(in: &cancellables)
    }
}
