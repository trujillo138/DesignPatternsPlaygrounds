import UIKit
import PlaygroundSupport

final class CommandPlaygroundView: UIViewController {
    var openCommand: Command?
    var saveCommand: Command?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let view = UIView()
        view.backgroundColor = .lightGray
        let openButton = UIButton(frame: CGRect(x: 0.0, y: 0.0, width: 100, height: 50))
        openButton.addTarget(self, action: #selector(open(sender:)), for: .touchUpInside)
        openButton.setTitle("Open", for: .normal)
        let saveButton = UIButton(frame: CGRect(x: 0.0, y: 50.0, width: 100, height: 50))
        saveButton.addTarget(self, action: #selector(save(sender:)), for: .touchUpInside)
        saveButton.setTitle("Save", for: .normal)
        let stackView = UIStackView(frame: CGRect(x: 0.0, y: 0.0, width: 300, height: 50))
        stackView.axis = .horizontal
        stackView.addArrangedSubview(openButton)
        stackView.addArrangedSubview(saveButton)
        view.addSubview(stackView)
        self.view = view
    }
    
    @objc func open(sender: Any) {
        openCommand?.execute()
    }
    
    @objc func save(sender: Any) {
        saveCommand?.execute()
    }
}

protocol Command {
    func execute()
}


struct OpenCommand: Command {
    func execute() {
        print("Open files")
    }
}

struct SaveCommand: Command {
    func execute() {
        print("Save state of file")
    }
}
let vc = CommandPlaygroundView()
vc.openCommand = OpenCommand()
vc.saveCommand = SaveCommand()

PlaygroundPage.current.liveView = vc
