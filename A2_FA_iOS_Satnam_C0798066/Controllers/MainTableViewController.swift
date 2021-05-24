//
//  MainTableViewController.swift
//  A2_FA_iOS_Satnam_C0798066
//
//  Created by SatnamSingh on 24/05/21.
//

import UIKit
import CoreData

class MainTableViewController: UITableViewController {
   
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var productsList : [Product] = [Product]()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    private var isProvider : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.navigationItem.title = "Products"
        self.showSearchBar()
        self.initialData()
        self.tableView.reloadData()
    }
    
    //MARK: - Load and Delete Data
    func loadProducts(predicate : NSPredicate? = nil)  {
        let request : NSFetchRequest<Product> = Product.fetchRequest()
        if predicate != nil {
            request.predicate = predicate
        }
        do {
            self.productsList = try self.context.fetch(request)
        } catch  {
            print(error)
        }
    }
    
    func deleteProvider()  {
        let request : NSFetchRequest<Provider>  = Provider.fetchRequest()
        var providers : [Provider] = [Provider]()
        do{
            providers = try self.context.fetch(request)
        }catch{
            print(error)
        }
        for provider in providers{
            do {
                context.delete(provider)
                try context.save()
            } catch  {
                print(error)
            }
        }
        
    }
    
    func deleteProduct(product:Product) {
        do {
            context.delete(product)
            try context.save()
            print("inside delete")
        } catch  {
            print(error)
        }
    }
    func initialData()  {
        loadProducts()
        for product in productsList {
            deleteProduct(product: product)
        }
        deleteProvider()
        // following to add provider and save it
        let provider1 = Provider(context: self.context)
        provider1.name = "Apple"
        do {
            try context.save()
        } catch  {
            print(error)
        }
        let provider2 = Provider(context: self.context)
        provider2.name = "Microsoft"
        do {
            try context.save()
        } catch  {
            print(error)
        }
        do {
            productsList.removeAll()
            for i in 0...15 {
                let product = Product(context: context)
                if i%2 == 0 {
                    product.provider = provider1
                }else{
                    product.provider = provider2
                }
                product.productName = "Product \(i+1)"
                product.productDescription = "This is product with number \(i+1)"
                product.productPrice = Double((i+1)*100)
                product.productID = "c-\(i*2+1)"
                productsList.append(product)
            }
            try context.save()
        } catch  {
            print(error)
        }
    }
    
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productsList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "main_table_cell", for: indexPath)
       
        cell.textLabel?.text = productsList[indexPath.row].productName
        cell.detailTextLabel?.text = "Provider:- \(productsList[indexPath.row].provider?.name ?? "")"
        cell.imageView?.image = UIImage(systemName: "pencil")
        
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alert = UIAlertController(title: "Are you sure?", message: "Delete note", preferredStyle: .actionSheet)
            let deleteButton = UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
                self.deleteProduct(product: self.productsList[indexPath.row])
                self.loadProducts()
                self.tableView.reloadData()
            })
            let cancelButton = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            alert.addAction(deleteButton)
            alert.addAction(cancelButton)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    //navigating to other controller when user click on table row
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var detail = "\n"
        detail += "Name : - \(productsList[indexPath.row].productName ?? "")\n"
        detail += "ProductId : - \(productsList[indexPath.row].productID ?? "")\n"
        detail += "Price : - \(productsList[indexPath.row].productPrice )\n"
        detail += "Provider : - \(productsList[indexPath.row].provider?.name ?? "")\n"
        detail += "Description : - \(productsList[indexPath.row].productDescription ?? "")\n"
        let alert = UIAlertController(title: "Details", message: detail, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}

//MARK: - search bar delegate methods
extension MainTableViewController: UISearchBarDelegate {

    func showSearchBar() {
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Note"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.searchBar.searchTextField.textColor = .systemBlue
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let text:String = searchBar.text!
        if text.count == 0 {
            self.loadProducts()
            self.tableView.reloadData()
        }else{
            let predicate = NSPredicate(format: "productName CONTAINS[cd] %@", text)
            self.loadProducts(predicate: predicate)
            self.tableView.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.loadProducts()
        self.tableView.reloadData()
    }
    
}
