//
//  EditProductsController.swift
//  A2_FA_iOS_Satnam_C0798066
//
//  Created by SatnamSingh on 24/05/21.
//

import UIKit
import CoreData

class EditProductsController: UIViewController {

    //following are textFields and textView variables
    @IBOutlet weak var productNameField: UITextField!
    @IBOutlet weak var productIdField: UITextField!
    @IBOutlet weak var providerNameField: UITextField!
    @IBOutlet weak var productPriceField: UITextField!
    @IBOutlet weak var productdescriptionField: UITextView!
    
    //Global variables to save fields data
    private var name : String = ""
    private var id : String = ""
    private var provider : String = ""
    private var price : Double = 0
    private var productDescription: String = ""
    
    //context of core data
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private var isProviderPresent = false
    private var providerPresent = [Provider]()
    var product : Product?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.toolbar.isHidden = true
        productNameField.text = product?.productName
        productIdField.text = product?.productID
        providerNameField.text = product?.provider?.name
        productPriceField.text = "\(product?.productPrice ?? 0)"
        productdescriptionField.text = product?.productDescription
    }
    
    @IBAction func saveProduct(_ sender: UIButton) {
        guard checkValidation() else { return }
        deletePreviousProduct()
        addProducts(productName: name, productId: id, providerName: provider, price: price, description: productDescription)
        self.navigationController?.popViewController(animated: true)
    }
    
    func deletePreviousProduct() {
        do {
            context.delete(self.product!)
            try context.save()
        } catch  {
            print(error)
        }
    }
    
    //MARK:- Check fields and for validation
    func checkValidation() -> Bool {
        name = productNameField.text ?? ""
        id = productIdField.text ?? ""
        provider = providerNameField.text ?? ""
        price = Double(productPriceField.text ?? "-1") ?? -1
        productDescription = productdescriptionField.text ?? ""
        if name == "" || id == "" || provider == "" || productDescription == "" || price < 0{
            let alert = UIAlertController(title: "Invalid Values", message: "Please Fill all the Fields Properly", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return false
        }
        return true
    }
    
    //MARK: - Add product and check provider is present
    func addProducts(productName:String,productId:String,providerName:String,price:Double,description:String) {
        isProviderPresent = hasProvider(providerName: providerName)
        if !isProviderPresent {
            // following to add provider and save it
            let newProvider = Provider(context: self.context)
            newProvider.name = providerName
            do {
                try context.save()
                print("new provider create - \(newProvider.name ?? "")")
            } catch  {
                print(error)
            }
            //following to add product and save
            let product = Product(context: self.context)
            product.productName = productName
            product.productID = productId
            product.provider = newProvider
            product.productPrice = price
            product.productDescription = description
            do {
                try context.save()
                print("new product added :- \(product.productName ?? "")")
            } catch  {
                print(error)
            }
        }else{
            // if provider is already present add product and save
            let product = Product(context: self.context)
            product.productName = productName
            product.productID = productId
            product.provider = providerPresent[0]
            product.productPrice = price
            product.productDescription = description
            do {
                try context.save()
                print("new product added :- \(product.productName ?? "")")
            } catch  {
                print(error)
            }
        }
    }
    
    func hasProvider(providerName:String) -> Bool  {
        let request : NSFetchRequest<Provider> = Provider.fetchRequest()
        let predicate = NSPredicate(format: "name CONTAINS[cd] %@", providerName)
        request.predicate = predicate
        do {
            providerPresent = try self.context.fetch(request)
        } catch  {
            print(error)
        }
        if providerPresent.count == 0 {
            print("has no provider")
            return false
        }else{
            print("provider is present")
            return true
        }
    }
}
