

// a) Два текстовых поля. Логин и пароль, под ними лейбл и ниже кнопка «Отправить». В лейбл выводится «некорректная почта», если введённая почта некорректна. Если почта корректна, но пароль меньше шести символов, выводится: «Слишком короткий пароль». В противном случае ничего не выводится. Кнопка «Отправить» активна, если введена корректная почта и пароль не менее шести символов.

import Foundation
import UIKit
import Bond
import ReactiveKit

class ViewControllerA: UIViewController {
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    
    func isValidEmail(_ email: String) -> Bool {
           let emailCondition = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
           let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailCondition)
           return emailPredicate.evaluate(with: email)
       }
       
       override func viewDidLoad() {
           super.viewDidLoad()
           let signal = combineLatest(loginTextField.reactive.text, passwordTextField.reactive.text)
           let signalToLabel = signal.map {
               email, password -> String in
               guard let email = email, let password = password
               else {
                   return "Логин или пароль неверны"
               }
               if !self.isValidEmail(email) {
                   return "Проверьте логин"
               }
               else if password.count < 6 {
                   return "Пароль менее 6 символов"
               }
               else {
                   return ""
               }
           }
           signalToLabel.bind(to: label.reactive.text).dispose(in: reactive.bag)
           let signalToButton = signal.map { email, password -> Bool in
               guard let email = email, let password = password
               else {
                   return false
               }
               return self.isValidEmail(email) && password.count >= 6
           }
           signalToButton.bind(to: button.reactive.isEnabled).dispose(in: reactive.bag)
       }
       
       override func viewDidDisappear(_ animated: Bool) {
           super.viewDidDisappear(animated)
           reactive.bag.dispose()
       }
   }
