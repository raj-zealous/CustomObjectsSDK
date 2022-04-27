//
//  MainVC.swift
//  CustomObjectsSDK
//
//  Created by Deepak Tagadiya on 13/04/22.
//

import UIKit
import Alamofire


typealias ServiceResponse = ([String: Any], Data, Error?) -> Void


struct responseData: Decodable {
    var support: supportData
    var data: dataModal
}

struct supportData: Decodable {
    var url, text: String
}

struct dataModal: Decodable {
    var name, color, pantone_value: String
    var id, year: Int
}

public protocol MainVCDelegate {
    func submitDataBtnPressed(flag: Bool)
    func backBtnPressed()
}

public final class MainVC: UIViewController {
    
    //MARK: - outlets
    @IBOutlet weak var menuBGView: UIView!
    @IBOutlet weak var lblFormTitle: UILabel!
    @IBOutlet weak var mainFormTable: UITableView!
    @IBOutlet weak var btnBackControl: UIControl!
    @IBOutlet weak var btnSubmitControl: UIControl!
    
    //MARK: - variables
    public var mainVCDelegate: MainVCDelegate?
    public var numberOfSection: Int = 2
    public var numberOfRow: Int = 3
    public var btnCornerRadiusValue: CGFloat = 12
    public var tblCellBGColor: UIColor = .white
    public var tblSectionCellBGColor: UIColor = .white
    private var selectedOption: String = "N/A"
    private var frameworkBundle: Bundle? {
        let bundle = Bundle(for: CustomObjectsSDK.MainVC.self)
        return bundle
    }

    //MARK: - defualt methods
    public override func viewDidLoad() {
        super.viewDidLoad()

        self.initialization()
    }
    
    public override func viewDidDisappear(_ animated: Bool) {
        self.removeKeyBoardObserver()
    }
    
    //MARK: - custom methods
    private func initialization() {
        overrideUserInterfaceStyle = .light
       
        self.addKeyBoardObserver()
        
        
        self.mainFormTable.register(UINib(nibName: "SectionHeaderTblCell", bundle: self.frameworkBundle), forCellReuseIdentifier: "SectionHeaderTblCell")
        self.mainFormTable.register(UINib(nibName: "TextFieldTblCell", bundle: self.frameworkBundle), forCellReuseIdentifier: "TextFieldTblCell")
        self.mainFormTable.register(UINib(nibName: "AlertRowTblCell", bundle: self.frameworkBundle), forCellReuseIdentifier: "AlertRowTblCell")
        self.mainFormTable.register(UINib(nibName: "TextViewTblCell", bundle: self.frameworkBundle), forCellReuseIdentifier: "TextViewTblCell")
        self.mainFormTable.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: self.mainFormTable.frame.size.width, height: 1))
        self.mainFormTable.separatorStyle = .none
        if #available(iOS 15.0, *) {
            self.mainFormTable.sectionHeaderTopPadding = 0.0
        }
        
        self.btnBackControl.cornerRadius = self.btnCornerRadiusValue
        self.btnSubmitControl.cornerRadius = self.btnCornerRadiusValue
    }
    
    private func addKeyBoardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardShows), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func removeKeyBoardObserver() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardShows(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            self.mainFormTable.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height + 40, right: 0)
        }
        
        UIView.animate(withDuration: 0.2, animations: {
            self.mainFormTable.layoutIfNeeded()
        }, completion: nil)
    }
    
    @objc func keyboardHide(notification: Notification) {
        self.mainFormTable.contentInset = .zero
    
        UIView.animate(withDuration: 0.2, animations: {
            self.mainFormTable.layoutIfNeeded()
        }, completion: nil)
    }
}

