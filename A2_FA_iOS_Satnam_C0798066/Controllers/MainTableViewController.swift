//
//  MainTableViewController.swift
//  A2_FA_iOS_Satnam_C0798066
//
//  Created by SatnamSingh on 24/05/21.
//

import UIKit
import CoreData

class MainTableViewController: UITableViewController {

    @IBOutlet weak var productToggleButton: UIBarButtonItem!
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var providersList : [Provider] = [Provider]()
    var productsList : [Product] = [Product]()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    private var isProvider : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.navigationItem.title = "Products"
        self.showSearchBar()
        //Following is the Initial Data, this will delete all the data from core data
        //Initial data will be loaded in core data
        //Comment this if you got data or try to load you own data after closing
        Data.createInitialData()
        self.loadProducts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadProducts()
        self.loadProvider()
        self.tableView.reloadData()
        self.navigationController?.toolbar.isHidden = false
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        productToggleButton.isEnabled = !editing
        addButton.isEnabled = !editing
    }

    @IBAction func productToggleFunction(_ sender: UIBarButtonItem) {
        isProvider = !isProvider
        if isProvider {
            sender.title = "Show Products"
            self.navigationItem.title = "Providers"
            self.loadProvider()
            self.tableView.reloadData()
        }else{
            sender.title = "Show Providers"
            self.navigationItem.title = "Products"
            self.loadProducts()
            self.tableView.reloadData()
        }
    }
  
    //MARK: - Load and Delete Data
    func loadProvider(predicate : NSPredicate? = nil)  {
        let request : NSFetchRequest<Provider> = Provider.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        if predicate != nil {
            request.predicate = predicate
        }
        do {
            self.providersList = try self.context.fetch(request)
        } catch  {
            print(error)
        }
    }
    
    func loadProducts(predicate : NSPredicate? = nil)  {
        let request : NSFetchRequest<Product> = Product.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "productName", ascending: true)]
        if predicate != nil {
            request.predicate = predicate
        }
        do {
            self.productsList = try self.context.fetch(request)
        } catch  {
            print(error)
        }
    }
    
    func deleteProduct(product:Product) {
        do {
            context.delete(product)
            try context.save()
        } catch  {
            print(error)
        }
    }
    
    func deleteProvider(provider:Provider){
        do {
            context.delete(provider)
            try context.save()
        } catch  {
            print(error)
        }
    }
    
    //Function to add new product into Core data
    @IBAction func addFunction(_ sender: UIBarButtonItem) {
        let destinationView = self.storyboard?.instantiateViewController(withIdentifier: "AddProductView") as! AddProductViewController
        destinationView.mainView = self
        self.present(destinationView, animated: true, completion: nil)
    }
    
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isProvider{
            return providersList.count
        }else{
            return productsList.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "main_table_cell", for: indexPath)
        if isProvider{
            cell.textLabel?.text = providersList[indexPath.row].name
            cell.detailTextLabel?.text = "\(providersList[indexPath.row].products?.count ?? 0) - products"
            cell.imageView?.image = UIImage(systemName: "folder")
        }else{
            cell.textLabel?.text = productsList[indexPath.row].productName
            cell.detailTextLabel?.text = "Price:- $\(productsList[indexPath.row].productPrice)"
            cell.imageView?.image = UIImage(systemName: "pencil")
        }
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alert = UIAlertController(title: "Are you sure?", message: "Delete Product", preferredStyle: .actionSheet)
            let deleteButton = UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
                if self.isProvider {
                    self.deleteProvider(provider: self.providersList[indexPath.row])
                    self.loadProvider()
                }else{
                    self.deleteProduct(product: self.productsList[indexPath.row])
                    self.loadProducts()
                }
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
        if isProvider {
            let destinationView = self.storyboard?.instantiateViewController(identifier: "ViewProductsView") as! ViewProductsTableViewController
            destinationView.provider = providersList[indexPath.row]
            self.navigationController?.pushViewController(destinationView, animated: true)
        }else{
            let destinationView = self.storyboard?.instantiateViewController(identifier: "EditProductView") as! EditProductsController
            destinationView.product = productsList[indexPath.row]
            self.navigationController?.pushViewController(destinationView, animated: true)
        }
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
            self.loadProvider()
            self.tableView.reloadData()
        }else{
            if isProvider{
                let predicate = NSPredicate(format: "name CONTAINS[cd] %@", text)
                self.loadProvider(predicate: predicate)
            }else{
                let predicate = NSPredicate(format: "productName CONTAINS[cd] %@", text)
                self.loadProducts(predicate: predicate)
            }
            self.tableView.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.loadProvider()
        self.loadProducts()
        self.tableView.reloadData()
    }
    
}
