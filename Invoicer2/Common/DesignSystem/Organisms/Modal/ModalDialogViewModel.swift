import SwiftUI
import Combine

protocol ModalView: View {
    associatedtype Content: View
    var shouldDismiss: (() -> Void)? { get set }
    init(viewModel: ModalViewModel, content: @escaping () -> Content)
    init(viewModel: ModalViewModel, content: @escaping () -> Content, shouldDismiss: (() -> Void)?)
}

extension ModalView {
    init(viewModel: ModalViewModel, content: @escaping () -> Content, shouldDismiss: (() -> Void)?) {
        self.init(viewModel: viewModel, content: content)
    }
}

// MARK: - View Model
class ModalViewModel: ObservableObject {
    var fadeInTime: Double = 0.3
    var fadeOutTime: Double = 0.3
    var allowsDismiss = true
    @Published var isPresented = false
}

class ModalHostingController<ContainerType: ModalView>: UIHostingController<ContainerType> {
    
    private(set) var viewModel = ModalViewModel()
    var backgroundColor: UIColor = .clear
    
    var allowsDismiss: Bool {
        get { viewModel.allowsDismiss }
        set { viewModel.allowsDismiss = newValue }
    }
    
    init(content: @escaping () -> ContainerType.Content) {
        super.init(rootView: ContainerType(viewModel: ModalViewModel(), content: content))
        update(content: content)
        self.modalPresentationStyle = .overCurrentContext
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backgroundColor
        viewModel.isPresented = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showDialog()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        viewModel.isPresented = false
        super.viewWillDisappear(animated)
    }
    
    func update(content: @escaping () -> ContainerType.Content) {
        self.rootView = ContainerType(viewModel: viewModel, content: content) { [weak self] in
            self?.dismissDialog()
        }
    }
    
    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func showDialog() {
        self.viewModel.isPresented = true
    }
    
    private func dismissDialog() {
        viewModel.isPresented = false
        dismiss(animated: false)
    }
}
