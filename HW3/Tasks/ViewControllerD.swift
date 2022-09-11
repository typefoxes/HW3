//d) Лейбл и кнопку. В лейбле выводится значение counter (по умолчанию 0), при нажатии counter увеличивается на 1.

import UIKit
import Bond
import ReactiveKit

class ViewControllerD: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    
    var counter = Property(0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button.reactive.tap.with(latestFrom: counter)
              .compactMap { $1 }
              .map { $0 + 1 }
              .bind(to: counter)
                
        counter.map { String($0) }
               .bind(to: label.reactive.text)
    }
}
