//
//  ContactsViewController.swift
//  GeoConfess
//
//  Created by Yulian Dobrev on 3/17/16.
//  Copyright © 2016 KTO. All rights reserved.
//

import UIKit
import APAddressBook

final class ContactsViewController : AppViewControllerWithToolbar {

	@IBOutlet weak private var mainView: UIView!
	
	private var contactsTableViewController: ContactsTableViewController!
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		if contactsTableViewController == nil {
			contactsTableViewController = ContactsTableViewController()
			contactsTableViewController.tableView.frame = CGRectMake(
				0,
				0,
				self.view.frame.size.width,
				self.view.frame.size.height - mainView.frame.origin.y)
			self.addChildViewController(contactsTableViewController)
			self.mainView.addSubview(contactsTableViewController.tableView)
		}
	}
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		self.fillContacsTableView()
	}
	
	@IBAction func btnBackTapped(sender: UIButton) {
		self.dismissViewControllerAnimated(true, completion: nil)
	}
	
	func openSettings() {
		let url = NSURL(string: UIApplicationOpenSettingsURLString)
		UIApplication.sharedApplication().openURL(url!)
	}
	
	
	private func fillContacsTableView() {
		let apAddressBook = APAddressBook()
		switch APAddressBook.access() {
		case .Unknown:
			// Application didn't request address book access yet.
			self.loadContacts()
			
		case .Granted:
			// Access granted.
			self.loadContacts()
			
		case .Denied:
			// Access denied or restricted by privacy settings.
			ABAddressBookRequestAccessWithCompletion(apAddressBook) {
				(granted: Bool, error: CFError!) -> Void in
				dispatch_async(dispatch_get_main_queue()) {
					if !granted {
						
						let alert=UIAlertController(title: "", message: "Veuillez autoriser l’accès aux contacts de votre téléphone pour inviter vos ami", preferredStyle: .Alert);
						
						let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
						alert.addAction(defaultAction)
						self.presentViewController(alert, animated: true, completion: nil)
						return
						
					} else {
						let alertController:UIAlertController = UIAlertController(
							title: "",
							message: "Merci d'autoriser l'accès à votre carnet d'adresses.",
							preferredStyle: .Alert)
						let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
						alertController.addAction(defaultAction)
						self.presentViewController(alertController, animated: true, completion: nil)
						return
					}
				}
				//self.loadContacts()
			}
		}
	}
	
	private func loadContacts() {
		let apAddressBook = APAddressBook()
		apAddressBook.loadContacts {
			(contacts: [APContact]?, error: NSError?) in
			if let error = error {
				// TODO: Show error.
				assertionFailure("Error loading contacts: \(error)")
			}
			if let uwrappedContacts = contacts {
				// Do something with contacts.
				self.contactsTableViewController.setarrayContacts(uwrappedContacts as NSArray)
			}
		}
	}
}
