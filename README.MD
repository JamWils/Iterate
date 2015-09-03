# Iterate

Iterate is an app for OS X and iOS that allows you to create/edit Core Animation layers.  It is largely incomplete.  The core functionality exists for the OS X version, while iOS support was being added later on.  The idea was to use Apple's cross-platform libraries to leverage iCloud Documents, Continuity, and Hand-Off for a seemless workflow between both platforms.

The original concept was to allow designers to create various layers, add/edit animations, and then export the code to developers to add to a project.  Perhaps one day it will do just that.

### Minimum Required Versions
You need OS X Yosemite and later or iOS 8.0 and later.  These have not yet been tested on El Captain or iOS 9.

### Why Open Source Iterate?
Simply put, I don't have time to work on this project and I hope that one day it will see the light of day on the App Store.

### Moving Forward
I would gladly accept pull requests to start building this project out.  In the near future I will start building out a feature list and perhaps some GUI mock-ups to show the direction I was aiming for Iterate.

### Can it do anything now?
It certainly can, but the UI is a bit of a mess.  Build the OS X app, and maximize the window.  Hit the plus button, and add an Emitter Layer.  Use the outline view to select the Emitter Cell and start to play with all of the properties.  As of this writing, there is support for the CAEmitterLayer and the CAEmitterCell.  You can add cells within cells and adjust each one to make some ridiculous things.  In addition, I began building out the Core CALayer, and CATransformLayer.  Add a Transform Layer then add an Emitter Layer and have fun.