//MARK: - Button actions
extension MainVC {
    @IBAction func btnSubmitData(_ sender: UIControl) {
//        self.apiCall(selectedUrl: "https://reqres.in/api/products/3", methods: .get, param: [:]) {
//            (response, result, error) in
//
//            print("response:- ", response)
//            print("result:- ", result)
//            print("error:- ", error as Any)
//        }
        
        self.apiCall("https://reqres.in/api/products/3", methods: .get) { (response, data, error) in
            print("response: \(response)")
//            if let _ = response["errorStatus"] {
//                print("Error")
//                // Toast error message
//            } else {
                do {
                    let resData = try JSONDecoder().decode(responseData.self, from: data)
                    print("resData: \(resData)")
                } catch {
                    print("error: \(error)")
                    // Toast error message
                }
//            }
        }
        self.mainVCDelegate?.submitDataBtnPressed(flag: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnBackPressed(_ sender: UIControl) {
        self.mainVCDelegate?.backBtnPressed()
        self.dismiss(animated: true, completion: nil)
    }
}

//MARK: - table view delegate and data source methods
extension MainVC: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return self.numberOfSection
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.numberOfRow
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SectionHeaderTblCell") as! SectionHeaderTblCell
        cell.lblValue.text = "Section number: \(section)"
        return cell.contentView.frame.height
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SectionHeaderTblCell") as! SectionHeaderTblCell
        cell.lblValue.text = "Section number: \(section)"
        cell.sectionCellBGView.backgroundColor = self.tblSectionCellBGColor
        return cell.contentView
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldTblCell") as! TextFieldTblCell
            cell.lblTitle.text = "Title number: \(indexPath.row)"
            cell.txtFieldValue.text = "Value number: \(indexPath.row)"
            cell.cellBGView.backgroundColor = self.tblCellBGColor
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextViewTblCell") as! TextViewTblCell
            cell.lblTitle.text = "Title number: \(indexPath.row)"
            cell.txtViewValue.text = "Value number: \(indexPath.row)"
            cell.cellBGView.backgroundColor = self.tblCellBGColor
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AlertRowTblCell") as! AlertRowTblCell
            cell.lblOptionTitle.text = "Selected option"
            cell.lblOptionValue.text = self.selectedOption
            cell.btnOpenAlertAction.tag = (indexPath.section * 1000) + indexPath.row    //section and row
            cell.btnOpenAlertAction.addTarget(self, action: #selector(self.btnOpenActionControl(_ :)), for: .touchUpInside)
            return cell
        }
    }
    
    @objc func btnOpenActionControl(_ sender: UIControl) {
        let alert = UIAlertController(title: "Select any one", message: "", preferredStyle: UIAlertController.Style.alert)
        for i in 1..<6 {
            alert.addAction(UIAlertAction(title: "Item \(i)", style: .default, handler: {
                (UIAlertAction) in
                DispatchQueue.main.async {
                    self.selectedOption = "Item \(i)"
                    let section = sender.tag/1000
                    let row = sender.tag % 1000
                    self.mainFormTable.reloadRows(at: [IndexPath(row: row, section: section)], with: .none)
                }
            }))
        }
        
        alert.addAction(UIAlertAction(title: "Cancle", style: .cancel, handler: {
            (UIAlertAction) in
            
        }))

        self.present(alert, animated: true, completion: nil)
    }
}

extension MainVC {

    private func apiCall(_ selectedUrl: String, methods: HTTPMethod = .post, param: [String: Any] = [:], completionHandler:@escaping ServiceResponse) {
        
        var headers = HTTPHeaders()
        headers = ["accept": "application/json"]
        let utilityQueue = DispatchQueue.global(qos: .utility)
        AF.request(selectedUrl, method: methods, parameters: param, headers: headers)
            .responseDecodable(of: responseData.self, queue: utilityQueue) { result in
                
                switch result.result {
                case .success(_):
                    completionHandler([:], result.data!, nil)
                case .failure(let error):
//                    print(error)
                    
                    let response: [String: Any] = [
                        "responseCode": result.error?.responseCode as Any,
                        "errorStatus": true,
                        "message": error.localizedDescription
                    ]
                    print("RESPONSE JSON: - \(response)")
                    completionHandler(response, result.data!, nil)
                }
            }
    }
}
