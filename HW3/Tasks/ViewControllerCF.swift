
// c) UITableView с выводом 20 разных имён людей и две кнопки. Одна кнопка добавляет новое случайное имя в начало списка, вторая — удаляет последнее имя. Список реактивно связан с UITableView.
// f) Для задачи «c» добавьте поисковую строку. При вводе текста в поисковой строке, если текст не изменялся в течение двух секунд, выполните фильтрацию имён по введённой поисковой строке (с помощью оператора throttle). Такой подход применяется в реальных приложениях при поиске, который отправляет поисковый запрос на сервер, — чтобы не перегружать сервер и поисковая строка отправлялась на сервер, только когда пользователь закончит ввод (или сделает паузу во вводе).


import UIKit
import Bond

class ViewControllerCF: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    let filteredNames = MutableObservableArray<String>()
    
    var names = MutableObservableArray(["Саша", "Никита", "Дима", "Миша","Настя","Лена","Яна","Маша","Максим","Андрей","Алексей","Денис","Вика","Женя","Иван","Илья","Ольга","Вероника","Георгий","Поля"])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.keyboardDismissMode = .onDrag
        
        filteredNames.bind(to: tableView){(dataSource, indexPath,tableView)  -> UITableViewCell in
        let cell = tableView.dequeueReusableCell(withIdentifier: "C-Cell") as! C_TableViewCell
        cell.label.text = dataSource[indexPath.row]
        return cell
    }
        
        searchBar.reactive.text
                    .ignoreNils()
                    .removeDuplicates()
                    .throttle(for: 2)
                    .observeNext { [self] text in
                        text.count > 0
                            ? self.names.filterCollection { $0.contains(text) }.bind(to: filteredNames)
                            : self.names.bind(to: filteredNames)
                    }.dispose(in: reactive.bag)
    }
    
    @IBAction func add(_ sender: Any) { filteredNames.insert(names.array.randomElement() ?? "Helena", at: 0) }
    @IBAction func remove(_ sender: Any) { filteredNames.removeLast() }
    
    override func viewWillDisappear(_ animated: Bool) { reactive.bag.dispose() }
}
