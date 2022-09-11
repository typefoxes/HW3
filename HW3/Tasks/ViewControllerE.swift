//  e) Две кнопки и лейбл. Когда на каждую кнопку нажали хотя бы один раз, в лейбл выводится: «Ракета запущена».

import UIKit
import ReactiveKit
import Bond

class ViewControllerE: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    
    private let pressed = Property((false, false))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pressed.filter { $0.0 == true && $0.1 == true }
                    .replaceElements(with: "«Ракета запущена»")
                    .bind(to: label.reactive.text)
                
        button1.reactive.tap.observeNext { self.pressed.value.0 = true }
                    .dispose(in: reactive.bag)
        button2.reactive.tap.observeNext { self.pressed.value.1 = true }
                    .dispose(in: reactive.bag)
    }
    
    override func viewWillDisappear(_ animated: Bool) { reactive.bag.dispose() }

}
