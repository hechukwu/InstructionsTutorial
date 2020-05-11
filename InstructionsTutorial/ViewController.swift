import UIKit
import Instructions

class ViewController: UIViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var controlButton: UIButton!

    let coachMarksController = CoachMarksController()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.coachMarksController.dataSource = self
        self.coachMarksController.delegate = self

        let skipView = CoachMarkSkipDefaultView()
        skipView.setTitle("Skip", for: .normal)

        self.coachMarksController.skipView = skipView
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !AppManager.getUserSeenAppInstruction() {
            self.coachMarksController.start(in: .window(over: self))
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.coachMarksController.stop(immediately: true)
    }
}

extension ViewController: CoachMarksControllerDataSource, CoachMarksControllerDelegate {

    func numberOfCoachMarks(for coachMarksController: CoachMarksController) -> Int {
        return 4
    }

    func coachMarksController(_ coachMarksController: CoachMarksController, coachMarkAt index: Int) -> CoachMark {
        switch index {
        case 0: return coachMarksController.helper.makeCoachMark(for: segmentedControl)
        case 1: return coachMarksController.helper.makeCoachMark(for: searchTextField)
        case 2: return coachMarksController.helper.makeCoachMark(for: textLabel)
        case 3: return coachMarksController.helper.makeCoachMark(for: controlButton)
        default: return coachMarksController.helper.makeCoachMark()
        }
    }

    func coachMarksController(_ coachMarksController: CoachMarksController, coachMarkViewsAt index: Int, madeFrom coachMark: CoachMark) -> (bodyView: CoachMarkBodyView, arrowView: CoachMarkArrowView?) {
        let coachViews = coachMarksController.helper.makeDefaultCoachViews(withArrow: true, arrowOrientation: coachMark.arrowOrientation)

        switch index {
        case 0:
            coachViews.bodyView.hintLabel.text = "Hello! this is a segmented control you can toggle dark and light mode here!"
            coachViews.bodyView.nextLabel.text = "OK!!"
        case 1:
            coachViews.bodyView.hintLabel.text = "This is a search text field you can search for your favourite texts here."
            coachViews.bodyView.nextLabel.text = "Ok!"
        case 2:
            coachViews.bodyView.hintLabel.text = "Yor search texxt will appear here when you hit enter"
            coachViews.bodyView.nextLabel.text = "OK!"
        case 3:
            coachViews.bodyView.hintLabel.text = "Finally you can hit the control button to view your search details!"
            coachViews.bodyView.nextLabel.text = "Ok!"
        default: break
        }

        return (bodyView: coachViews.bodyView, arrowView: coachViews.arrowView)
    }
}
