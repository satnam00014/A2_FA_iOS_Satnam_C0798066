//
//  ViewProductsTableViewController.swift
//  A2_FA_iOS_Satnam_C0798066
//
//  Created by SatnamSingh on 24/05/21.
//

import UIKit
import CoreData

class ViewProductsTableViewController: UITableViewController {
    var provider : Provider?{
        didSet{
            loadProducts()
        }
    }
    private var productList : [Product] = [Product]()
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.reloadData()
        self.navigationItem.title = "\(provider?.name ?? "")"
        self.navigationController?.toolbar.isHidden = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadProducts()
        self.tableView.reloadData()
    }
    
    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return productList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "view_products_cell", for: indexPath)
        cell.imageView?.image = UIImage(systemName: "pencil")
        cell.textLabel?.text = productList[indexPath.row].productName ?? ""
        cell.detailTextLabel?.text = "price:- $\(productList[indexPath.row].productPrice )"
        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destinationView = self.storyboard?.instantiateViewController(identifier: "EditProductView") as! EditProductsController
        destinationView.product = productList[indexPath.row]
        self.navigationController?.pushViewController(destinationView, animated: true)
    }

    func loadProducts()  {
        let request : NSFetchRequest<Product> = Product.fetchRequest()
        let predicate = NSPredicate(format: "provider.name=%@", self.provider!.name!)
        request.predicate = predicate
        do {
            self.productList = try context.fetch(request)
        } catch  {
            print(error)
        }
    }

}
