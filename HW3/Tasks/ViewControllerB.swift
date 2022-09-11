

//  b) Текстовое поле для ввода поисковой строки. Реализуйте симуляцию «отложенного» серверного запроса при вводе текста: если не было внесено никаких изменений в текстовое поле в течение 0,5 секунд, то в консоль должно выводиться: «Отправка запроса для <введенный текст в текстовое поле>».


import UIKit

class ViewControllerB: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.reactive.text
                .ignoreNils()
                .throttle(for: 0.5).map{ text in
                    if text == "" { return "" }
                        else { return "Запрос направлен - \(text)"}
                }.bind(to: label.reactive.text)
    }
}
