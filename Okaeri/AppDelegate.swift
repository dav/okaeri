//  ただいま :: Tadaima
//  おかえり :: Okaeri

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var titleLabel: NSTextField!

    var statusBar = NSStatusBar.systemStatusBar()
    var statusBarItem : NSStatusItem = NSStatusItem()
    var menu: NSMenu = NSMenu()
    var menuItem : NSMenuItem = NSMenuItem()
    var isShowing : Bool = false
    
    func applicationDidFinishLaunching(aNotification: NSNotification?) {
        self.window!.orderOut(self)
        self.isShowing = false
    }
    
    func applicationWillTerminate(aNotification: NSNotification) {
    }

    override func awakeFromNib() {
        titleLabel.stringValue = "Okaeri おかえり"
        
        //Add statusBarItem
        statusBarItem = statusBar.statusItemWithLength(-1)
        statusBarItem.menu = menu
        statusBarItem.title = "お"
        
        //Add menuItem to menu
        menuItem.title = "Show"
        menuItem.action = Selector("toggleWindowVisibility:")
        menuItem.keyEquivalent = ""
        menu.addItem(menuItem)
    }
    
    func toggleWindowVisibility(sender: AnyObject){
        // TODO not sure why this won't compile: if (self.window!.occlusionState & NSWindowOcclusionStateVisible == 0) {
        if (self.isShowing) {
            self.window!.orderOut(self)
            self.isShowing = false
        } else {
            self.window!.orderFront(self)
            self.isShowing = true
        }
        menuItem.state = self.isShowing ? NSOnState : NSOffState
    }

}

