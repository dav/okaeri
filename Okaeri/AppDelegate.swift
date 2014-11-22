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
    var showMenuItem : NSMenuItem = NSMenuItem()
    var isShowing : Bool = false
    var okaeriMgr : OkaeriManager?
    
    func applicationDidFinishLaunching(aNotification: NSNotification?) {
        println("Application did finish launching.")
        self.window!.orderOut(self)
        self.isShowing = false
        
        okaeriMgr = OkaeriManager()
        println("OkaeriManager: \(okaeriMgr).")
    }
    
    func applicationWillTerminate(aNotification: NSNotification) {
    }

    override func awakeFromNib() {
        println("awakeFromNib.")
        let bundleInfo : NSDictionary = NSBundle.mainBundle().infoDictionary!
        let versionString : AnyObject! = bundleInfo["CFBundleShortVersionString"]
        titleLabel.stringValue = "Okaeri おかえり v\(versionString)"
        
        statusBarItem = statusBar.statusItemWithLength(-1)
        statusBarItem.menu = menu
        statusBarItem.title = "お"
        
        showMenuItem = self.addMenuItem("Show", action: "toggleWindowVisibility:")
        self.addMenuItem("Quit", action: "userRequestedQuit:")
    }
}

extension AppDelegate {
    func addMenuItem(title: String, action: String) -> NSMenuItem {
        let menuItem : NSMenuItem = NSMenuItem()
        menuItem.title = title
        menuItem.action = Selector(action)
        menuItem.keyEquivalent = ""
        menu.addItem(menuItem)
        return menuItem
    }

    func toggleWindowVisibility(sender: AnyObject) {
        // TODO not sure why this won't compile: if (self.window!.occlusionState & NSWindowOcclusionStateVisible == 0) {
        if (self.isShowing) {
            self.window!.orderOut(self)
            self.isShowing = false
        } else {
            self.window!.orderFront(self)
            self.isShowing = true
        }
        showMenuItem.state = self.isShowing ? NSOnState : NSOffState
    }

    func userRequestedQuit(sender: AnyObject) {
        NSApplication.sharedApplication().terminate(self)
    }
}
