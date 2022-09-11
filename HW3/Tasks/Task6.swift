// 6. Напишите несколько примеров того, как может образоваться утечка памяти при использовании Rx.

import Foundation
import Bond
class Human {
    weak var friend: Human?
    
    init() {
        print("Human +++++")
    }
    
    deinit {
        print("Human -----")
    }
}
class ViewController: UIViewController {
    
    var processor: (() -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()

  // 1
        processor = { self.dateprint() }
// 2
        let h1 = Human()
        let h2 = Human()
        
        h1.friend = h2
        h2.friend = h1
    }
    
    func dateprint() {
        print(Date())
    }
}
// 3 в целом при любом упоминании self уже идет утечка памяти (если не ставить weak или другие способы очистки)
